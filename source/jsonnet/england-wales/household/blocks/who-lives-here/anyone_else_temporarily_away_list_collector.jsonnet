local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text: 'Apart from the people already included, is there anyone who is temporarily away or staying that you need to add to {household_address}?',
  placeholders: [
    placeholders.address,
  ],
};

local primaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em> (You)',
  placeholders: [
    placeholders.personName,
  ],
};

local nonPrimaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em>',
  placeholders: [
    placeholders.personName,
  ],
};

local editQuestion(questionTitle) = {
  id: 'anyone-else-temp-away-edit-question',
  type: 'General',
  title: questionTitle,
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
    },
    {
      id: 'middle-names',
      label: 'Middle names',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'last-name',
      label: 'Last name',
      mandatory: true,
      type: 'TextField',
    },
  ],
};


{
  id: 'anyone-else-temp-away-list-collector',
  type: 'ListCollector',
  for_list: 'household',
  add_answer: {
    id: 'anyone-else-temp-away-answer',
    value: 'Yes, I need to add someone',
  },
  remove_answer: {
    id: 'anyone-else-temp-away-remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question: {
    id: 'anyone-else-temp-away-confirmation-question',
    type: 'General',
    title: questionTitle,
    guidance: {
      contents: [
        {
          title: 'Include people who are temporarily away',
        },
        {
          list: [
            'People who work away from home within the UK if this is their permanent or family home',
            'Members of the armed forces if this is their permanent or family home',
            'People who are temporarily outside the UK for less than <strong>12 months</strong>',
            'Other people who usually live here but are temporarily away',
          ],
        },
        {
          title: 'Include people who are temporarily staying',
        },
        {
          list: [
            'People staying temporarily who usually live in the UK but do not have another UK address for example, relatives, friends',
            'People who usually live outside the UK who are staying in the UK for <strong>3 months or more</strong>',
          ],
        },
      ],
    },
    answers: [
      {
        id: 'anyone-else-temp-away-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes, I need to add someone',
            value: 'Yes, I need to add someone',
          },
          {
            label: 'No, I do not need to add anyone',
            value: 'No, I do not need to add anyone',
          },
        ],
        guidance: {
          show_guidance: 'Why do we ask this question?',
          hide_guidance: 'Why do we ask this question?',
          contents: [
            {
              description: 'We ask this question to help ensure that everyone is correctly counted in the census. This includes people who are staying temporarily or are away.',
            },
          ],
        },
      },
    ],
  },
  add_block: {
    id: 'anyone-else-temp-away-add-person',
    type: 'ListAddQuestion',
    cancel_text: 'Don’t need to add anyone?',
    question: {
      id: 'anyone-else-temp-away-add-question',
      type: 'General',
      title: {
        text: 'Who do you need to add to {household_address}?',
        placeholders: [
          placeholders.address,
        ],
      },
      answers: [
        {
          id: 'first-name',
          label: 'First name',
          mandatory: true,
          type: 'TextField',
        },
        {
          id: 'middle-names',
          label: 'Middle names',
          mandatory: false,
          type: 'TextField',
        },
        {
          id: 'last-name',
          label: 'Last name',
          mandatory: true,
          type: 'TextField',
        },
      ],
    },
  },
  edit_block: {
    id: 'anyone-else-temp-away-edit-person',
    type: 'ListEditQuestion',
    question_variants: [
      {
        question: editQuestion(primaryEditPersonQuestionTitle),
        when: [rules.isPrimary],
      },
      {
        question: editQuestion(nonPrimaryEditPersonQuestionTitle),
        when: [rules.isNotPrimary],
      },
    ],
  },
  remove_block: {
    id: 'anyone-else-temp-away-remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'anyone-else-temp-away-remove-question',
      type: 'General',
      guidance: {
        contents: [{
          title: 'All of the data entered about this person will be deleted',
        }],
      },
      title: {
        text: 'Are you sure you want to remove <em>{person_name}</em>?',
        placeholders: [
          placeholders.personName,
        ],
      },
      answers: [
        {
          id: 'anyone-else-temp-away-remove-confirmation',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
            },
            {
              label: 'No, I do not want to remove this person',
              value: 'No, I do not want to remove this person',
            },
          ],
        },
      ],
    },
  },
  summary: {
    title: 'Household members',
    item_title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName,
      ],
    },
  },
}
