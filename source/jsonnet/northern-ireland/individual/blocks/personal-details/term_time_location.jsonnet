local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'term-time-location-answer',
      mandatory: true,
      type: 'Radio',
      options: [
        {
          label: {
            text: '{household_address}',
            placeholders: [
              placeholders.address,
            ],
          },
          value: '{household_address}',
        },
        {
          label: 'At another address',
          value: 'At another address',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'During term time, where do you usually live?';
local proxyTitle = {
  text: 'During term time, where does <em>{person_name}</em> usually live?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'term-time-location',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy],
    },
  ],
}
