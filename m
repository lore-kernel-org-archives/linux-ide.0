From: Jan Killius <jkillius@arcor.de>
Subject: worst via_sata performance
Date: Thu, 1 Apr 2004 03:57:56 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404010357.57111.jkillius@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:43682 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261935AbUDAB6C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2004 20:58:02 -0500
Received: from unigate.homeip.net (dsl-082-082-126-052.arcor-ip.net [82.82.126.52])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 17C60A46810
	for <linux-ide@vger.kernel.org>; Thu,  1 Apr 2004 03:58:01 +0200 (CEST)
Received: from [192.168.0.4] (unknown [192.168.0.4])
	by unigate.homeip.net (Postfix) with ESMTP id 1494B92477
	for <linux-ide@vger.kernel.org>; Thu,  1 Apr 2004 03:57:57 +0200 (CEST)
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
I have some problems with the via_sata driver. The performance is really bad. 
I'm getting about 20Mb/s which is really slow compared with the generic ide 
driver(50 MB/s). Is there any way to speed up it a bit? I use the two discs 
together with the drive mapper for raid0 but the performance is bad and not 
constant it's stuttering at disc writing to the raid device. Here are some 
system information.


Mainboard: asus k8v se
kernel: 2.6.5-rc3-mm3 with 2.6.5-rc3-libata2
dmesg:
libata version 1.02 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 10
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 10
ata1: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3e02 87:4023 
88:203f
ata1: dev 0 ATA, max UDMA/100, 321672960 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3e02 87:4023 
88:203f
ata2: dev 0 ATA, max UDMA/100, 321672960 sectors (lba48)
ata2: dev 0 configured for UDMA/100
scsi1 : sata_via
  Vendor: ATA       Model: HDS722516VLSA80   Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: dev 0 max request 32MB (lba48)
  Vendor: ATA       Model: HDS722516VLSA80   Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: dev 0 max request 32MB (lba48)
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
SCSI device sda: drive cache: write through
 sda: sda1 < > sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 321672960 512-byte hdwr sectors (164697 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
