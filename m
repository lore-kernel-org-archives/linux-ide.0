From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Thu, 03 May 2007 16:44:10 +0200
Message-ID: <4639F53A.6000902@gmail.com>
References: <343456.16264.qm@web52604.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:23388 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162050AbXECOoW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 10:44:22 -0400
Received: by nz-out-0506.google.com with SMTP id o1so529332nzf
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 07:44:22 -0700 (PDT)
In-Reply-To: <343456.16264.qm@web52604.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

Srihari Vijayaraghavan wrote:
> Hardware:
> ASUS M2A-VM (with the latest BIOS - 0402)
> AMD AM2
> Seagate IDE hard drive & LG IDE DVDRW
> 
> All works rather very nicely expect for the SATA :-).
> 
> No luck detecting the 2 Seagate ST3250620NS SATA-II
> drives (Kernel.org's 2.6.21):
> Linux version 2.6.21 (hari@fedora7) (gcc version 4.1.2
> 20070424 (Red Hat 4.1.2-1
> 1)) #3 SMP Mon Apr 30 18:49:04 EST 2007
> Command line: ro root=LABEL=/1234 rhgb quiet
> ...
> ahci 0000:00:12.0: version 2.1
> ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level,
> low) -> IRQ 22
> PM: Adding info for No Bus:timer
> sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw
> xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 0:0:1:0: Attached scsi CD-ROM sr0
> PM: Adding info for No Bus:seq
> PM: Adding info for No Bus:sequencer
> PM: Adding info for No Bus:sequencer2
> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3
> Gbps 0xf impl SATA mode
> ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo
> pmp pio slum part 
> ata3: SATA max UDMA/133 cmd 0xffffc2000006a100 ctl
> 0x0000000000000000 bmdma 0x00
> 00000000000000 irq 22
> ata4: SATA max UDMA/133 cmd 0xffffc2000006a180 ctl
> 0x0000000000000000 bmdma 0x00
> 00000000000000 irq 22
> ata5: SATA max UDMA/133 cmd 0xffffc2000006a200 ctl
> 0x0000000000000000 bmdma 0x00
> 00000000000000 irq 22
> ata6: SATA max UDMA/133 cmd 0xffffc2000006a280 ctl
> 0x0000000000000000 bmdma 0x00
> 00000000000000 irq 22
> scsi2 : ahci
> PM: Adding info for No Bus:host2
> ata3: softreset failed (1st FIS failed)
> ata3: softreset failed, retrying in 5 secs
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata3.00: limiting speed to UDMA7:PIO5
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> scsi3 : ahci
> PM: Adding info for No Bus:host3
> ata4: softreset failed (1st FIS failed)
> ata4: softreset failed, retrying in 5 secs
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: qc timeout (cmd 0xec)
> ata4.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: qc timeout (cmd 0xec)
> ata4.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata4.00: limiting speed to UDMA7:PIO5
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 
> (curiously irq 22 is exclusive to libata & irq count
> is at 0)

Can you post dmesg with kernel parameter 'pci=nomsi' set?

-- 
tejun
