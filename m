From: Tejun Heo <htejun@gmail.com>
Subject: Re: M-Systems SATA FFD fails IDENTIFY cmd
Date: Tue, 31 Oct 2006 19:19:20 +0900
Message-ID: <45472328.4030504@gmail.com>
References: <20061024182054.GA19657@socrates.bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:24031 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423080AbWJaKT3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 05:19:29 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1399554ugm
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 02:19:28 -0800 (PST)
In-Reply-To: <20061024182054.GA19657@socrates.bork.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Hicks <mort@bork.org>
Cc: linux-ide@vger.kernel.org

Martin Hicks wrote:
> Hi,
> 
> I've got a few M-Systems SATA FFD 2.5" solid state disks that behave
> strangely with some drivers.
> 
> When probing the disks on an Asus P5P800-MX motherboard's onboard SATA
> and with an embedded PPC440gx machine with an on-board Intel 31244
> (sata_vsc) SATA controller I get the following:
> 
> mort@seaking:~$ sudo modprobe ata_piix
> Oct 24 12:54:15 localhost kernel: ata_piix 0000:00:1f.2: version 2.00ac6
> Oct 24 12:54:15 localhost kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> Oct 24 12:54:15 localhost kernel: PCI: Enabling device 0000:00:1f.2 (0000 -> 0001)
> Oct 24 12:54:15 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> Oct 24 12:54:15 localhost kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
> Oct 24 12:54:15 localhost kernel: ata11: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 16
> Oct 24 12:54:15 localhost kernel: ata12: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 16
> Oct 24 12:54:15 localhost kernel: scsi10 : ata_piix
> Oct 24 12:54:45 localhost kernel: ata11.00: qc timeout (cmd 0xec)
> Oct 24 12:54:45 localhost kernel: ata11.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> Oct 24 12:54:46 localhost kernel: ata11.00: ATA-6, max UDMA/100, 16074752 sectors: LBA 
> Oct 24 12:54:46 localhost kernel: ata11.00: ata11: dev 0 multi count 2
> Oct 24 12:54:46 localhost kernel: ata11.00: applying bridge limits
> Oct 24 12:54:46 localhost kernel: ata11.00: configured for UDMA/100
> Oct 24 12:54:46 localhost kernel: scsi11 : ata_piix
> Oct 24 12:54:46 localhost kernel: ATA: abnormal status 0x7F on port 0xA807
> Oct 24 12:54:46 localhost kernel: scsi 10:0:0:0: Direct-Access     ATA      M-Systems FFD Se 1.03 PQ: 0 ANSI: 5
> Oct 24 12:54:46 localhost kernel: SCSI device sda: 16074752 512-byte hdwr sectors (8230 MB)
> Oct 24 12:54:46 localhost kernel: sda: Write Protect is off
> Oct 24 12:54:46 localhost kernel: sda: Mode Sense: 00 3a 00 00
> Oct 24 12:54:46 localhost kernel: SCSI device sda: drive cache: write back
> Oct 24 12:54:46 localhost kernel: SCSI device sda: 16074752 512-byte hdwr sectors (8230 MB)
> Oct 24 12:54:46 localhost kernel: sda: Write Protect is off
> Oct 24 12:54:46 localhost kernel: sda: Mode Sense: 00 3a 00 00
> Oct 24 12:54:46 localhost kernel: SCSI device sda: drive cache: write back
> Oct 24 12:54:46 localhost kernel:  sda: unknown partition table
> Oct 24 12:54:46 localhost kernel: sd 10:0:0:0: Attached scsi disk sda
> 
> 
> As you can see the INQUIRY command fails after 30 seconds. The x86/ata_piix
> machine is running 2.6.19-rc3.  The PPC/sata_vsc machine is running
> 2.6.18.

Can you try 2.6.19-rc3-mm1 and report the result?  Thanks.

-- 
tejun
