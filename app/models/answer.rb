class Answer < ApplicationRecord
  has_many :details, class_name: 'AnswerDetail'
end
