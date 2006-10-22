From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
Date: Sun, 22 Oct 2006 14:44:38 +0200
Message-ID: <453B67B6.9060708@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:41476 "EHLO
	smtp-vbr16.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750739AbWJVMol (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 08:44:41 -0400
Received: from [192.168.10.69] (pindarots.xs4all.nl [82.92.197.115])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9MCicCd095940
	for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 14:44:39 +0200 (CEST)
	(envelope-from udovdh@xs4all.nl)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

2.6.17.13 works OK on this VIA Epia SP8000.
(remember vaguely about some (PCI?) fixups to get things going)

Now I try to get 2.6.18.1 working. SATA is detected by this kernel but
disk gives timeout while 2.6.17.13 boots fine.

Some blurbs:

Links is up but  SStatus 113 SControl 300
qc timeout (cmd 0xec)
failed to IDENTIFY
This results in a kernel panic.

Any ideas?

2.6.17.13 gives stuff like this:

scsi0 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023
88:40ff
ata2: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: ZM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 1:0:0:0: Attached scsi disk sda


Udo

PS: Sorry for sending this also to linux-kernel
