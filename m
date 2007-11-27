From: Tejun Heo <htejun@gmail.com>
Subject: program to test various ATAPI transfer lengths (and brasero bugs)
Date: Wed, 28 Nov 2007 00:30:11 +0900
Message-ID: <474C3803.7020008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080706020102060603070809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.224]:13187 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbXK0PaY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:30:24 -0500
Received: by hu-out-0506.google.com with SMTP id 19so982349hue
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:30:18 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------080706020102060603070809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, all.

Here's the program I used to test various ATAPI transfer lengths based
on the sample code Daniel Drake posted a while ago.  The code Daniel
Drake posted was taken from brasero and had the following bug.

Byte 7 is high byte of alloc size not low and the whole CDB should be
ten bytes long instead of nine.  SPC tries to trick you here by omitting
byte 5 in Reserved field.

Daniel, care to forward this to brasero developers?

Thanks.

-- 
tejun

--------------080706020102060603070809
Content-Type: text/x-csrc;
 name="test-shortsg.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test-shortsg.c"

#include <stdio.h>
#include <scsi/sg.h>
#include <scsi/scsi.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

static void print_hex(const unsigned char *p, int len)
{
	int i;

	for (i = 0; i < len; i++) {
		if (i % 16 == 0)
			printf("%04x: ", i);
		printf("%02x", p[i]);
		if (i % 4 == 3) {
			if (i % 16 == 15)
				printf("\n");
			else
				printf("  ");
		} else
			printf(" ");
	}
	if (len % 16)
		printf("\n");
}

int main(int argc, char **argv)
{
	struct sg_io_hdr transport;
	unsigned char mode_sense_cmd[] = {
		0x5a, //opcode -- mode sense(10)
		0x08, //dbd, llbaa -- dbd=1
		0x2a, //page code -- BRASERO_SPC_PAGE_STATUS
		      // spc-3 says thats "CD capabilities and mechanical status"
			  //
		0x00, //brasero says reserved, spc3 says subpage code
		0x00, //reserved
		0x00, //reserved
		0x00, //reserved
		0x00, //alloc len
		0x00, //alloc len
		0x00, //ctl
	};
	unsigned char get_configuration_cmd[] = {
		0x46, //opcode -- get configuration
		0x00, //RT: 0
		0x00, //
		0x00, //starting feature number: 0
		0x00, //reserved
		0x00, //reserved
		0x00, //reserved
		0x00, //alloc len
		0x00, //alloc len
		0x00, //ctl
	};
	unsigned char *cmd, *buffer;
	unsigned char sense_data[32];
	unsigned int buf_len, alloc_len;
	int r;
	int fd;

	if (argc < 4) {
		fprintf(stderr, "Usage: test-shortsg (m|g) DEVICE BUFLEN [ALLOCLEN]\n");
		return 1;
	}

	switch (argv[1][0]) {
	case 'm':
		cmd = mode_sense_cmd;
		break;
	case 'g':
		cmd = get_configuration_cmd;
		break;
	default:
		fprintf(stderr, "invalid cmd selector '%c'\n", argv[1][0]);
	}

	fd = open(argv[2], O_RDONLY|O_NONBLOCK);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	alloc_len = buf_len = atoi(argv[3]);

	if (argc >= 5)
		alloc_len = atoi(argv[4]);

	if (buf_len > 0xFFFE || alloc_len > 0xFFFE) {
		fprintf(stderr, "invalid buf/alloc len\n");
		return 1;
	}

	printf("buf len is %u bytes, alloc len is %u bytes\n",
	       buf_len, alloc_len);

	buffer = malloc(buf_len);
	if (!buffer) {
		perror("malloc");
		return 1;
	}

	cmd[7] = (alloc_len >> 8) & 0xff;
	cmd[8] = alloc_len & 0xff;

	printf("* CDB\n");
	print_hex(cmd, 10);

	memset(&transport, 0, sizeof(transport));
	memset(buffer, 0xdb, buf_len);
	memset(sense_data, 0, sizeof(sense_data));

	transport.interface_id = 'S';
	transport.cmdp = cmd;
	transport.cmd_len = 10;
	transport.dxferp = buffer;
	transport.dxfer_len = buf_len;
	transport.sbp = sense_data;
	transport.mx_sb_len = sizeof(sense_data);
	transport.dxfer_direction = SG_DXFER_FROM_DEV;

	r = ioctl(fd, SG_IO, &transport);

	printf("* result %d, buffer content follows\n", r);
	print_hex(buffer, buf_len);

	if ((transport.masked_status & CHECK_CONDITION) && transport.sb_len_wr) {
		printf("\n* check sense data:\n");
		print_hex(sense_data, sizeof(sense_data));
	}

	return 0;
}

--------------080706020102060603070809--
