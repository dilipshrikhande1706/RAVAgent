from langdetect import detect
from langflow.custom import Component
from langflow.io import Output, MessageTextInput

class LanguageDetectorComponent(Component):
    display_name = "Language Detector"
    description = "Detects the language of the provided text."
    icon = "language"
    name = "LanguageDetector"

    # Inputs from the user
    inputs = [
        MessageTextInput(
            name="text",
            display_name="Input Text",
            info="Enter the text to detect its language."
        )
    ]

    # Output with the detected language
    outputs = [
        Output(
            display_name="Detected Language",
            name="detected_language",
            method="detect_language"
        )
    ]

    def detect_language(self):
        try:
            # Detect the language of the input text
            language = detect(self.text)
            self.status = f"Detected language: {language}"
            return language
        except Exception as e:
            self.status = f"Error detecting language: {str(e)}"
            return "unknown"
