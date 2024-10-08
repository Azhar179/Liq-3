package com.tcs.testservice;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class TestTable {

    @Id
    @Column(name = "test_id")
    private Integer testId;

    @Column(name = "test_column")
    private Integer testColumn;

}
