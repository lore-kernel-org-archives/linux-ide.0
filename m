From: "Theepan" <tornado@linuxfromscratch.org>
Subject: IDE Performance issues
Date: Tue, 2 Sep 2003 07:59:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <002a01c37117$68abc560$0200a8c0@tornado>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from x1-6-00-a0-c9-de-85-f2.k78.webspeed.dk ([80.197.249.79]:41101
	"EHLO storm.stormchasers.dk") by vger.kernel.org with ESMTP
	id S263526AbTIBF77 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Sep 2003 01:59:59 -0400
Received: from tornado (tornado.lan [192.168.0.2])
	by storm.stormchasers.dk (Postfix) with SMTP id 9F5B46B8002
	for <linux-ide@vger.kernel.org>; Tue,  2 Sep 2003 08:00:31 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

(I tried to send his mail to both linux-ide@ and linux-raid@ lists, but it
only arrived at linux-raid@ - I guess one cannot specify multiple targets in
the To: field, which is why I'm resending to this list only. I've also
edited this email to exclude RAID details.)


I am experiencing performance issues with the IDE/PCI subsystem that seems
to limit the "disk performance" to somewhat ATA66 mode when both disks and
ATA controllers are ATA133 capable.

zcav, a tool from bonnie++ package, was used to measure the sequential read
rate. All disks were able to sustain minimum 30MB/s when accessed
seperately. When accessed simultaneously I get these results:

When accessing 1 disk, the read rate was 30MB/s (as expected).
When accessing 2 disks, the read rate was 60MB/s (30MB/s on each disk, as
expected)
When accessing 3 disks, the read rate was 60MB/s (20MB/s on each disk,
dropping 10Mb/s)
When accessing 4 disks, the read rate was 60MB/s (15MB/s on each disk,
dropping 15Mb/s)

A quick look at the results show that the maximum performance achived was
60MB/s no matter how many disks (2+) were involved - the same performance
you could/would expect from a ATA66 system. On a 32bit system where the
PCI bus operates as 33mhz, one would expect the maximum theoretical
throughput to be 133MB/s (or 127,x MB/s).

I have 2 x Promise TX2 ATA133 (PDC20269) Controller and 4 Maxtor 120GB
disks (3 x 5400RPM and 1 x 7200RPM, all disks are ATA133 capable and
operate in this mode according to hdparm). DMA and 32bit is enabled on the
disks using hdparm as well. The disks are attached as master only, that is
one
disk per IDE channel.

The system is a Dual P3-500mhz wih 256MB RAM.
The motherboard is SOYO SY-D6IBA with 440BX chipset.
I'm running Debian Linux and kernel 2.4.22 (vanilla kernel with only
lm_sensors and i2c patched).
The onboard SCSI is disabled as I have no use of it.


LILO has "ide2=ata66 ide3=ata66 ide4=ata66 ide5=ata66" appended, becase I've
read that this instructs the kernel to use some ATA66+ calls and thereby
utilizing the ATA66 (and higher).

Anyone have any idea what this is about (maybe by first hand experience) and
why? - and preferably also how I would go about "fixing" it.


If there's need for output from lcpci, dmesg etc, let me know - I have them
ready. I do not know if these lists prefer outputs attached or included as
body in the email - which is why I didn't include them at all in any way.


--
Theepan


