#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    REMAP = {
      'Minister-President Minister van Algemene Zaken, Innovatie, Overheidsorganisatie, Infrastructuur en Ruimtelijke ordening' => [
        'Minister-President',
        'Minister van Algemene Zaken, Innovatie, Overheidsorganisatie, Infrastructuur en Ruimtelijke ordening'
      ],
    }.freeze
    def name
      tds[1].text.tidy
    end

    def position
      REMAP.fetch(raw_position, raw_position)
    end

    private

    def tds
      noko.css('td')
    end

    def raw_position
      tds[0].text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.text table tbody tr')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
