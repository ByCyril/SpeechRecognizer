
import turicreate as tc

data = tc.SFrame.read_csv('yelp-data.csv', delimiter=',')

training_data, test_data = data.random_split(0.8)

model = tc.sound_classifier.create(training_data, 'stars', features=['text'])

prediction = model.predict(test_data)

model.save('FeedbackModel.model')

model.export_coreml('FeedbackModel.mlmodel')