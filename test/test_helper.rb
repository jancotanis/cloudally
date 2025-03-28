# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'cloudally'
require 'minitest/autorun'
require 'minitest/spec'
require 'dotenv'

Dotenv.load
