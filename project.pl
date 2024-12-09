% You are only required to create Prolog rules for the following grammar rules.
% • Simple Sentences
% • Noun Phrases
% • Verb Phrases
% • Prepositional Phrases
% • Adjective Phrases
% • Determiners
% • Verbs
% • Adjectives
% • Nouns
% • Pronouns

% Sentence = Noun Phrase + Verb Phrase
% Sentence = Noun Phrase + Verb Phrase + Preposition Phrase

% Noun Phrase = Determiner + Noun
%             = Pronoun
%             = Determiner + Adjective Phrase + Noun

% Verb Phrase = Verb + Noun Phrase
%             = Verb
%             = Verb + Prepositional Phrase

% Prepositional Phrase = Preposition + Noun Phrase

% Adjective Phrase = Adjective
%                  = Adjective + Adjective + ... + Adjective

% ------------------- RULES ------------------------

% Sentence = Noun Phrase + Verb Phrase
% Sentence = Noun Phrase + Verb Phrase + Preposition Phrase
sentence --> noun_phrase(subject), verb_phrase.
sentence --> noun_phrase(subject), verb_phrase, preposition_phrase.

% Noun Phrase = Determiner + Noun
%             = Pronoun
%             = Determiner + Adjective Phrase + Noun
noun_phrase(_) --> determiner, noun.
noun_phrase(_) --> determiner, adjective_phrase, noun.
noun_phrase(subject) --> pronoun(subject).
noun_phrase(subject) --> pronoun(object).

% Verb Phrase = Verb + Noun Phrase
%             = Verb
%             = Verb + Prepositional Phrase
verb_phrase --> verb.
verb_phrase --> verb, noun_phrase(object).
verb_phrase --> verb, preposition_phrase.

% Prepositional Phrase = Preposition + Noun Phrase
preposition_phrase --> preposition, noun_phrase(object).

% Adjective Phrase = Adjective
%                  = Adjective + Adjective + ... + Adjective
adjective_phrase --> adjective.
adjective_phrase --> adjective, adjective_phrase.

% ------------------- Lexicon ------------------------

% Determiners
determiner --> [the].
determiner --> [a].
determiner --> [an].
determiner --> [this].
determiner --> [these].

% Pronouns
pronoun(subject) --> [he].
pronoun(subject) --> [she].
pronoun(subject) --> [they].
pronoun(object) --> [him].
pronoun(object) --> [her].
pronoun(object) --> [them].

% Nouns
noun --> [dog].
noun --> [cat].
noun --> [man].
noun --> [woman].
noun --> [car].

% Verbs
verb --> [eats].
verb --> [ate].
verb --> [thinks].
verb --> [thought].
verb --> [rides].
verb --> [rode].

% Adjectives
adjective --> [happy].
adjective --> [sad].
adjective --> [big].
adjective --> [small].
adjective --> [pretty].
adjective --> [ugly].

% Prepositions
preposition --> [to].
preposition --> [from].
preposition --> [with].
preposition --> [on].
preposition --> [in].
preposition --> [at].