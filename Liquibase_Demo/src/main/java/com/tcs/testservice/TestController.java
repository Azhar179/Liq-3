package com.tcs.testservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/test-db-data")
public class TestController {

    @Autowired
    private TestService service;

    @GetMapping
    public ResponseEntity<List<TestTable>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<TestTable> findRow(@PathVariable String id) {
        try {
            return ResponseEntity.ok(service.findRow(id));
        } catch (NoSuchElementException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @PostMapping
    public ResponseEntity<String> insertRow(@RequestBody TestTable data) {
        service.saveRow(data);
        return ResponseEntity.ok("Data saved successfully");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteRow(@PathVariable String id) {
        service.deleteRow(id);
        return ResponseEntity.ok("Data deleted successfully");
    }

}
