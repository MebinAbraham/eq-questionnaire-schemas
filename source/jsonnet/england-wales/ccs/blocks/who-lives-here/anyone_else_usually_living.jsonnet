local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'anyone-else-usually-living',
  question: {
    id: 'anyone-else-usually-living-question',
    title: {
      text: 'Was anyone in your current household usually living at {household_address} on Sunday {census_date}?',
      placeholders: [
        placeholders.address,
        placeholders.censusDate,
      ],
    },
    type: 'General',
    answers: [{
      id: 'anyone-else-usually-living-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'another-address-interviewer-note-interstitial',
        when: [
          {
            id: 'anyone-else-usually-living-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'interviewer-note-interstitial',
      },
    },
  ],
}
