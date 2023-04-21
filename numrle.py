import sys

SEQUENCE_DICTIONARY = {
    2: 'a', 3: 'b', 4: 'c', 5: 'd', 6: 'e', 7: 'f', 8: 'g', 9: 'h', 10: 'i', 11: 'j',
    12: 'k', 13: 'l', 14: 'm', 15: 'n', 16: 'o', 17: 'p', 18: 'q', 19: 'r', 20: 's',
    21: 't', 22: 'u', 23: 'v', 24: 'w', 25: 'x', 26: 'y', 27: 'z'
}

def rle_encode(data):
    encoding = ''
    i = 0

    while i < len(data):
        count = 1
        while i + 1 < len(data) and data[i] == data[i + 1]:
            i += 1
            count += 1

        if count > 1 and count in SEQUENCE_DICTIONARY:
            sequence_char = SEQUENCE_DICTIONARY[count]
            encoding += f'{data[i]}{sequence_char}'
        else:
            encoding += data[i]
        i += 1

    return encoding

def rle_decode(encoded_data):
    decoded = ''
    i = 0

    while i < len(encoded_data):
        char = encoded_data[i]
        sequence_char = ''
        i += 1

        if i < len(encoded_data) and encoded_data[i].isalpha():
            sequence_char = encoded_data[i]
            i += 1

        if sequence_char and sequence_char in SEQUENCE_DICTIONARY.values():
            count = list(SEQUENCE_DICTIONARY.keys())[list(SEQUENCE_DICTIONARY.values()).index(sequence_char)]
            decoded += char * count
        else:
            decoded += char

    return decoded

if __name__ == '__main__':
    operation = sys.argv[1]
    input_data = sys.argv[2]

    if operation == 'encode':
        output = rle_encode(input_data)
        print(output, 'bytes:', len(input_data), len(output))
    elif operation == 'decode':
        print(rle_decode(input_data))
    else:
        print('Operação inválida. Use "encode" ou "decode".')

