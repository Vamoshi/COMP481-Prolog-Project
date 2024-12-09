% ------------------- RULES ------------------------

sentence --> noun_phrase(subject), verb_phrase.
sentence --> noun_phrase(subject), verb_phrase, preposition_phrase.

noun_phrase(_) --> determiner(V), adjective_phrase([]), noun(V).
noun_phrase(subject) --> pronoun(subject).
noun_phrase(subject) --> pronoun(object).

verb_phrase --> verb.
verb_phrase --> verb, noun_phrase(object).
verb_phrase --> verb, preposition_phrase.

preposition_phrase --> preposition, noun_phrase(object).

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
% determiner(_) --> [the].
% determiner(_) --> [this].
% determiner(_) --> [these].

determiner(consonant) --> [a].
determiner(vowel) --> [an].

% Nouns
noun(consonant) --> [man].
noun(vowel) --> [elephant].

% Adjectives
adjective(big).
adjective(ugly).

% Pronouns
pronoun(subject) --> [he].
pronoun(subject) --> [she].
pronoun(subject) --> [they].
pronoun(object) --> [him].
pronoun(object) --> [her].
pronoun(object) --> [them].

% Verbs
verb --> [eats].
verb --> [ate].
verb --> [thinks].
verb --> [thought].
verb --> [rides].
verb --> [rode].

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