local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local anyoneElseOptionDescription = {
  text: 'Include partners, children, babies born on or before {census_date}, housemates, tenants and lodgers, students and schoolchildren who live away from home during term time, where this is their permanent or family home',
  placeholders: [
    placeholders.censusDate,
  ],
};

local questionTitle = {
  text: 'Does anyone usually live at {household_address}?',
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
  id: 'edit-question',
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
  id: 'anyone-else-list-collector',
  type: 'ListCollector',
  for_list: 'household',
  add_answer: {
    id: 'anyone-else-answer',
    value: 'Yes, I need to add someone',
  },
  remove_answer: {
    id: 'remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question_variants: [
    {
      question: {
        type: 'General',
        id: 'anyone-usually-live-at-question',
        title: questionTitle,
        answers: [
          {
            id: 'anyone-else-answer',
            mandatory: true,
            type: 'Radio',
            options: [
              {
                label: 'Yes, I need to add someone',
                value: 'Yes, I need to add someone',
                description: anyoneElseOptionDescription,
              },
              {
                label: 'No, no one usually lives here',
                value: 'No, no one usually lives here',
                description: 'For example, this is a second address or holiday home',
              },
            ],
          },
        ],
      },
      when: [rules.listIsEmpty('household')],
    },
    {
      question: {
        id: 'anyone-usually-live-at-question',
        type: 'General',
        title: {
          text: 'Does anyone else live at {household_address}?',
          placeholders: [
            placeholders.address,
          ],
        },
        answers: [
          {
            id: 'anyone-else-answer',
            mandatory: true,
            type: 'Radio',
            options: [
              {
                label: 'Yes, I need to add someone',
                value: 'Yes, I need to add someone',
                description: anyoneElseOptionDescription,
              },
              {
                label: 'No, I do not need to add anyone',
                value: 'No, I do not need to add anyone',
              },
            ],
          },
        ],
      },
      when: [rules.listIsNotEmpty('household')],
    },
  ],
  add_block: {
    id: 'add-person',
    type: 'ListAddQuestion',
    cancel_text: 'Don’t need to add anyone?',
    question: {
      id: 'add-question',
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
    id: 'edit-person',
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
    id: 'remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'remove-question',
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
          id: 'remove-confirmation',
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
