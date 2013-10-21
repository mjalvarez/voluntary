class ReplaceUserByPolymorphicResourceInCandidatures < ActiveRecord::Migration
  def up
    add_column :vacancies, :resource_type, :string
    add_column :vacancies, :resource_id, :integer
    
    Vacancy.update_all(resource_type: "User")
    Vacancy.update_all('resource_id = user_id')
    
    remove_column :vacancies, :user_id
    
    add_column :candidatures, :resource_type, :string
    add_column :candidatures, :resource_id, :integer
    
    Candidature.update_all(resource_type: "User")
    Candidature.update_all('resource_id = user_id')
    
    remove_column :candidatures, :user_id
  end

  def down
    add_column :vacancies, :user_id, :integer
    
    Vacancy.where('resource_type = "User"').update_all('user_id = resource_id')
    Vacancy.where('resource_type <> "User"').destroy_all
    
    remove_column :vacancies, :resource_type
    remove_column :vacancies, :resource_id
    
    add_column :candidatures, :user_id, :integer
    
    Candidature.where('resource_type = "User"').update_all('user_id = resource_id')
    Candidature.where('resource_type <> "User"').destroy_all
    
    remove_column :candidatures, :resource_type
    remove_column :candidatures, :resource_id
  end
end
