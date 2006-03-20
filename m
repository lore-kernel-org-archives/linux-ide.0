From: Gordon Atwood <gordon@cs.ualberta.ca>
Subject: sata_promise does not see hardware RAID arrays on Fasttrak TX4000
Date: Mon, 20 Mar 2006 12:47:28 -0700
Message-ID: <20060320194728.GA17279@cs.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sunkay.cs.ualberta.ca ([129.128.4.11]:6322 "EHLO
	sunkay.cs.ualberta.ca") by vger.kernel.org with ESMTP
	id S964942AbWCTTr5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Mar 2006 14:47:57 -0500
Received: from fleet.cs.ualberta.ca ([129.128.22.22]:40170 "EHLO
	fleet.cs.ualberta.ca") by sunkay.cs.ualberta.ca with ESMTP
	id S559087AbWCTTru (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Mar 2006 12:47:50 -0700
Received: from fleet.cs.ualberta.ca (localhost.localdomain [127.0.0.1])
	by fleet-spampd (Postfix) with ESMTP id 2A78728005
	for <linux-ide@vger.kernel.org>; Mon, 20 Mar 2006 12:47:29 -0700 (MST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Gordon Atwood <gordon@cs.ualberta.ca>

Ok, I've searched thru dozens of webpages and done the RTFM thing.  If its
really obvious, sorry, I still missed it.

I'm emailing this to the listed maintainer for the sata_promise code and
the mailing list as indicated in the comments for sata_promise.c.  I've
only included what I think are the salient pieces of information but
I'm quite willing to deluge you with more if you want :-)

I have a Promise Fastrak TX4000 which works 'perfectly' under 2.4.20-30.9
Red Hat Linux release 9 (Shrike) using the ft3xx driver from Promise.  It
has 4 80Gb drives configuered at 2 striped arrays.  Note, this is, I guess,
what you'd call a PATA controller.  These are NOT SATA disks.

However, we are trying to move all our user workstations to the Scientific
Linux distribution and under their stream of 2.6 kernels the card is not
working properly.

Initially I started with the basice kernel supplied thru the
scientificlinux.org 4.2 distribution.  Their 2.6.9-34 version is able to
see the card and disks, but not the hardware array.

I even went to kernel.org (today) and retrieved, compiled and tested the
base 2.6.16 release.  Same results.

Is hardware RAID simply not supported?  Is the assumption that the users
will just configure the Promise card BIOS to present 4 arrays, one for
each disk and then use software RAID on top of that?

Or is the solution so obvious that I'm just missing it?

Please note that there is no option in the Promise BIOS to turn off the
RAID and simply present 4 disks to the bus.  The only way (that I can see to
do this) is to configure 4 one-disk arrays.  Nor is there a mainboard BIOS
selection to do this either (that I can see) for this particular mainboard.

At present the machine is configured with two IDE drives to boot from.
One with the 2.4 kernel and the other with the 2.6 kernel.  They both boot
fine so this is not a problem with cabling or switching hardware around.

---

Here is the 'essential' dmesg output from the working 2.4 boot:

  PROMISE FastTrak TX4000/376/378/S150 TX Series Linux Driver Version 1.00.0.19 
  scsi1 : ft3xx
    Vendor: Promise   Model: 2+0 Stripe/RAID0  Rev: 1.10
    Type:   Direct-Access                      ANSI SCSI revision: 02
    Vendor: Promise   Model: 2+0 Stripe/RAID0  Rev: 1.10
    Type:   Direct-Access                      ANSI SCSI revision: 02
  Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
  Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
  SCSI device sda: 312497920 512-byte hdwr sectors (159999 MB)
   sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
  SCSI device sdb: 312602624 512-byte hdwr sectors (160053 MB)
   sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >

As you can see it identifies 2 striped arrays and configures them as sda
and sdb.  The partition tables are correctly recognized and all is good.

At this point the partitions can be mounted from sda and sdb and all the
data checks out perfectly.

-

>From the non-working 2.6.13 boot:

  SCSI subsystem initialized
  libata version 1.20 loaded.
  sata_promise 0000:00:0a.0: version 1.03
  ata1: PATA max UDMA/133 cmd 0xF882A200 ctl 0xF882A238 bmdma 0x0 irq 5
  ata2: PATA max UDMA/133 cmd 0xF882A280 ctl 0xF882A2B8 bmdma 0x0 irq 5
  ata3: PATA max UDMA/133 cmd 0xF882A300 ctl 0xF882A338 bmdma 0x0 irq 5
  ata4: PATA max UDMA/133 cmd 0xF882A380 ctl 0xF882A3B8 bmdma 0x0 irq 5
  ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3e01 87:4003 88:203f
  ata1: dev 0 ATA-6, max UDMA/100, 156250000 sectors: LBA48
  ata1: dev 0 configured for UDMA/33
  scsi0 : sata_promise
  ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3e01 87:4003 88:203f
  ata2: dev 0 ATA-6, max UDMA/100, 156250000 sectors: LBA48
  ata2: dev 0 configured for UDMA/33
  scsi1 : sata_promise
  ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:203f
  ata3: dev 0 ATA-6, max UDMA/100, 156301488 sectors: LBA48
  ata3: dev 0 configured for UDMA/33
  scsi2 : sata_promise
  input: PS/2 Logitech Mouse as /class/input/input1
  ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:5823 85:3469 86:3c01 87:4023 88:203f
  ata4: dev 0 ATA-6, max UDMA/100, 156301488 sectors: LBA48
  ata4: dev 0 configured for UDMA/33
  scsi3 : sata_promise
    Vendor: ATA       Model: ST380011A         Rev: 3.16
    Type:   Direct-Access                      ANSI SCSI revision: 05
  SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
  sda: Write Protect is off
  sda: Mode Sense: 00 3a 00 00
  SCSI device sda: drive cache: write back
  SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
  sda: Write Protect is off
  sda: Mode Sense: 00 3a 00 00
  SCSI device sda: drive cache: write back
   sda: sda1 sda2 sda3 sda4 < >
  sd 0:0:0:0: Attached scsi disk sda
    Vendor: ATA       Model: ST380011A         Rev: 3.16
    Type:   Direct-Access                      ANSI SCSI revision: 05
  SCSI device sdb: 156250000 512-byte hdwr sectors (80000 MB)
  sdb: Write Protect is off
  sdb: Mode Sense: 00 3a 00 00
  SCSI device sdb: drive cache: write back
  SCSI device sdb: 156250000 512-byte hdwr sectors (80000 MB)
  sdb: Write Protect is off
  sdb: Mode Sense: 00 3a 00 00
  SCSI device sdb: drive cache: write back
   sdb: unknown partition table
  sd 1:0:0:0: Attached scsi disk sdb
    Vendor: ATA       Model: ST380011A         Rev: 3.06
    Type:   Direct-Access                      ANSI SCSI revision: 05
  SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
  sdc: Write Protect is off
  sdc: Mode Sense: 00 3a 00 00
  SCSI device sdc: drive cache: write back
  SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
  sdc: Write Protect is off
  sdc: Mode Sense: 00 3a 00 00
  SCSI device sdc: drive cache: write back
   sdc: sdc1 sdc2 sdc3 sdc4 < >
  sd 2:0:0:0: Attached scsi disk sdc
    Vendor: ATA       Model: ST380011A         Rev: 8.01
    Type:   Direct-Access                      ANSI SCSI revision: 05
  SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
  sdd: Write Protect is off
  sdd: Mode Sense: 00 3a 00 00
  SCSI device sdd: drive cache: write back
  SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
  sdd: Write Protect is off
  sdd: Mode Sense: 00 3a 00 00
  SCSI device sdd: drive cache: write back
   sdd: unknown partition table
  sd 3:0:0:0: Attached scsi disk sdd

As you can see, all four disks are seen by the driver, but each is
configured as an individual disk

At this point the partition tables are totally out of whack (as I would
expect since they are probably striped across both disk 1&2 and 3&4).

===

So, aside from tossing the TX4000 in the trash can anyone offer a solution
for getting the driver to see the existing hardware RAID arrays on it?

Or, can anyone tell me what overhead I'm likely incurring if I configure the
TX4000 to have 4 arrays of one-disk each and then put software RAID or LVM
on top of that?  I'm assuming the TX4000 will not be smart enough to just
drop its own Hardware RAID code for a one-disk array.

Anyway, thoughts?  comments?  funny stories?

G.H.A.
-- 
Gordon H. Atwood		              E-mail:  gordon@cs.ualberta.ca
Systems Support Group Administrator	    Phone:  (780) 492-9930
Department of Computing Science         Fax:  (780) 492-1071
University of Alberta                WWW:  http://web.cs.ualberta.ca/~gordon
