import sys

def rle_encode(data):
    encoding = ''
    i = 0

    while i < len(data):
        count = 1
        while i + 1 < len(data) and data[i] == data[i + 1]:
            i += 1
            count += 1
        
        if count >= 2:
            encoding += f'{data[i]}{count}'
        else:
            encoding += data[i]
        i += 1

    return encoding

def rle_decode(encoded_data):
    decoded = ''
    i = 0

    while i < len(encoded_data):
        char = encoded_data[i]
        count = ''
        i += 1

        while i < len(encoded_data) and encoded_data[i].isdigit():
            count += encoded_data[i]
            i += 1

        if count and int(count) >= 2:
            decoded += char * int(count)
        else:
            decoded += char

    return decoded

if __name__ == '__main__':
    operation = sys.argv[1]
    input_data = sys.argv[2]

    if operation == 'encode':
        print(rle_encode(input_data))
    elif operation == 'decode':
        print(rle_decode(input_data))
    else:
        print('Operação inválida. Use "encode" ou "decode".')

