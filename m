From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Wed, 10 Mar 2004 14:54:02 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040310145402.78223378.vsu@altlinux.ru>
References: <200403100006.36405.andres.meyer@computer.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__10_Mar_2004_14_54_02_+0300_4Syl52cjrKpnUJSC"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:62415 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262574AbUCJMA5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2004 07:00:57 -0500
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1B12OO-0002a7-00
	for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2004 13:00:56 +0100
Received: from mivlgu.ru ([81.18.140.87])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2004 13:00:56 +0100
Received: from vsu by mivlgu.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2004 13:00:56 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Signature=_Wed__10_Mar_2004_14_54_02_+0300_4Syl52cjrKpnUJSC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 10 Mar 2004 00:06:36 +0100 Andres Meyer wrote:

> I am trying to get an 2x Opteron system to work. As long as I use the 80GB 
> Maxtor installed on the integrated IDE controller, everything works fine. As 
> soon as I try to use the SATA disks, I get a machine check exception and the 
> system reboots, with the hw clock reset to some silly date.

We had similar problems with our Opteron system with the 2.4.22 kernel
and libata patches:

CPU0: Machine Check Exception: 0000000000000004
CPU1: Machine Check Exception: 0000000000000004
Bank4: b200000000070f0f
Kernel panic: CPU context corrupt
In interrupt handler - not syncing

This was observed on sata_promise with this controller:

Promise Technology|PDC20319 FastTrak SATA150 TX4 Controller [STORAGE_RAID] (vendor:105a device:3319 subv:105a subd:6629)

libata version 0.81 loaded.
sata_promise version 0.87
ata1: SATA max UDMA/133 cmd 0xF8835200 ctl 0xF8835238 bmdma 0x0 irq 25
ata2: SATA max UDMA/133 cmd 0xF8835280 ctl 0xF88352B8 bmdma 0x0 irq 25
ata3: SATA max UDMA/133 cmd 0xF8835300 ctl 0xF8835338 bmdma 0x0 irq 25
ata4: SATA max UDMA/133 cmd 0xF8835380 ctl 0xF88353B8 bmdma 0x0 irq 25
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors (lba48)
ata2: dev 0 configured for UDMA/133
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata3: dev 0 ATA, max UDMA/133, 312581808 sectors (lba48)
ata3: dev 0 configured for UDMA/133
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata4: dev 0 ATA, max UDMA/133, 312581808 sectors (lba48)
ata4: dev 0 configured for UDMA/133
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
scsi3 : sata_promise
  Vendor: ATA       Model: ST3160023AS       Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
 sdc: sdc1
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
 sdd: sdd1

> This one here happened within ca. 7s when trying to write some zeros 
> (cat /dev/zero > test.file) to the first 160GB disk. On the disk, after 
> reboot, there was a very small test.file.

In our case the problem did not appear so fast - the machine crashed
while copying about 20 GB from  /dev/sda to /dev/sdc, from /dev/sdd to
/dev/sdc and from /dev/sdc to /dev/sda.

The problem disappeared after replacing the Promise controller with a
Silicon Image one:

01:05.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)

However, it might be just because the siimage driver is much slower
due to the Seagate workaround...

--Signature=_Wed__10_Mar_2004_14_54_02_+0300_4Syl52cjrKpnUJSC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATwHdW82GfkQfsqIRAjYSAJ4iqf8qNyWaIbeA/YQETVme3YL+UACfV+nn
CTKT2aG7EF+bYr0huxSVCYk=
=eQIt
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Mar_2004_14_54_02_+0300_4Syl52cjrKpnUJSC--

