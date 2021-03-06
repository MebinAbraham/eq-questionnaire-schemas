local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'accommodation-type',
  question: {
    id: 'accommodation-type-question',
    title: {
      text: 'What type of accommodation is <em>{household_address}</em>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    definitions: [{
      title: 'What we mean by “communal establishment”',
      contents: [
        {
          description: 'This is a place providing managed residential accommodation. “Managed” here means full-time or part-time supervision of the accommodation.',
        },
      ],
    }],
    answers: [
      {
        id: 'accommodation-type-answer',
        mandatory: true,
        options: [
          {
            label: 'A communal establishment',
            value: 'A communal establishment',
            description: 'For example, student hall of residence, boarding school, armed forces base, hospital, care home, prison',
          },
          {
            label: 'A private or family household',
            value: 'A private or family household',
          },
        ],
        type: 'Radio',
      },
    ],
  },
}
