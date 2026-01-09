#!/usr/bin/env python3
"""
Python helper script for spaCy integration with R
This script can be used to test spaCy functionality independently
"""

import sys
import spacy
from spacy import displacy

def test_spacy():
    """Test spaCy installation and model availability"""
    try:
        # Load English model
        nlp = spacy.load("en_core_web_sm")
        print("✓ spaCy English model loaded successfully")
        
        # Test with a sample text
        sample_text = "Concert at Trinity Bellwoods Park featuring live music and food vendors"
        doc = nlp(sample_text)
        
        print(f"✓ Processed sample text: '{sample_text}'")
        print("Entities found:")
        for ent in doc.ents:
            print(f"  - {ent.text}: {ent.label_}")
        
        return True
    except Exception as e:
        print(f"✗ Error with spaCy: {e}")
        return False

def classify_event(title, description):
    """
    Classify an event using spaCy NLP
    This mirrors the functionality in the R script
    """
    nlp = spacy.load("en_core_web_sm")
    
    full_text = f"{title} {description}"
    doc = nlp(full_text)
    
    # Extract entities
    entities = [(ent.text, ent.label_) for ent in doc.ents]
    
    # Define keywords for different event types
    text_lower = full_text.lower()
    concert_keywords = ["concert", "music", "band", "dj", "festival", "show", "performance", "venue", "stage", "gig", "tour"]
    sports_keywords = ["sports", "game", "match", "tournament", "team", "soccer", "basketball", "hockey", "football", "playoff", "playoffs", "mls", "nba", "nhl", "cfl", "cancer relay", "marathon", "race", "run"]
    food_keywords = ["food", "restaurant", "dining", "market", "tasting", "brewery", "wine", "beer", "cuisine", "chef", "brewfest", "tasting", "farmers market", "night market", "food truck", "restaurant week"]
    arts_keywords = ["art", "gallery", "museum", "exhibition", "painting", "sculpture", "theater", "dance", "culture", "film", "cinema", "movie", "outdoor cinema", "street festival", "cultural", "heritage", "flea market", "craft fair"]
    outdoor_keywords = ["outdoor", "park", "beach", "garden", "nature", "hiking", "trail", "cycling", "bike", "biking", "outdoor market", "patio", "summer event", "outdoor concert", "open air"]
    
    # Check for non-event indicators
    non_event_keywords = ["hiring", "jobs", "weather", "forecast", "news", "update", "report", "study", "research", "policy", "council", "meeting", "announcement", "sale", "real estate", "condo", "apartment", "traffic", "construction", "transit", "commute", "work from home", "remote work"]
    
    # Determine classification
    if any(keyword in text_lower for keyword in non_event_keywords):
        category = "News/Info"
        impact = "NONE"
    elif any(keyword in text_lower for keyword in concert_keywords) or any(label == "EVENT" for _, label in entities):
        category = "Concert"
        impact = "HIGH"
    elif any(keyword in text_lower for keyword in sports_keywords):
        category = "Sports Event"
        impact = "HIGH"
    elif any(keyword in text_lower for keyword in food_keywords):
        category = "Food Festival"
        impact = "MEDIUM"
    elif any(keyword in text_lower for keyword in arts_keywords):
        category = "Art/Cultural Event"
        impact = "MEDIUM"
    elif any(keyword in text_lower for keyword in outdoor_keywords):
        category = "Outdoor Activity"
        impact = "MEDIUM"
    elif any(label == "EVENT" for _, label in entities):
        category = "Event"
        impact = "MEDIUM"
    else:
        category = "Other"
        impact = "LOW"
    
    return {
        "category": category,
        "impact": impact,
        "entities": entities
    }

if __name__ == "__main__":
    print("Toronto Bike Share Analytics - spaCy Helper")
    print("=" * 50)
    
    if len(sys.argv) > 1:
        # If arguments provided, classify the event
        title = sys.argv[1] if len(sys.argv) > 1 else ""
        description = sys.argv[2] if len(sys.argv) > 2 else ""
        
        result = classify_event(title, description)
        print(f"Classification Result: {result}")
    else:
        # Otherwise, just test spaCy
        success = test_spacy()
        if success:
            print("\nspaCy is ready for use with the R script!")
        else:
            print("\nPlease install spaCy and the English model:")
            print("pip install spacy")
            print("python -m spacy download en_core_web_sm")