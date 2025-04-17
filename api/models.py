from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Rodizio(db.Model):
    __tablename__ = 'rodizio'
    __table_args__ = {'schema': 'rankedpizza'} 
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(6), unique=True, nullable=False)
    name = db.Column(db.String(50), nullable=False)

class Participante(db.Model):
    __tablename__ = 'participante'
    __table_args__ = {'schema': 'rankedpizza'}
    id = db.Column(db.Integer, primary_key=True)
    rodizio_id = db.Column(db.Integer, db.ForeignKey('rankedpizza.rodizio.id'), nullable=False)
    username = db.Column(db.String(50), nullable=False)
    slices = db.Column(db.Integer, default=0)
