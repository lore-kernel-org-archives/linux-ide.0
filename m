From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10738] New: sata_via hang and data corruption
Date: Sat, 17 May 2008 21:59:33 -0700
Message-ID: <20080517215933.c3ff7a10.akpm@linux-foundation.org>
References: <bug-10738-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32905 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124AbYERFAI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 01:00:08 -0400
In-Reply-To: <bug-10738-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, rootkit85@yahoo.it


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat, 17 May 2008 19:11:48 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10738
> 
>            Summary: sata_via hang and data corruption
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.25
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: rootkit85@yahoo.it
> 
> 
> Latest working kernel version: 2.6.22 (?)
> Earliest failing kernel version: 2.6.23 (?)

So it's a regression?

> Distribution: Ubuntu
> Hardware Environment: VIA motherboard (ASROCK P4V88), Maxtor SATA HD
> Software Environment: Linux 2.6.25 i386
> Problem Description: After a few minutes of usage the kernel hangs while sayng:
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd 25/00:08:85:75:25/00:00:25:00:00/e0 tag 0 dma 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for UDMA/133
> ata1: EH complete
> sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd 25/00:20:6d:ae:1d/00:00:24:00:00/e0 tag 0 dma 16384 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for UDMA/133
> ata1: EH complete
> sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> 
> Steps to reproduce: poweron and use the disk
> 
> Any hint on what can it be? I can't remember the last working kernel, will try
> some old one soon
> 

I often have trouble working out which device driver is being used when
a bug report comes past.  This is one such case.

