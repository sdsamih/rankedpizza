from flask import Flask
from models import db
from sqlalchemy import text
import os

def init_db(app):
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://postgres:admin@db:5432/rankedpizza' #URI do banco
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    print("DATABASE_URL:", app.config['SQLALCHEMY_DATABASE_URI'])

    db.init_app(app)

    with app.app_context():
        # Inicializar conexao
        connection = db.engine.connect()

        try:
            # Se o schema nao existir tenta criar
            connection.execute(text("CREATE SCHEMA IF NOT EXISTS rankedpizza"))
            connection.commit()
        except Exception as e:
            print(f"Erro na criacao: {e}") #(se já existir o schema retorna erro, precisa do catch)
        finally:
            connection.close()

        # Criar as tabelas dos models
        db.create_all()
