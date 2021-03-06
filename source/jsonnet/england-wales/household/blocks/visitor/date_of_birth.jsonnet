local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'visitor-date-of-birth',
  question: {
    id: 'visitor-date-of-birth-question',
    title: {
      text: 'What is <em>{person_name_possessive}</em> date of birth?',
      placeholders: [
        placeholders.personNamePossessive,
      ],
    },
    description: 'For example, 31 3 1980',
    type: 'General',
    answers: [
      {
        id: 'visitor-date-of-birth-answer',
        mandatory: false,
        type: 'Date',
        minimum: {
          value: std.extVar('census_date'),
          offset_by: {
            years: -115,
          },
        },
        maximum: {
          value: 'now',
        },
      },
    ],
  },
}
