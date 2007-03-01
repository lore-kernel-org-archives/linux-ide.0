From: "Gregor Jasny" <gjasny@googlemail.com>
Subject: libata: 30sec delay during boot with cdrom attached
Date: Thu, 1 Mar 2007 17:39:08 +0100
Message-ID: <9d2cd630703010839x1cd9a8b1rd2e6575eb5a9d615@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:12558 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965352AbXCAQjJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 11:39:09 -0500
Received: by an-out-0708.google.com with SMTP id b33so436268ana
        for <linux-ide@vger.kernel.org>; Thu, 01 Mar 2007 08:39:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

after switching to libata on my old Dell notebook, I get a 30 seconds
long delay during boot. If I remove the CDROM the boot process is as
fast as with the old ide driver.

Boot with cdrom:
[   28.103034] ata_piix 0000:00:07.1: version 2.00ac7
[   28.103234] ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0x860 irq 14
[   28.103841] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x868 irq 15
[   28.104535] scsi0 : ata_piix
[   28.263015] ata1.00: ATA-7, max UDMA/100, 78242976 sectors: LBA48
[   28.263486] ata1.00: ata1: dev 0 multi count 8
[   28.269671] ata1.00: configured for UDMA/33
[   28.270001] scsi1 : ata_piix
^-- Hangs here
[   58.594321] ata2.00: ATAPI, max UDMA/33
[   58.754241] ata2.00: configured for UDMA/33
[   58.754852] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG
MP0402H  UC10 PQ: 0 ANSI: 5
[   58.755787] SCSI device sda: 78242976 512-byte hdwr sectors (40060 MB)
[   58.756312] sda: Write Protect is off
[   58.756595] sda: Mode Sense: 00 3a 00 00
[   58.756657] SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   58.757459] SCSI device sda: 78242976 512-byte hdwr sectors (40060 MB)
[   58.757976] sda: Write Protect is off
[   58.758258] sda: Mode Sense: 00 3a 00 00
[   58.758318] SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   58.758984]  sda: sda1 sda2 sda3 sda4
[   59.212482] sd 0:0:0:0: Attached scsi disk sda
[   59.213005] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   59.213930] scsi 1:0:0:0: CD-ROM            SAMSUNG  CD-ROM SN-124
  N102 PQ: 0 ANSI: 5
[   59.236734] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   59.252814] Uniform CD-ROM driver Revision: 3.20
[   59.269038] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   59.269228] sr 1:0:0:0: Attached scsi generic sg1 type 5

My notebook has a PIIX4 controller:
IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)

This happens with all libata enabled kernels including the latest git
snapshot (2.6.21-rc2).

Can anyone shed some light on this?

Thanks,
Gregor

PS: As far as I remember this cdrom was blacklisted for DMA or
whatever reasons in early Linux 2.6 kernels.
