input_value = float(input("enter a decimal value:   "))
output_value = "00"
adjustment = "0000000000000001"

post_decimal = input_value
for i in range(0, 14):
    temp = post_decimal
    post_decimal = temp*2 - int(temp*2)
    temp = temp*2
    output_value = output_value + str(int(temp))

output_value = int(output_value, 2) + int(adjustment, 2)
output_value = hex(output_value)
print(output_value)
