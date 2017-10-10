import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class SpellChecker {

	public static void main(String[] args) {

		System.out.println(
				"Please provide a space delimited string of words to create a dictionary from (or type defaultD to use the included dictionary):");
		String dictionaryString = new String();
		ArrayList<String> dictionaryArray = new ArrayList<String>();

		// Keep prompting user for a new dictionary if the last one entered
		// isn't in alphabetical order.
		do {
			dictionaryString = getStringFromUser();
			if (dictionaryString.equals("defaultD")) {
				dictionaryArray = new ArrayList<String>(Arrays.asList(WORDS));
			} else {
				dictionaryArray = createArrayFromString(dictionaryString);
			}
		} while (!isValid(dictionaryArray));

		System.out.println("Please provide a space delimited string of words to spell check:");
		String testString = getStringFromUser();
		ArrayList<String> testArray = createArrayFromString(testString);
		checkSpelling(dictionaryArray, testArray);

	}

	// Use Scanner class to get the dictionary and test strings from the user.
	@SuppressWarnings("resource")
	public static String getStringFromUser() {
		Scanner scanner = new Scanner(System.in);
		String inputString = scanner.nextLine();
		return inputString;
	}

	// Create ArrayLists from the strings so they are easier to manipulate, this
	// would help if expanding the functionality of the program.
	public static ArrayList<String> createArrayFromString(String _dictionaryString) {

		_dictionaryString = _dictionaryString.trim();

		ArrayList<String> _dictionaryArray = new ArrayList<String>();

		// If there are spaces, there is more than one word, so keep getting
		// words and putting them into the arrayList.
		while (_dictionaryString.indexOf(" ") != -1) {
			String nextWord = _dictionaryString.substring(0, _dictionaryString.indexOf(" "));
			_dictionaryArray.add(nextWord.toLowerCase());

			// Remove words from the string as they are put into the ArrayList.
			_dictionaryString = _dictionaryString.substring(_dictionaryString.indexOf(" ") + 1,
					_dictionaryString.length());
		}

		// Add the last word to the ArrayList.
		_dictionaryArray.add(_dictionaryString.toLowerCase());
		return _dictionaryArray;
	}

	// For each word in the test ArrayList, check if it is in the dictionary
	// ArrayList
	public static void checkSpelling(ArrayList<String> _dictionaryArray, ArrayList<String> _testArray) {

		int numberSpelledWrong = 0;

		for (String testWord : _testArray) {
			if (!_dictionaryArray.contains(testWord)) {
				numberSpelledWrong++;
				System.out.println("Unknown word " + testWord + " found");
				findSuggestion(testWord, _dictionaryArray);
			}
		}
		System.out.println("You misspelled " + numberSpelledWrong + " words");
	}

	// Check if the dictionary is in alphabetical order by using the String
	// class's compareTo() method.
	public static boolean isValid(ArrayList<String> _dictionaryArray) {

		for (int i = 0; i < _dictionaryArray.size() - 1; i++) {
			if (_dictionaryArray.get(i).compareTo(_dictionaryArray.get(i + 1)) > 0) {
				System.out.println("Dictionary must be in alphabetical order, please provide a new dictionary:");
				return false;
			}
		}
		return true;
	}

	// Finds a suggestion for a misspelled word by giving value to the number of
	// letters in, and the number of correct letters in, the test word.
	public static void findSuggestion(String testWord, ArrayList<String> _dictionaryArray) {
		int highestLikeness = 0;
		int highestLikenessIndex = 0;

		for (int i = 0; i < _dictionaryArray.size(); i++) {
			int numberOfLettersScore = 1 / (Math.abs(testWord.length() - _dictionaryArray.get(i).length()) + 1);
			int numberOfLettersMatchedScore = 0;

			for (int j = 0; j < testWord.length(); j++) {
				if (_dictionaryArray.get(i).indexOf(testWord.charAt(j)) != -1) {
					numberOfLettersMatchedScore++;
				}
			}

			int likeness = numberOfLettersScore + numberOfLettersMatchedScore * 3;

			if (likeness > highestLikeness) {
				highestLikeness = likeness;
				highestLikenessIndex = i;
			}
		}
		System.out.println("Did you mean " + _dictionaryArray.get(highestLikenessIndex) + "?");
	}

	// Default dictionary
	public static final String[] WORDS = { "a", "able", "about", "above", "access", "accessories", "account", "act",
			"action", "active", "activities", "add", "added", "additional", "address", "adult", "advanced", "advertise",
			"advertising", "after", "again", "against", "age", "ago", "agreement", "air", "al", "all", "along",
			"already", "also", "always", "am", "america", "american", "among", "amount", "an", "analysis", "and",
			"annual", "another", "any", "application", "applications", "apr", "april", "archive", "archives", "are",
			"area", "areas", "around", "art", "article", "articles", "arts", "as", "ask", "association", "at", "audio",
			"aug", "august", "australia", "author", "auto", "available", "average", "away", "b", "baby", "back", "bad",
			"bank", "base", "based", "basic", "be", "beach", "beauty", "because", "become", "been", "before", "being",
			"below", "best", "better", "between", "big", "bill", "bit", "black", "blog", "blue", "board", "body",
			"book", "books", "both", "box", "brand", "browse", "building", "business", "but", "buy", "by", "c", "ca",
			"calendar", "california", "call", "called", "camera", "can", "canada", "car", "card", "cards", "care",
			"cars", "cart", "case", "cases", "categories", "category", "cd", "cell", "center", "central", "centre",
			"change", "changes", "chapter", "chat", "cheap", "check", "child", "children", "china", "choose", "church",
			"city", "class", "clear", "click", "close", "club", "co", "code", "collection", "college", "color", "come",
			"comment", "comments", "commercial", "committee", "common", "community", "companies", "company", "compare",
			"complete", "computer", "computers", "conditions", "conference", "construction", "contact", "content",
			"control", "copyright", "corporate", "cost", "costs", "could", "council", "countries", "country", "county",
			"course", "court", "cover", "create", "created", "credit", "current", "currently", "customer", "customers",
			"d", "daily", "data", "database", "date", "david", "day", "days", "de", "deals", "death", "dec", "december",
			"delivery", "department", "description", "design", "designed", "details", "development", "did", "different",
			"digital", "direct", "director", "directory", "discount", "discussion", "display", "district", "do",
			"document", "does", "doing", "domain", "done", "down", "download", "downloads", "drive", "due", "during",
			"dvd", "e", "each", "early", "east", "easy", "ebay", "economic", "edit", "edition", "education", "effects",
			"either", "electronics", "else", "email", "en", "end", "energy", "engineering", "english", "enough",
			"enter", "entertainment", "entry", "environment", "environmental", "equipment", "error", "estate", "et",
			"europe", "even", "event", "events", "ever", "every", "everything", "example", "experience", "f", "face",
			"fact", "family", "faq", "far", "fast", "fax", "features", "feb", "february", "federal", "feedback", "feel",
			"few", "field", "figure", "file", "files", "film", "final", "finance", "financial", "find", "fire", "first",
			"five", "florida", "following", "food", "for", "form", "format", "forum", "forums", "found", "four",
			"france", "free", "french", "friday", "friend", "friends", "from", "front", "full", "fun", "function",
			"further", "future", "g", "gallery", "game", "games", "garden", "gay", "general", "germany", "get",
			"getting", "gift", "gifts", "girl", "girls", "give", "given", "global", "go", "god", "going", "gold",
			"golf", "good", "google", "got", "government", "great", "green", "group", "groups", "guide", "h", "had",
			"half", "hand", "hard", "hardware", "has", "have", "having", "he", "head", "health", "heart", "help", "her",
			"here", "high", "higher", "him", "his", "history", "holiday", "home", "hosting", "hot", "hotel", "hotels",
			"hours", "house", "how", "however", "html", "human", "i", "id", "if", "ii", "image", "images", "important",
			"in", "include", "included", "includes", "including", "increase", "index", "india", "individual",
			"industry", "info", "information", "insurance", "interest", "international", "internet", "into", "is",
			"island", "issue", "issues", "it", "item", "items", "its", "j", "james", "jan", "january", "japan", "job",
			"jobs", "john", "join", "journal", "jul", "july", "jun", "june", "just", "k", "keep", "key", "kids",
			"kingdom", "know", "knowledge", "known", "l", "la", "lake", "land", "language", "large", "last", "later",
			"latest", "law", "learn", "learning", "least", "left", "legal", "less", "let", "level", "library",
			"license", "life", "light", "like", "limited", "line", "link", "links", "linux", "list", "listed",
			"listing", "listings", "little", "live", "living", "loan", "loans", "local", "location", "log", "login",
			"london", "long", "look", "looking", "loss", "lot", "love", "low", "lyrics", "m", "made", "magazine",
			"mail", "main", "major", "make", "makes", "making", "man", "management", "manager", "many", "map", "mar",
			"march", "mark", "market", "marketing", "material", "materials", "may", "me", "means", "media", "medical",
			"meet", "meeting", "member", "members", "memory", "men", "message", "messages", "method", "methods",
			"michael", "microsoft", "might", "miles", "million", "minutes", "mobile", "model", "models", "money",
			"month", "months", "more", "most", "movie", "movies", "much", "music", "must", "my", "n", "name",
			"national", "natural", "near", "need", "needs", "net", "network", "never", "new", "news", "newsletter",
			"next", "night", "no", "non", "none", "north", "not", "note", "notice", "nov", "november", "now", "nude",
			"number", "o", "oct", "october", "of", "off", "offer", "offers", "office", "official", "often", "oh", "oil",
			"old", "on", "once", "one", "online", "only", "open", "options", "or", "order", "original", "other",
			"others", "our", "out", "over", "own", "p", "page", "pages", "paper", "park", "part", "parts", "party",
			"password", "past", "paul", "pay", "payment", "pc", "people", "per", "percent", "performance", "period",
			"person", "personal", "phone", "photo", "photos", "picture", "pictures", "place", "plan", "planning",
			"play", "player", "please", "plus", "pm", "point", "points", "poker", "policies", "policy", "political",
			"popular", "porn", "position", "possible", "post", "posted", "posts", "power", "powered", "practice",
			"present", "president", "press", "previous", "price", "prices", "print", "privacy", "private", "pro",
			"problem", "problems", "process", "product", "production", "products", "professional", "profile", "program",
			"programs", "project", "projects", "property", "protection", "provide", "provided", "provides", "public",
			"published", "purchase", "put", "q", "quality", "question", "questions", "quick", "quote", "r", "radio",
			"range", "rate", "rates", "rating", "re", "read", "reading", "real", "really", "receive", "received",
			"recent", "record", "records", "red", "reference", "region", "register", "registered", "related", "release",
			"remember", "reply", "report", "reports", "request", "required", "requirements", "research", "reserved",
			"resource", "resources", "response", "result", "results", "return", "review", "reviews", "right", "rights",
			"risk", "road", "rock", "room", "rss", "rules", "run", "s", "safety", "said", "sale", "sales", "same",
			"san", "save", "say", "says", "school", "schools", "science", "search", "second", "section", "security",
			"see", "select", "self", "sell", "seller", "send", "sep", "september", "series", "server", "service",
			"services", "set", "several", "sex", "shall", "share", "she", "shipping", "shoes", "shop", "shopping",
			"short", "should", "show", "shows", "side", "sign", "similar", "simple", "since", "single", "site", "sites",
			"size", "small", "so", "social", "society", "software", "solutions", "some", "something", "sony", "sort",
			"sound", "source", "south", "space", "special", "specific", "speed", "sports", "st", "staff", "standard",
			"standards", "star", "start", "state", "statement", "states", "status", "step", "still", "stock", "storage",
			"store", "stores", "stories", "story", "street", "student", "students", "studies", "study", "stuff",
			"style", "subject", "submit", "subscribe", "such", "sun", "support", "sure", "system", "systems", "t",
			"table", "take", "taken", "talk", "tax", "team", "tech", "technical", "technology", "teen", "tell", "term",
			"terms", "test", "texas", "text", "than", "thanks", "that", "the", "their", "them", "then", "there",
			"these", "they", "thing", "things", "think", "third", "this", "those", "though", "thought", "thread",
			"three", "through", "tickets", "time", "times", "tips", "title", "to", "today", "together", "too", "tools",
			"top", "topic", "topics", "total", "town", "toys", "track", "trade", "training", "travel", "treatment",
			"true", "try", "tv", "two", "type", "u", "uk", "under", "unit", "united", "university", "until", "up",
			"update", "updated", "upon", "url", "us", "usa", "use", "used", "user", "users", "using", "usually", "v",
			"value", "various", "version", "very", "via", "video", "videos", "view", "visit", "w", "want", "war", "was",
			"washington", "watch", "water", "way", "we", "weather", "web", "website", "week", "weight", "welcome",
			"well", "were", "west", "what", "when", "where", "whether", "which", "while", "white", "who", "whole",
			"why", "wide", "will", "window", "windows", "wireless", "with", "within", "without", "women", "word",
			"words", "work", "working", "works", "world", "would", "write", "writing", "written", "x", "y", "yahoo",
			"year", "years", "yellow", "yes", "yet", "york", "you", "young", "your", "z" };
}
