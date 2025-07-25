# Instructions

Your friend has just sent you a message with an important secret.
Not wanting to make it easy for others to read it, the message was encrypted by performing a series of bit manipulations.
You will need to write the functions to help decrypt the message.

## 1. Shift back the bits

The first step in decrypting the message is to undo the shifting from the encryption process by shifting the bits back to the right.
There will be further steps in the decryption process that assume 0s are inserted from the left hand side.

Implement the `shift_back()` function that takes a value and the number of places to shift and peforms the shift.

```julia
shift_back(0b1001, 2) # => 0b0010
```

## 2. Set some bits

Next, there are some bits that need to be set to 1.

Implement the `set_bits()` function that takes a value and a mask and returns the result of setting the bits in value to 1.
A bit from `value` should be set to 1 where the bit in the `mask` is also 1.
All other bits should be kept unchanged.

```julia
set_bits(0b0110, 0b0101) # => 0b0111
```

## 3. Flip specific bits

Some bits are flipped during encryption.
They will need to be flipped back to decrypt the message.

Implement the `flip_bits()` function that takes a value and the mask.
The mask indicates which bits in the value to flip.
If the bit is 1 in `mask`, the bit is flipped in the `value`.
All other bits are kept unchanged.

```julia
flip_bits(0b1100, 0b0101) # => 0b1001
```

## 4. Clear specific bits

Lastly, there are also certain bits that always decrypt to 0.

Implement the `clear_bits()` function that takes a value and a mask.
The bits in the `value` should be set to 0 where the bit in the mask is 1.
All other bits should be kept unchanged.

```julia
clear_bits(0b0110, 0b0101) # => 0b0010
```
