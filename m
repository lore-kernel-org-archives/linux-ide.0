From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10860] New: total system freeze at boot with
 2.6.26-rc
Date: Thu, 5 Jun 2008 12:49:45 -0700
Message-ID: <20080605124945.3a9ff0c2.akpm@linux-foundation.org>
References: <bug-10860-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37104 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542AbYFETuH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jun 2008 15:50:07 -0400
In-Reply-To: <bug-10860-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, casteyde.christian@free.fr


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu,  5 Jun 2008 12:38:02 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10860
> 
>            Summary: total system freeze at boot with 2.6.26-rc
>            Product: Other
>            Version: 2.5
>      KernelVersion: 2.6.26-rc4
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: Other
>         AssignedTo: other_other@kernel-bugs.osdl.org
>         ReportedBy: casteyde.christian@free.fr
> 
> 
> Latest working kernel version:2.6.25.4
> Earliest failing kernel version:2.6.24-rc4

(should have been 2.6.26-rc4)

> also fails with -rc5 I was wating for, previous rcs not tested
> Distribution: Bluewhite64 (64 bits slackware)
> Hardware Environment: Athlon64 X2 / Ali 1689 north 1563 south
> + bt848 v4l + PATA and SATA disk (SATA on sata_uli)
> Seems to be related to sata disk detection (see below).
> 
> Software Environment:
> none
> 
> Problem Description:
> the computer freeze totally at boot after SATA disk detection.
> I append 2.6.25.4 dmesg, lspci and lsusb.
> The CPU is not 100% (otherwise I could hear the fan going crazy), the keayboard
> is dead (unable to scroll the console up or down). Nothings happen.
> 
> The console shows somethings similar to the 2.6.25.4 logs, but hangs after
> those lines:
> hda: cache flushes not supported
>  hda: hda1 hda2
> hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> Uniform CD-ROM driver Revision: 3.20
> Driver 'sd' needs updating - please use bus_type methods
> sata_uli 0000:00:0e.1: version 1.3
> ACPI: PCI Interrupt 0000:00:0e.1[A] -> GSI 19 (level, low) -> IRQ 19
> scsi0 : sata_uli
> scsi1 : sata_uli
> ata1: SATA max UDMA/133 cmd 0xf80 ctl 0xf00 bmdma 0xd880 irq 19
> ata2: SATA max UDMA/133 cmd 0xe80 ctl 0xe00 bmdma 0xd888 irq 19
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 
> <-- here, 2.6.24 hangs -->
> 
> normal way for 2.6.25 :
> 
> ata1.00: ATA-7: ST3200826AS, 3.06, max UDMA/133
> ata1.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 0/32)
> ata1.00: configured for UDMA/133
> ata2: SATA link down (SStatus 0 SControl 300)
> scsi 0:0:0:0: Direct-Access     ATA      ST3200826AS      3.06 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> 
> Steps to reproduce:
> Boot my PC :-)
> I guess any sata_uli device may hang the same way?

yup, I'd say that the ata code (or something very nearby) killed your
box.

This is a post-2.6.25 regression.

