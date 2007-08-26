From: "Dong Feng" <middle.fengdong@gmail.com>
Subject: 2.6.22.5 SATA Failure
Date: Sun, 26 Aug 2007 09:55:22 +0800
Message-ID: <a2ebde260708251855j708d2b33hfce905f623597325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:12599 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933552AbXHZBzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Aug 2007 21:55:24 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1541706wah
        for <linux-ide@vger.kernel.org>; Sat, 25 Aug 2007 18:55:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

I have been using 2.6.21.1. It seems working well, that is, all my
disk partitions are mapped as "/dev/sda*" and the performance looks
good. After I upgrade to 2.6.22.5 with the exact same configuration,
all the disk device turn to "/dev/hda*" and the performance degrade
obviously.

While I boot with 2.6.21.1, the logs regarding disk are:

Aug 26 06:11:26 localhost kernel: ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
Aug 26 06:11:26 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B]
-> GSI 17 (level, low) -> IRQ 17
Aug 26 06:11:26 localhost kernel: ata: 0x170 IDE port busy
Aug 26 06:11:26 localhost kernel: ata: conflict with ide1
Aug 26 06:11:26 localhost kernel: ata1: SATA max UDMA/133 cmd
0x000101f0 ctl 0x000103f6 bmdma 0x0001bfa0 irq 14
Aug 26 06:11:26 localhost kernel: ata2: DUMMY
Aug 26 06:11:26 localhost kernel: scsi0 : ata_piix
Aug 26 06:11:26 localhost kernel: ata1.00: ATA-7: ST9120821AS, 8.03,
max UDMA/133
Aug 26 06:11:26 localhost kernel: ata1.00: 234441648 sectors, multi 8:
LBA48 NCQ (depth 0/32)
Aug 26 06:11:26 localhost kernel: ata1.00: configured for UDMA/133
Aug 26 06:11:26 localhost kernel: scsi1 : ata_piix
Aug 26 06:11:26 localhost kernel: scsi 0:0:0:0: Direct-Access     ATA
    ST9120821AS      8.03 PQ: 0 ANSI: 5
Aug 26 06:11:26 localhost kernel: SCSI device sda: 234441648 512-byte
hdwr sectors (120034 MB)
Aug 26 06:11:26 localhost kernel: sda: Write Protect is off
Aug 26 06:11:26 localhost kernel: SCSI device sda: write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
Aug 26 06:11:26 localhost kernel: SCSI device sda: 234441648 512-byte
hdwr sectors (120034 MB)
Aug 26 06:11:26 localhost kernel: sda: Write Protect is off
Aug 26 06:11:26 localhost kernel: SCSI device sda: write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
Aug 26 06:11:26 localhost kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >



While booting with 2.6.22.5, the logs are:

Aug 26 09:30:04 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B]
-> GSI 17 (level, low) -> IRQ 17
Aug 26 09:30:04 localhost kernel: ata_piix 0000:00:1f.2: 0x1F0 IDE port busy
Aug 26 09:30:04 localhost kernel: ata_piix 0000:00:1f.2: 0x170 IDE port busy
Aug 26 09:30:04 localhost kernel: ata_piix 0000:00:1f.2: no available
legacy port



It seems the dramatic change in libata.c incurs this failure.
