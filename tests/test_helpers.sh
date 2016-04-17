#!/usr/bin/env shunit2

test_one_equals_one1()
{
    echo 'this one passes'
    assertEquals 1 1
}

test_two_equals_one1()
{
    echo 'this one fails'
    assertEquals 1 1
}

