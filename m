From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 16387] New: system freezes when dvd starts to
 spin for playback
Date: Wed, 21 Jul 2010 14:00:13 -0700
Message-ID: <20100721140013.98ba4f48.akpm@linux-foundation.org>
References: <bug-16387-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44027 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754961Ab0GUVCp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jul 2010 17:02:45 -0400
In-Reply-To: <bug-16387-10286@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, mehmet@giritli.eu


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 14 Jul 2010 12:18:31 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=16387
> 
>            Summary: system freezes when dvd starts to spin for playback
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 2.6.35-rc5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: io_other@kernel-bugs.osdl.org
>         ReportedBy: mehmet@giritli.eu
>         Regression: No

It's either a post-2.6.33 or a post-2.6.34 regression.

> 
> In 2.6.35 rcs, I get frequent freezes of my computer when I put a DVD (its a DL
> DVD-Video, if matters) in for playback. I do not know how to get any data out
> of the computer in this situation, nothing works (not even the caps lock). So I
> turn it off and restart to use it again.
> 
> 2.6.33 kernels do not have this problem and I have not tried .34 yet as those
> kernels have a nasty acpi bug on my computer
> (https://bugzilla.kernel.org/show_bug.cgi?id=16040).

It would be helpful to test 2.6.34.  There are fixes referenced in that
report but they aren't present in 2.6.34.1.  I suspect a screwup and
will ping Len about that.

> Could someone instruct me how to debug this please?

>From your dmesg:

ata6: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: Hitachi HTS543232L9SA00, FB4OC43C, max UDMA/133
ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54323 FB4O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:
ata5.00: ATAPI: TSSTcorp CDDVDW TS-L633A, TO03, max UDMA/100
ata5.00: configured for UDMA/100
 sda1 sda2 sda3 sda4 <
scsi 4:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633A  TO03 PQ: 0 ANSI: 5

so we can perhaps start by asking the ata developers to take a look,
please.

