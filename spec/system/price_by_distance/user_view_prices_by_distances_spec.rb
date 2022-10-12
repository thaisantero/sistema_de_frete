require 'rails_helper'

describe 'Usuário visualiza tabela de preços por distância de modelo de transporte' do
  it 'sendo usuário regular' do
    user = User.create!(name: 'User', email: 'user@sistemadefrete.com.br', password: 'password')
    tm = TransportModel.create!(
      name: 'Bike', minimum_distance: 1, maximum_distance: 10, minimum_weight: 1,
      maximum_weight: 10, fixed_rate: 5, status: 'disabled'
    )
    PriceByDistance.create!(start_range: 1, end_range: 5, distance_tax: 2.2, transport_model: tm)
    PriceByDistance.create!(start_range: 5, end_range: 10, distance_tax: 2.8, transport_model: tm)

    login_as(user)
    visit root_path
    click_on 'Modelos de Transporte'
    click_on 'Bike'

    expect(page).to have_content 'Distância Mínima'
    expect(page).to have_content 'Distância Máxima'
    expect(page).to have_content 'Taxa por Distância'
    expect(page).to have_content '1 km'
    expect(page).to have_content '5 km'
    expect(page).to have_content 'R$2,20'
    expect(page).to have_content '10 km'
    expect(page).to have_content 'R$2,80'
  end

  it 'sendo administrador' do
    user = User.create!(name: 'Joao', email: 'joao@sistemadefrete.com.br', password: 'password', role: :admin)
    tm = TransportModel.create!(
      name: 'Bike', minimum_distance: 1, maximum_distance: 10, minimum_weight: 1,
      maximum_weight: 10, fixed_rate: 5, status: 'disabled'
    )
    PriceByDistance.create!(start_range: 1, end_range: 5, distance_tax: 2.2, transport_model: tm)
    PriceByDistance.create!(start_range: 5, end_range: 10, distance_tax: 2.8, transport_model: tm)

    login_as(user)
    visit root_path
    click_on 'Modelos de Transporte'
    click_on 'Bike'

    expect(page).to have_content 'Distância Mínima'
    expect(page).to have_content 'Distância Máxima'
    expect(page).to have_content 'Taxa por Distância'
    expect(page).to have_content '1 km'
    expect(page).to have_content '5 km'
    expect(page).to have_content 'R$2,20'
    expect(page).to have_content '10 km'
    expect(page).to have_content 'R$2,80'
  end
end
