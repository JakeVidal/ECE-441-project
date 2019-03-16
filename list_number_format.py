
import math


thetas = []
print("Thetas:")
for i in range(0, 16):
	theta = math.atan( math.pow(2, -i) )
	theta = round(theta, 5)
	thetas.append(theta)
	print(theta)
	
#thetas = [0.7854, 0.4636, 0.245, 0.1244, 0.0624, 0.0312, 0.0156, 0.0078, 0.0039, 0.002, 0.00098, 0.00049, 0.00024, 0.00012, 0.000061, 0.000031]

hex_thetas = []
print("Hex value bit shifted thetas")
for theta in thetas:
	output_value = "00"
	adjustment = "0000000000000001"
	post_decimal = theta
	for i in range(0, 14):
		temp = post_decimal
		post_decimal = temp*2 - int(temp*2)
		temp = temp*2
		output_value = output_value + str(int(temp))

	output_value = int(output_value, 2) + int(adjustment, 2)
	hex_thetas.append(output_value & 0xffff)
	output_value = hex(output_value)
	print(output_value)
	
testdata = 0x2183
print(hex(testdata))
for i in range(0, 16):
	if( i % 2 == 0):
		testdata = testdata - int(hex_thetas[i])
	else:
		testdata = testdata + int(hex_thetas[i])
	print(hex(testdata & 0xffff))
