local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'usual-household-address',
  question: {
    id: 'usual-address-household-question',
    title: {
      text: 'Did <em>{person_name}</em> usually live in the United Kingdom?',
      placeholders: [
        placeholders.personName,
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'usual-address-household-answer',
        mandatory: false,
        options: [
          {
            label: 'An address in the UK',
            value: 'An address in the UK',
          },
          {
            label: 'An address outside the UK',
            value: 'An address outside the UK',
            description: 'Select to enter answer',
            detail_answer: {
              id: 'usual-address-household-answer-other',
              type: 'TextField',
              mandatory: false,
              label: 'Enter the current name of the country',
            },
          },
        ],
        type: 'Radio',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'usual-address-details',
        when: [
          {
            id: 'usual-address-household-answer',
            condition: 'equals',
            value: 'An address in the UK',
          },
        ],
      },
    },
    {
      goto: {
        group: 'visitor-submit-group',
      },
    },
  ],
}
