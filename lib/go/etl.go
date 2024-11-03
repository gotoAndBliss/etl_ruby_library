package main

import (
    "database/sql"
    "encoding/csv"
    "flag"
    "fmt"
    "log"
    "os"
    "strings"
    "strconv"

    _ "github.com/lib/pq" // Import PostgreSQL driver
)

type Record struct {
    ID    int
    Name  string
    Email string
    Age   int
}

func main() {
    // Define command-line flags
    csvFilePath := flag.String("csv", "", "Path to the CSV file")
    dbConnStr := flag.String("db", "", "Database connection string")
    flag.Parse()

    // Validate command-line arguments
    if *csvFilePath == "" || *dbConnStr == "" {
        log.Fatal("Usage: etl_binary -csv=path/to/data.csv -db=database_connection_string")
    }

    // Step 1: Extract data from CSV
    records, err := extract(*csvFilePath)
    if err != nil {
        log.Fatal("Error extracting data:", err)
    }

    // Step 2: Transform data
    transformedRecords := transform(records)

    // Step 3: Load data into PostgreSQL
    err = load(transformedRecords, *dbConnStr)
    if err != nil {
        log.Fatal("Error loading data:", err)
    }

    fmt.Println("ETL Process Completed Successfully!")
}

// Extract: Reads CSV file and returns raw data
func extract(filePath string) ([][]string, error) {
    file, err := os.Open(filePath)
    if err != nil {
        return nil, err
    }
    defer file.Close()

    reader := csv.NewReader(file)
    records, err := reader.ReadAll()
    if err != nil {
        return nil, err
    }
    return records, nil
}

// Transform: Cleans and structures raw data into structured records
func transform(rawRecords [][]string) []Record {
    var records []Record
    for i, row := range rawRecords {
        if i == 0 { // Skip header row
            continue
        }
        id := parseInt(row[0])
        age := parseInt(row[3])
        record := Record{
            ID:    id,
            Name:  strings.TrimSpace(row[1]),
            Email: strings.TrimSpace(row[2]),
            Age:   age,
        }
        records = append(records, record)
    }
    return records
}

// Helper to parse integer with basic error handling
func parseInt(str string) int {
    val, err := strconv.Atoi(str)
    if err != nil {
        return 0 // Default to 0 if conversion fails
    }
    return val
}

// Load: Inserts records into PostgreSQL
func load(records []Record, connStr string) error {
    if os.Getenv("NO_DB") == "true" {
        fmt.Println("Skipping database load (NO_DB is set)")
        return nil
    }

    db, err := sql.Open("postgres", connStr)
    if err != nil {
        return err
    }
    defer db.Close()

    stmt, err := db.Prepare("INSERT INTO users (id, name, email, age) VALUES ($1, $2, $3, $4)")
    if err != nil {
        return err
    }
    defer stmt.Close()

    for _, record := range records {
        _, err := stmt.Exec(record.ID, record.Name, record.Email, record.Age)
        if err != nil {
            return err
        }
    }
    return nil
}

