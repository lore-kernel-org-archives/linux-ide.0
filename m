From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12351] New: sata_nv hotplug not work in
 2.6.27.10
Date: Mon, 5 Jan 2009 15:36:44 -0800
Message-ID: <20090105153644.8a0eea74.akpm@linux-foundation.org>
References: <bug-12351-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33586 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbZAEXh0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 18:37:26 -0500
In-Reply-To: <bug-12351-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, stable@kernel.org, gpanco@tiscali.it


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat,  3 Jan 2009 13:12:09 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12351
> 
>            Summary: sata_nv hotplug not work in 2.6.27.10
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.27.10
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: gpanco@tiscali.it
> 
> 
> Latest working kernel version:2.6.27
> Earliest failing kernel version:2.6.27.10

A regression in -stable.

> Hardware Environment:x86 ASUS M2N-E
> Problem Description: sata_nv hotplug dont work in 2.6.27.10
> 
> Steps to reproduce:
> 
> when I hotplug my sata disk dmesg say:
> 
> - kernel 2.6.27:
> 
> ta2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xe frozen
> ata2: SError: { PHYRdyChg CommWake }
> ata2: hard resetting link
> ata2: link is slow to respond, please be patient (ready=-19)
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
> ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> scsi 1:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
> sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
>  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 sdb13 sdb14 sdb15
> >
> sd 1:0:0:0: [sdb] Attached SCSI disk
> 
> 
> - kernel 2.6.27.10:
> 
> ata2: exception Emask 0x10 SAct 0x0 SErr 0x150000 action 0xe frozen
> ata2: SError: { PHYRdyChg CommWake Dispar }
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: device not ready (errno=-16), forcing hardreset
> ata2: soft resetting link
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: SRST failed (errno=-16)
> ata2: soft resetting link
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: SRST failed (errno=-16)
> ata2: soft resetting link
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: SRST failed (errno=-16)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2: soft resetting link
> ata2: SRST failed (errno=-16)
> ata2: reset failed, giving up
> ata2: EH complete
> 

