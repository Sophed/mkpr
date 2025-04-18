package main

import "testing"

func TestMain(t *testing.T) {
	if Add(3, 4) != 7 {
		t.Error("universal collapse")
	}
}
