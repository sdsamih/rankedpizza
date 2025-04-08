import random, string
from flask import Blueprint, request, jsonify
from models import db, Rodizio, Participante

api = Blueprint('api', __name__)

def generate_code(length=6):
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=length))

@api.route('/rodizio', methods=['POST'])
def create_rodizio():
    data = request.get_json()
    code = generate_code()
    rodizio = Rodizio(code=code, name=data['name'])
    db.session.add(rodizio)
    db.session.commit()
    return jsonify({'code': code}), 201

@api.route('/rodizio/<code>/entrar', methods=['POST'])
def join_rodizio(code):
    data = request.get_json()
    rodizio = Rodizio.query.filter_by(code=code).first()
    if not rodizio:
        return jsonify({'error': 'Rodízio não encontrado'}), 404
    participante = Participante(rodizio_id=rodizio.id, username=data['username'])
    db.session.add(participante)
    db.session.commit()
    return jsonify({'message': 'Participante adicionado'}), 200

@api.route('/rodizio/<code>/comer', methods=['POST'])
def comer_pizza(code):
    data = request.get_json()
    rodizio = Rodizio.query.filter_by(code=code).first()
    if not rodizio:
        return jsonify({'error': 'Rodízio não encontrado'}), 404
    participante = Participante.query.filter_by(rodizio_id=rodizio.id, username=data['username']).first()
    if not participante:
        return jsonify({'error': 'Participante não encontrado'}), 404
    participante.slices += 1
    db.session.commit()
    return jsonify({'slices': participante.slices}), 200

@api.route('/rodizio/<code>/leaderboard', methods=['GET'])
def leaderboard(code):
    rodizio = Rodizio.query.filter_by(code=code).first()
    if not rodizio:
        return jsonify({'error': 'Rodízio não encontrado'}), 404
    participantes = Participante.query.filter_by(rodizio_id=rodizio.id).order_by(Participante.slices.desc()).all()
    return jsonify([
        {'username': p.username, 'slices': p.slices}
        for p in participantes
    ])
