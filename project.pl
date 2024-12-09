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
% noun_phrase(_) --> determiner, adjective_phrase, noun.
noun_phrase(_) --> determiner, adjective_phrase([]), noun.
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
%                  = Adjective1 + Adjective2 + ... + AdjectiveN (Unique values)
adjective_phrase(_) --> [].
adjective_phrase(Used) -->
    % Bind current adjective to A
    [A], 
    { 
        % For adjective A, 
        % make sure it's a defined adjective
        adjective(A), 
        % make sure it's not a member of used adjectives
        \+ member(A, Used) 
    },
    % add A to list of Used adjectives
    adjective_phrase([ A | Used ]).

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
noun --> [man].
noun --> [elephant].

% Verbs
verb --> [eats].
verb --> [ate].
verb --> [thinks].
verb --> [thought].
verb --> [rides].
verb --> [rode].

% Adjectives
adjective(big).
adjective(happy).

% Prepositions
preposition --> [to].
preposition --> [from].
preposition --> [with].
preposition --> [on].
preposition --> [in].
preposition --> [at].

output_to_file :-
    open('output.txt', write, Stream),
    set_output(Stream),
    (
        phrase(sentence, Sentence),
        write(Sentence), nl, fail
        ; true
    ),
    set_output(user),
    close(Stream).