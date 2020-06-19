# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_15_165053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alunos", force: :cascade do |t|
    t.integer "cliente_id"
    t.string "nome"
    t.string "rg"
    t.string "cpf"
    t.string "celular"
    t.date "nascimento"
    t.string "pai"
    t.string "mae"
    t.string "nacionalidade"
    t.boolean "ativo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "aulas", force: :cascade do |t|
    t.integer "matricula_id"
    t.integer "horario_id"
    t.boolean "teoria"
    t.boolean "musicalizacao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "circulares", force: :cascade do |t|
    t.string "numero_circular"
    t.date "data_circular"
    t.float "desconto"
    t.float "valor_mensalidade"
    t.float "valor_extra"
    t.boolean "vigente"
    t.float "taxa_matricula"
    t.float "salario_aula"
    t.float "valor_profissionalizante"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.string "rg"
    t.string "cpf"
    t.string "telefone"
    t.string "celular"
    t.string "email"
    t.date "nascimento"
    t.string "bairro"
    t.string "uf"
    t.string "cidade"
    t.string "cep"
    t.string "pai"
    t.string "mae"
    t.string "nacionalidade"
    t.string "profissao"
    t.boolean "ativo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nome"
    t.integer "anos"
    t.boolean "basico"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "despesas", force: :cascade do |t|
    t.integer "id_tipificacao"
    t.string "nome"
    t.float "valor"
    t.datetime "vencimento"
    t.datetime "referencia"
    t.boolean "pago"
    t.string "descricao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "folha_pagamentos", force: :cascade do |t|
    t.integer "professor_id"
    t.integer "user_id"
    t.integer "mes"
    t.integer "ano"
    t.float "salario"
    t.integer "n_aulas"
    t.date "data_aprovacao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "horarios", force: :cascade do |t|
    t.integer "professor_id"
    t.string "dia"
    t.time "horario"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lecionam", force: :cascade do |t|
    t.integer "curso_id"
    t.integer "professor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matinativas", force: :cascade do |t|
    t.integer "aluno_id"
    t.integer "curso_id"
    t.datetime "data_matricula"
    t.datetime "termino_matricula"
    t.integer "ano"
    t.float "valor_mensal"
    t.integer "teoria_ano"
    t.integer "id_ativa"
    t.integer "professor_id"
    t.integer "professor_teoria_id"
    t.integer "dia_pratica"
    t.integer "dia_teoria"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matriculas", force: :cascade do |t|
    t.integer "aluno_id"
    t.integer "curso_id"
    t.datetime "data_matricula"
    t.integer "ano"
    t.float "valor_mensal"
    t.integer "teoria_ano"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "professores", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.string "rg"
    t.string "cpf"
    t.string "telefone"
    t.string "celular"
    t.string "email"
    t.date "nascimento"
    t.string "bairro"
    t.string "uf"
    t.string "cidade"
    t.string "cep"
    t.string "pai"
    t.string "mae"
    t.string "nacionalidade"
    t.string "profissao"
    t.string "escolaridade"
    t.float "valor_aula"
    t.boolean "ativo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "salarios", force: :cascade do |t|
    t.integer "professor_id"
    t.float "valor"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tipificacoes", force: :cascade do |t|
    t.string "tipo"
    t.string "descricao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt", null: false
    t.string "name", null: false
    t.string "level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
