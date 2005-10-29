From: Bram Stolk <bram@sara.nl>
Subject: assertion failure in libata-core
Date: Sat, 29 Oct 2005 19:09:50 +0200
Message-ID: <4363ACDE.1060408@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from amsfep13-int.chello.nl ([213.46.243.23]:12356 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750981AbVJ2RKE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Oct 2005 13:10:04 -0400
Received: from [192.168.192.8] (really [24.132.4.119])
          by amsfep13-int.chello.nl
          (InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
          id <20051029170950.LBYM12936.amsfep13-int.chello.nl@[192.168.192.8]>
          for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 19:09:50 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,


I've been trying very hard to get my sata dvd burner to work.
It is a plextor PX-716SA.

I tried the following kernels:

linux-2.6.14-rc5
linux-2.6.14
linux-2.6.14-rc5-mm1 (contains sil24 support)

All with the same result: assertion failure.

Assertion failed! qc->flags &
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3232

Now, my board has 2 sata interfaces: one from intel,
and one from Sillicon Image.

If I use libata.atapi_enabled=1 and connect the drive to the
intel sata, I get the assertion mentioned above.

If I connect the drive to the sil sata, it is not detected,
and I get this error:
sata_sil24 version 0.22
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:05:00.0 to 64
ata5: SATA max UDMA/100 cmd 0xF8838000 ctl 0x0 bmdma 0x0 irq 19
ata6: SATA max UDMA/100 cmd 0xF883A000 ctl 0x0 bmdma 0x0 irq 19
ata5: no device found (phy stat 00000000)
scsi4 : sata_sil24
sata_sil24 ata6: error interrupt on port1
   stat=0x80000001 irq=0xb60002 cmd_err=1 sstatus=0x113 serror=0x0
sata_sil24 ata6: resetting controller...
scsi5 : sata_sil24

How can I use this SATA DVD drive under linux on sata-ahci or sata-sil24?

thanks,

   Bram Stolk
