% ------------------- Rules ------------------------

sentence --> noun_phrase(subject), verb_phrase.
sentence --> noun_phrase(subject), verb_phrase, preposition_phrase.

noun_phrase(_) --> determiner(Type), adjective_phrase(Type, []), noun(Type).
noun_phrase(subject) --> pronoun(subject).
noun_phrase(subject) --> pronoun(object).

verb_phrase --> verb.
verb_phrase --> verb, noun_phrase(object).

preposition_phrase --> preposition, noun_phrase(object).

adjective_phrase(Type, Used) --> [].
adjective_phrase(Type, Used) --> 
    [Adjective], 
    { 
        adjective((Adjective, Type)), 
        \+ member(Adjective, Used) 
    },
    adjective_phrase(Type, [Adjective | Used]).

% ------------------- Lexicon ------------------------

% Determiners
determiner(_) --> [the].
determiner(_) --> [this].
determiner(_) --> [these].
determiner(vowel) --> [an].
determiner(consonant) --> [a].

% Pronouns
pronoun(subject) --> [he].
pronoun(subject) --> [she].
pronoun(subject) --> [they].
pronoun(object) --> [him].
pronoun(object) --> [her].
pronoun(object) --> [them].

% Nouns
noun(consonant) --> [man].
noun(consonant) --> [men].
noun(vowel) --> [airplane].
noun(vowel) --> [airplanes].

% Adjectives
adjective((ugly, vowel)).
adjective((happy, consonant)).

% Verbs
verb --> [ride].
verb --> [rides].

% Prepositions
preposition --> [in].
preposition --> [with].
preposition --> [to].
preposition --> [from].
preposition --> [on].
preposition --> [at].
preposition --> [by].

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