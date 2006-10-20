From: Tejun Heo <htejun@gmail.com>
Subject: Re: Question about Scsi error handling/recovery
Date: Fri, 20 Oct 2006 17:10:50 +0900
Message-ID: <20061020081050.GG13677@htj.dyndns.org>
References: <8202f4270610181711k7b15f81bw589f956f6e521988@mail.gmail.com> <4536D9FD.4050708@gmail.com> <8202f4270610190822g71992718ka17858321e2affb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:24756 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992581AbWJTIK7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 04:10:59 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1342136nfe
        for <linux-ide@vger.kernel.org>; Fri, 20 Oct 2006 01:10:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8202f4270610190822g71992718ka17858321e2affb7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2006 at 09:22:59AM -0600, Fajun Chen wrote:
> Note that it took less than 3 seconds for ata1 to be reconfigured as
> sg1. My user space application opened sg1 for ioctl -
> SCSI_IOCTL_GET_BUS_NUMBER once it's available but got block for around
> 11 seconds.  It seems the ioctl call was unblocked until the error
> recovery on ata2 was completed at time stamp 14068.  I suspect it's
> blocked in the scsi_ioctl.c:
> int scsi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
> {
> 	char scsi_cmd[MAX_COMMAND_SIZE];
> 
> 	/* No idea how this happens.... */
> 	if (!sdev)
> 		return -ENXIO;
> 
> 	/*
> 	 * If we are in the middle of error recovery, don't let anyone
> 	 * else try and use this device.  Also, if error recovery fails, it
> 	 * may try and take the device offline, in which case all further
> 	 * access to the device is prohibited.
> 	 */
> 	if (!scsi_block_when_processing_errors(sdev))
> 		return -ENODEV;
> ...
> }
> 
> If the ioctl() on sg1/ata1 was not blocked due to ata2 error recovery,
> then where it could be blocked?

My test says otherwise.  What I did was...

1. execute "./testsg /dev/sg0"
2. hotplug one harddrive (took ~3secs)
3. hotplug another drive (took ~6secs)

The result is...

# ./testsg /dev/sg0
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
[  127.205451] ata6: (irq_stat 0x00b40090, PHY RDY changed)
[  127.721061] ata6: waiting for device to spin up (8 secs)
[  133.077235] ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
[  133.084452] ata5: (irq_stat 0x00a00080, device exchanged)
[  133.599527] ata5: waiting for device to spin up (8 secs)
[  135.903791] ata6: soft resetting port
[  136.007637] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  136.018667] ata6.00: ATA-7, max UDMA7, 312581808 sectors: LBA48 NCQ (depth 31
/32)
[  136.026217] ata6.00: ata6: dev 0 multi count 16
[  136.057713] ata6.00: configured for UDMA/100
[  136.062050] ata6: EH complete
[  137.062103] scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG HD160JJ  ZM10 PQ
: 0 ANSI: 5
[  137.071696] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[  137.078695] sda: Write Protect is off
[  137.082751] SCSI device sda: drive cache: write back
[  137.088087] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[  137.095156] sda: Write Protect is off
[  137.099203] SCSI device sda: drive cache: write back
[  137.104261]  sda: unknown partition table
[  137.115839] sd 5:0:0:0: Attached scsi disk sda
[  137.120480] sd 5:0:0:0: Attached scsi generic sg0 type 0
open succeeded after 13859ms
ioctl completed after 0ms, rc=0, bus=5

--> ioctl is executed back-to-back to open

[root@jtj:~/ttmp]#

--> testsg is complete at this point

[  141.798233] ata5: soft resetting port
[  141.902079] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  141.909519] ata5.00: ATA-7, max UDMA/133, 160086528 sectors: LBA NCQ (depth 3
1/32)
[  141.917170] ata5.00: ata5: dev 0 multi count 0
[  141.923737] ata5.00: configured for UDMA/100
[  141.928073] ata5: EH complete
[  142.928568] scsi 4:0:0:0: Direct-Access     ATA      Maxtor 6B080M0   BANC PQ
: 0 ANSI: 5
[  142.938171] SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
[  142.945046] sdb: Write Protect is off
[  142.949056] SCSI device sdb: drive cache: write back
[  142.954352] SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
[  142.961186] sdb: Write Protect is off
[  142.965239] SCSI device sdb: drive cache: write back
[  142.970289]  sdb: unknown partition table
[  142.992997] sd 4:0:0:0: Attached scsi disk sdb
[  142.997629] sd 4:0:0:0: Attached scsi generic sg1 type 0

Your wait is somewhere else.

-- 
tejun

--ZPt4rx8FFjLCG7dd
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="testsg.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <scsi/scsi.h>

int main(int argc, char **argv)
{
	const struct timespec ts_1ms = { 0, 1000000 };
	struct timeval tv0, tv1, result;
	unsigned long interval;
	int rc, fd, bus;

	if (argc < 2)
		fprintf(stderr, "Usage: testsg SGFILE\n");

	gettimeofday(&tv0, NULL);

	while (1) {
		fd = open(argv[1], O_RDONLY);
		if (fd >= 0 || errno != ENOENT)
			break;
		nanosleep(&ts_1ms, NULL);
	}

	gettimeofday(&tv1, NULL);
	timersub(&tv1, &tv0, &result);
	interval = result.tv_sec * 1000 + result.tv_usec / 1000;

	if (fd < 0) {
		fprintf(stderr, "open failed (%s) after %lums\n",
			strerror(errno), interval);
		return 1;
	}

	printf("open succeeded after %lums\n", interval);

	gettimeofday(&tv0, NULL);

	rc = ioctl(fd, SCSI_IOCTL_GET_BUS_NUMBER, &bus);

	gettimeofday(&tv1, NULL);
	timersub(&tv1, &tv0, &result);
	interval = result.tv_sec * 1000 + result.tv_usec / 1000;

	printf("ioctl completed after %lums, rc=%d, bus=%d\n",
	       interval, rc, bus);

	return 0;
}

--ZPt4rx8FFjLCG7dd--
