From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
Date: Tue, 06 Apr 2010 18:47:22 -0400
Message-ID: <4BBBB9FA.3060803@teksavvy.com>
References: <4BBBB975.7000203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:17970 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752343Ab0DFWrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 18:47:24 -0400
In-Reply-To: <4BBBB975.7000203@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

Here is a test program, to see if a drive
On 06/04/10 06:45 PM, Mark Lord wrote:
> Most drives from Seagate, Hitachi, and possibly other brands,
> do not allow LBA28 access to sector number 0x0fffffff (2^28 - 1).
> So instead use LBA48 for such accesses.
...

Here is a test program, to see if a particular drive has this problem or not.
It works only on drives larger than 128GB.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <linux/fs.h>
#include <linux/hdreg.h>
#include <scsi/scsi.h>
#include <scsi/sg.h>

typedef unsigned long long u64;

enum {
	ATA_CMD_DMA_READ		= 0xc8,
	ATA_CMD_DMA_READ_EXT		= 0x25,
	ATA_SECT_SIZE			= 512,
	ATA_16				= 0x85,
	ATA_16_LEN			= 16,
	ATA_DEV_REG_LBA			= (1 << 6),
	ATA_LBA48			= 1,
	ATA_PROTO_DMA			= ( 6 << 1),
};

static int sg_read (int fd, u64 lba, unsigned int nsects, void *buf, int force_lba28)
{
	unsigned char cdb[ATA_16_LEN] = { ATA_16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	struct sg_io_hdr hdr;
	unsigned char sense[32];

	cdb[ 1] = ATA_PROTO_DMA;
	cdb[ 6] = nsects;
	cdb[ 8] = lba;
	cdb[10] = lba >>  8;
	cdb[12] = lba >> 16;
	cdb[13] = ATA_DEV_REG_LBA;

	if (force_lba28 || (nsects <= 256 && (lba + nsects) < (1ULL << 28))) {
		cdb[13] |= (lba >> 24) & 0x0f;
		cdb[14]  = ATA_CMD_DMA_READ;
	} else {
		cdb[ 1] |= ATA_LBA48;
		cdb[ 5]  = nsects >> 8;
		cdb[ 7]  = lba >> 24;
		cdb[ 9]  = lba >> 32;
		cdb[11]  = lba >> 40;
		cdb[14]  = ATA_CMD_DMA_READ_EXT;
	}

	memset(&hdr, 0, sizeof(struct sg_io_hdr));
	hdr.interface_id	= 'S';
	hdr.cmd_len		= ATA_16_LEN;
	hdr.mx_sb_len		= sizeof(sense);
	hdr.dxfer_direction	= SG_DXFER_FROM_DEV;
	hdr.dxfer_len		= nsects * ATA_SECT_SIZE;
	hdr.dxferp		= buf;
	hdr.cmdp		= cdb;
	hdr.sbp			= sense;
	hdr.pack_id		= lba;
	hdr.timeout		= 5000; /* milliseconds */

	memset(sense, 0, sizeof(sense));
	if (ioctl(fd, SG_IO, &hdr) < 0) {
		perror("ioctl(SG_IO)");
		return (-1);
	}
	if (hdr.status == 0 && hdr.host_status == 0 && hdr.driver_status == 0)
		return 0; /* success */

	if (hdr.status > 0) {
		unsigned char *s = sense + 8;
		/* SCSI status is non-zero, let's go for the error LBA */
		lba = ((u64)s[10] << 40) | ((u64)s[8] << 32) | (s[6] << 24) |
			(s[11] << 16) | (s[9] << 8) | s[7];
		if (0) fprintf(stderr, "SG_IO error: SCSI sense=0x%x/%02x/%02x, ATA=0x%02x/%02x, LBA=%llu (0x%llx)\n",
			sense[1] & 0xf, sense[2], sense[3], s[13], s[3], lba, lba);
		return -1;
	}

	/* some other error we don't know about yet */
	fprintf(stderr, "SG_IO returned: SCSI status=0x%x, host_status=0x%x, driver_status=0x%x",
		hdr.status, hdr.host_status, hdr.driver_status);
	return -1;
}

static void print_drive_model (const char *devpath)
{
	char cmd[256];

	snprintf(cmd, sizeof(cmd), "hdparm -I %s | grep 'Model Number' | sed '-es/^[ 	]*//'", devpath);
	system(cmd);
	snprintf(cmd, sizeof(cmd), "hdparm -I %s | grep 'Firmware Revision' | sed '-es/^[ 	]*//'", devpath);
	system(cmd);
}

int main (int argc, char *argv[])
{
	unsigned char buf[8 * ATA_SECT_SIZE];
	const char *devpath;
	int rc, fd, nsects;
	u64 lba;

	if (argc != 2) {
		fprintf(stderr, "%s: bad/missing parms: expected <devpath>\n", argv[0]);
		exit(1);
	}
	devpath = argv[1];

	fd = open(devpath, O_RDONLY);
	if (fd == -1) {
		perror(devpath);
		exit(1);
	}

	print_drive_model(devpath);

	nsects = 8;
	lba = 0x0ffffff8;
	printf("Reading %u sectors starting at LBA=%llu (0x%llx): ", nsects, lba, lba);
	fflush(stdout);
	rc = sg_read(fd, lba, nsects, buf, 1);
	printf("%s\n", rc ? "FAILED" : "succeeded");

	nsects = 1;
	lba = 0x0fffffff;
	printf("Reading %u sectors starting at LBA=%llu (0x%llx): ", nsects, lba, lba);
	fflush(stdout);
	rc = sg_read(fd, lba, nsects, buf, 1);
	printf("%s\n", rc ? "FAILED" : "succeeded");

	exit(0);
}
