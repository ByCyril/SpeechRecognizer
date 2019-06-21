
import turicreate as tc

data = tc.SFrame.read_csv('dataset.csv', delimiter=',')

# training_data, test_data = data.random_split(0.8)

model = tc.text_classifier.create(data, 'label', features=['text'], max_iterations=250)

prediction = model.predict(data)

model.save('FeedbackModel.model')

model.export_coreml('FeedbackModel.mlmodel')