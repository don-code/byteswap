#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BUF_SIZE 128*1024 /* 128k buffer */
#define BYTES_PER_WORD 4 /* Operate on 32-bit words */

/* Prints a usage statement. */
void printUsage() {
	printf("Byteswaps the contents of a file.\n");
	printf("Usage: byteswap input_file output_file\n");
}

/* Opens the given file with the given mode. If an error occurs, prints the
   path to the file, plus the usage statement. */
FILE* openFile(const char* path, const char* mode) {
	FILE* filePtr;
	
	filePtr = fopen(path, mode);
	if(filePtr == NULL) {
		fprintf(stderr, "ERROR: Could not open file %s\n", path);
		printUsage();
	}
	
	return filePtr;
}

/* Byteswaps the contents of a file. */
int main(int argc, char** argv) {
	FILE *inFile, *outFile; /* Input & output files */
	char *buffer; /* Internal file buffer. */
	char word[BYTES_PER_WORD]; /* Word to byteswap. */
	int blockSize; /* Size of block read into buffer. */
	int words, bytes; /* Loop counters. */
	
	/* If necessary, print usage message and exit. */
	if(argc != 3) {
		printUsage();
		return 1;
	}
	
	/* Open input and output files. */
	inFile = openFile(argv[1], "rb");
	if(inFile == NULL) {
		return 2;
	}
	outFile = openFile(argv[2], "wb");
	if(outFile == NULL) {
		return 3;
	}
	
	/* Begin byteswapping. */
	while(!feof(inFile)) {
		/* Read in a block. */
		buffer = (char *)malloc(BUF_SIZE);
		blockSize = fread(buffer, 1, BUF_SIZE, inFile);
		
		/* Loop over all words in the block. */
		for(words=0; words < blockSize; words+=BYTES_PER_WORD) {
			/* For each word in the block, reorganize the byte order such that
			   the most-significant bit becomes the least-significant bit, and
			   vice-versa. */
			memcpy(word, buffer + words, BYTES_PER_WORD);
			for(bytes=0; bytes < BYTES_PER_WORD; bytes++) {
				buffer[words+BYTES_PER_WORD-bytes-1] = word[bytes];
			}
		}
		
		/* Write out the byteswapped block. */
		fwrite(buffer, 1, blockSize, outFile);
		free(buffer);
	}
	
	/* Clean up. */
	fclose(outFile);
	fclose(inFile);
	return 0;
}
