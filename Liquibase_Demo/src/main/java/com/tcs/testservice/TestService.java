package com.tcs.testservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestService {

    @Autowired
    private TestRepository repository;

    public List<TestTable> findAll() {
        return repository.findAll();
    }

    public TestTable findRow(String id) {
        return repository.findById(Integer.valueOf(id)).orElseThrow();
    }

    public void saveRow(TestTable data) {
        repository.save(data);
    }

    public void deleteRow(String id) {
        repository.deleteById(Integer.valueOf(id));
    }

}
