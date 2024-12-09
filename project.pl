% ------------------- Rules ------------------------

sentence --> noun_phrase(subject, Singularity), verb_phrase(Singularity).
sentence --> noun_phrase(subject, Singularity), verb_phrase(Singularity), preposition_phrase.

noun_phrase(_, Singularity) --> determiner(VowelOrConsonant, Singularity), adjective_phrase(VowelOrConsonant, []), noun(VowelOrConsonant, Singularity).
noun_phrase(subject, Singularity) --> pronoun(subject, Singularity).
noun_phrase(object, Singularity) --> pronoun(object, Singularity).

verb_phrase(Singularity) --> verb(Singularity).
verb_phrase(Singularity) --> verb(Singularity), noun_phrase(object, Singularity).

preposition_phrase --> preposition, noun_phrase(object, Singularity).

adjective_phrase(VowelOrConsonant, Used) --> [].
adjective_phrase(VowelOrConsonant, Used) --> 
    [Adjective], 
    { 
        adjective((Adjective, VowelOrConsonant)), 
        \+ member(Adjective, Used) 
    },
    adjective_phrase(VowelOrConsonant, [Adjective | Used]).

% ------------------- Lexicon ------------------------

% Determiners
determiner(_, singular) --> [the].
determiner(_, singular) --> [this].
determiner(_, plural) --> [these].
determiner(vowel, singular) --> [an].
determiner(consonant, singular) --> [a].

% Pronouns
pronoun(subject, singular) --> [he].
pronoun(subject, singular) --> [she].
pronoun(subject, plural) --> [they].
pronoun(object, singular) --> [him].
pronoun(object, singular) --> [her].
pronoun(object, plural) --> [them].

% Nouns
noun(consonant, singular) --> [man].
noun(consonant, plural) --> [men].
noun(vowel, singular) --> [airplane].
noun(vowel, plural) --> [airplanes].

% Adjectives
adjective((ugly, vowel)).
adjective((happy, consonant)).

% Verbs
verb(plural) --> [ride].
verb(singular) --> [rides].

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