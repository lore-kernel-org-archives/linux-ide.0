From: Tejun Heo <tj@kernel.org>
Subject: Re: Q67 and QM67 COMRESET solved by skip_host_reset=1
Date: Wed, 25 May 2011 11:36:17 +0200
Message-ID: <20110525093617.GE10146@htj.dyndns.org>
References: <BANLkTinYpjMgqqmtEuPsZSTGb0ENGWKf8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35836 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab1EYJgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2011 05:36:22 -0400
Received: by bwz15 with SMTP id 15so6367329bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2011 02:36:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinYpjMgqqmtEuPsZSTGb0ENGWKf8g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, dan.j.williams@intel.com, seth.heasley@intel.com, Matthew Wilcox <matthew@wil.cx>

Cc'ing Intel people and Jeff.  Hi!

Any ideas what's going on with the following?  In short, on sandy
bridge ahci + intel g2 ssd, doing HOST_RESET during initialization
makes the first reset timeout inducing 10 sec delay.

Thanks.

On Sun, May 22, 2011 at 08:57:05AM -0400, Andrew Lutomirski wrote:
> I have a Sandy Bridge laptop with an SSD (Intel G2).  On startup and
> resume, I get a ten-second delay or so, COMRESET failed, and then the
> disk comes up.  On Windows, or in compatibility mode, or with
> libahci.skip_host_reset=1, the disk comes up instantly.  I have a
> similar problem on a Q67 desktop machine with a different brand SSD.
> One of these systems has ATA security enabled, and the other does not.
> 
> I have this problem on 2.6.38 and 2.6.39, and I'd be happy to test
> patches or other things.
> 
> good:
> 
> [    0.662024] ahci 0000:00:1f.2: version 3.0
> [    0.662035] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> [    0.662091] ahci 0000:00:1f.2: irq 42 for MSI/MSI-X
> [    0.662119] ahci: SSS flag set, parallel bus scan disabled
> [    0.662128] ahci 0000:00:1f.2: skipping global host reset
> [    0.664096] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6
> Gbps 0x13 impl SATA mode
> [    0.664105] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm
> led clo pio slum part ems sxs apst
> [    0.664117] ahci 0000:00:1f.2: setting latency timer to 64
> [    0.668557] scsi0 : ahci
> [    0.668630] scsi1 : ahci
> [    0.668687] scsi2 : ahci
> [    0.668741] scsi3 : ahci
> [    0.668797] scsi4 : ahci
> [    0.668852] scsi5 : ahci
> [    0.669236] ata1: SATA max UDMA/133 abar m2048@0x92628000 port
> 0x92628100 irq 42
> [    0.669239] ata2: SATA max UDMA/133 abar m2048@0x92628000 port
> 0x92628180 irq 42
> [    0.669241] ata3: DUMMY
> [    0.669241] ata4: DUMMY
> [    0.669244] ata5: SATA max UDMA/133 abar m2048@0x92628000 port
> 0x92628300 irq 42
> [    0.669245] ata6: DUMMY
> 
> ...
> 
> [    0.975730] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    0.976165] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> [    0.976168] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
> LOCK) filtered out
> [    0.976171] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
> filtered out
> [    0.976510] ata1.00: ATA-7: INTEL SSDSA2M160G2GC, 2CV102HA, max UDMA/133
> [    0.976520] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [    0.977032] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> [    0.977036] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
> LOCK) filtered out
> [    0.977038] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
> filtered out
> [    0.977323] ata1.00: configured for UDMA/133
> [    0.977470] scsi 0:0:0:0: Direct-Access     ATA      INTEL
> SSDSA2M160 2CV1 PQ: 0 ANSI: 5
> [    0.977597] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    0.977709] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks:
> (160 GB/149 GiB)
> [    0.977809] sd 0:0:0:0: [sda] Write Protect is off
> [    0.977811] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    0.977841] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    0.978060] sda: detected capacity change from 0 to 160041885696
> [    0.978323]  sda: sda1 sda2 sda3
> [    0.978628] sd 0:0:0:0: [sda] Attached SCSI disk
> 
> bad:
> 
> [    0.696979] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> [    0.697146] ahci: SSS flag set, parallel bus scan disabled
> [    0.708221] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6
> Gbps 0x13 impl SATA mode
> [    0.708403] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm
> led clo pio slum part ems sxs apst
> [    0.712672] scsi0 : ahci
> [    0.712833] scsi1 : ahci
> [    0.712980] scsi2 : ahci
> [    0.713127] scsi3 : ahci
> [    0.713286] scsi4 : ahci
> [    0.713432] scsi5 : ahci
> [    0.713892] ata1: SATA max UDMA/133 abar m2048@0x92628000 port
> 0x92628100 irq 42
> [    0.714038] ata2: SATA max UDMA/133 abar m2048@0x92628000 port
> 0x92628180 irq 42
> [    0.714197] ata3: DUMMY
> [    0.714287] ata4: DUMMY
> [    0.714377] ata5: SATA max UDMA/133 abar m2048@0x92628000 port
> 0x92628300 irq 42
> [    0.714523] ata6: DUMMY
> 
> ...
> 
> [    6.079327] ata1: link is slow to respond, please be patient (ready=0)
> [   10.714326] ata1: COMRESET failed (errno=-16)
> [   11.018951] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   11.020746] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
> LOCK) filtered out
> [   11.020897] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
> filtered out
> [   11.021272] ata1.00: ATA-7: INTEL SSDSA2M160G2GC, 2CV102HA, max UDMA/133
> [   11.021409] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [   11.021914] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
> LOCK) filtered out
> [   11.022061] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
> filtered out
> [   11.022434] ata1.00: configured for UDMA/133
> [   11.022671] scsi 0:0:0:0: Direct-Access     ATA      INTEL
> SSDSA2M160 2CV1 PQ: 0 ANSI: 5
> [   11.022958] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   11.023030] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks:
> (160 GB/149 GiB)
> [   11.023116] sd 0:0:0:0: [sda] Write Protect is off
> [   11.023144] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [   11.023338] sda: detected capacity change from 0 to 160041885696
> [   11.023560]  sda: sda1 sda2 sda3
> [   11.023897] sd 0:0:0:0: [sda] Attached SCSI disk
> [   11.327544] ata2: SATA link down (SStatus 0 SControl 300)
> [   11.632156] ata5: SATA link down (SStatus 0 SControl 300)

-- 
tejun
