From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Wed, 5 Dec 2007 08:46:51 +0100
Message-ID: <8db1092f0712042346m38182aafn953077c0c090bdad@mail.gmail.com>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>
	 <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
	 <4755C544.5060909@garzik.org> <4755C63B.7080608@garzik.org>
	 <8db1092f0712041448t5a3da9ecna73730e421626450@mail.gmail.com>
	 <4755DC07.5090009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:42970 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXLEHqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:46:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6898023wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:46:53 -0800 (PST)
In-Reply-To: <4755DC07.5090009@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

2007/12/5, Jeff Garzik <jeff@garzik.org>:

>
> _If_ libata is built into the kernel, and not a kernel module, then you
> can supply "libata.noacpi=1" on the kernel command line.  I don't think
> that works with modules.
>

With libata.noacpi=1"  kernel command line, errors has gone:
http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/dmesg_libata_noacpi.txt.gz

ahci 0000:00:1f.2: nr_ports (4) and implemented port map (0x1) don't
match, using nr_ports
ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 220
ata2: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585180 irq 220
ata3: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585200 irq 220
ata4: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585280 irq 220
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: ST9120822AS, 3.ALC, max UDMA/133
ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      ST9120822AS      3.AL PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: [sda] Attached SCSI disk

Thanks for help.
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
