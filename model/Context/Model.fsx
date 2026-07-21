F#
//Step 1. Create an ML Context
let ctx = MLContext()

//Step 2. Read in the input data from a text file
let trainingData = ctx.Data.LoadFromTextFile<ModelInput>(dataPath, hasHeader=true)

//Step 3. Build your data processing and training pipeline
let scope = ctx.BinaryClassification.Trainers.LbfgsLogisticRegression("Label", "Features")
let pipeline = ctx.Transforms.Text.FeaturizeText("Features", "Text").Append(scope)

//Step 4. Train your model
let trainedModel = pipeline.Fit(trainingData)

//Step 5. Make predictions using your model
let predictionEngine = ctx.Model.CreatePredictionEngine<ModelInput, ModelOutput>(trainedModel)

let sampleStatement = { Label = false; Text = "This is a horrible movie" }

let prediction = predictionEngine.Predict(sampleStatement)
