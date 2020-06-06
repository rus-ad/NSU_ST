import sys

def reduce_data(file, separator='\t'):
    for line in file:
        yield line.rstrip().replace(separator, "")


def main(separator='\t'):
    data = reduce_data(sys.stdin, separator=separator)
    
    counter = {}
    for word in data:
    	if word in counter:
            counter[word] += 1
    	else:
    	    counter[word] = 1
    
    for current_word, total_count in counter.items():
    	print '%s%s%d' % (current_word, separator, total_count)
    
if __name__ == "__main__":
    main()

