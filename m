From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11789] New: [sata_sil] failed to IDENTIFY (I/O
 error, err_mask=0x3)
Date: Tue, 21 Oct 2008 11:56:33 -0700
Message-ID: <20081021115633.627e1aca.akpm@linux-foundation.org>
References: <bug-11789-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47952 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751074AbYJUS5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Oct 2008 14:57:05 -0400
In-Reply-To: <bug-11789-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, skgsergio@gmail.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 19 Oct 2008 11:40:12 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11789
> 
>            Summary: [sata_sil] failed to IDENTIFY (I/O error, err_mask=0x3)
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.27.x
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: skgsergio@gmail.com
> 
> 
> Latest working kernel version: Any without sata_sil support
> 
> Earliest failing kernel version: 2.6.27 to 2.6.27.2 (Vanilla)
> 
> Distribution: ArchLinux, Gentoo
> 
> Hardware Environment: Acer Aspire 5051AWXMi
> 
> Software Environment: ArchLinux
> 
> Problem Description:
> At boot I have this problem and it slows the boot proces (dmesg):
> 
> SCSI subsystem initialized
> libata version 3.00 loaded.
> pata_acpi 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> pata_acpi 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> pata_acpi 0000:00:14.1: setting latency timer to 64
> scsi0 : pata_atiixp
> scsi1 : pata_atiixp
> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x8420 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x8428 irq 15
> input: AT Translated Set 2 keyboard as /class/input/input1
> ata1.00: ATA-7: WDC WD1200UE-22KVT0, 01.03K01, max UDMA/100
> ata1.00: 234441648 sectors, multi 16: LBA48
> ata1.01: ATAPI: MATSHITADVD-RAM UJ-850S, 1.20, max UDMA/33
> ata1.00: configured for UDMA/100
> ata1.01: configured for UDMA/33
> Switched to high resolution mode on CPU 0
> isa bounce pool size: 16 pages
> scsi 0:0:0:0: Direct-Access ATA WDC WD1200UE-22K 01.0 PQ: 0 ANSI: 5
> scsi 0:0:1:0: CD-ROM MATSHITA DVD-RAM UJ-850S 1.20 PQ: 0 ANSI: 5
> sata_sil 0000:00:12.0: version 2.3
> scsi2 : sata_sil
> scsi3 : sata_sil
> ata3: SATA max UDMA/100 mmio m512@0xc0004000 tf 0xc0004080 irq 22
> ata4: SATA max UDMA/100 mmio m512@0xc0004000 tf 0xc00040c0 irq 22
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x3)
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x3)
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x3)
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> 
> Steps to reproduce:
> 1) Use sata_sil
> 

