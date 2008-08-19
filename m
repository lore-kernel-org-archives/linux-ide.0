From: "Grant Grundler" <grundler@google.com>
Subject: Re: Flush drive cache before issuing ATA_16 from userspace?
Date: Tue, 19 Aug 2008 09:38:49 -0700
Message-ID: <da824cf30808190938j684db484xcefea16e0f64d1ed@mail.gmail.com>
References: <48AACDA1.7070206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:54092 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYHSQjU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 12:39:20 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id m7JGcqV0004255
	for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 17:38:52 +0100
Received: from ug-out-1314.google.com (ugct30.prod.google.com [10.66.121.30])
	by zps78.corp.google.com with ESMTP id m7JGco7B028821
	for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 09:38:51 -0700
Received: by ug-out-1314.google.com with SMTP id t30so666659ugc.22
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 09:38:49 -0700 (PDT)
In-Reply-To: <48AACDA1.7070206@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Aug 19, 2008 at 6:41 AM, Mark Lord <liml@rtr.ca> wrote:
> I have a rather busy MythTV system here, with four tuners
> and a hirez HDTV for the display.
>
> It uses a pair of 750GB Hitachi SATA drives (RAID0) for storage.
>
> I wanted to see how warm the drives get, so I set up a monitoring
> program that invokes hddtemp every 20-30 seconds or so, updating
> a front panel display with the current drive temperature of /dev/sdb.
>
> So far, so good.
>
> But.. when the machine is busy recording a hi-def (17mbit/sec) stream
> whilst also playing back a hi-def stream, libata locks up and resets
> /dev/sdb periodically, say once every minute or so (quite irregular).
> This causes lots of recording bits to be dropped, ruining later playback.
>
> The dual-core system was using 2.6.24.3 (32-bit) at the time,
> and libata.ahci w/NCQ on both drives.
> I retested with "hdparm -Q1 /dev/sd?" and it didn't help -- same problem.
>
> Looking at the system logs, and running a full S.M.A.R.T. test shows
> both drives to be clean (no media faults found), other than libata
> reporting timeouts as here:
>
> ..
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 pio 512 in
>        res 40/00:00:00:4f:c2/00:01:00:00:00/00 Emask 0x4 (timeout)
> ata2.00: status: { DRDY }
> ata2: soft resetting link
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> ..
>
> That's an IDENTIFY (0xEC) command timing out.
> The hddtemp program does it's work by issuing IDENTIFY and SMART
> commands to the target drive, /dev/sdb in this case.
>
>        ioctl(3, 0x30d, 0xbfd2c418)
>        ioctl(3, 0x31f, 0xbfd2c60c)
>        ioctl(3, 0x31f, 0xbfd2c614)
>        ioctl(3, 0x31f, 0xbfd2c408)
>
> So that 0xEC most likely came from the hddtemp program,
> since libata doesn't normally issue them after probing.
>
> So why is it timing out?  Well, these drives have 32MB onboard caches,
> and I'm guessing that something (firmware, whatever) tries to empty that
> cache before processing the issued IDENTIFY command.  And we time out
> before the drive has a chance to actually process the IDENTIFY.

This sounds like a drive firmware bug. I can't think of any reason for IDENTIFY
to cause a cache flush. Not unless the IDENTIFY return values can be
influenced by pending writes - ie some of the IDENTIFY data is coming
from media.

We have seen some drives take up to 350ms to process a SMART data
request (Vendor fixed this in later firmware). Even the "better" drives
(different vendor) can take up to 100ms for SMART data to be returned.
(Sorry, I can't name vendors - they know who they are and can speak
for themselves.)

> This is a problem for libata, one that will become more common as drives
> get larger and larger caches.  Fiddling with timeouts isn't really the
> greatest solution, though it could help.
>
> A more deterministic solution might be to issue a CACHE FLUSH command
> ahead of any ATA_16 command (perhaps other than a R/W command?),
> so that the timeout for the ATA_16 (IDENTIFY in this case) won't have
> to account for an unpredictable write cache on the drive.

I'm getting more worried that faster drives (more throughput and _average_
latency is well below 15ms) will have extremely high latency in the worst
cases despite having no HW errors.

This IDENTIFY case is the third case I'm aware of.

> Or maybe there's a better way.  Suggestions ??

Maybe get a SATA trace to confirm it's the drive's fault.
But otherwise no better ideas besides complaining to
the vendor and asking them to fix the problem.

hth,
grant

>
> Meanwhile, I'm installing 2.6.26.2 on the box later today,
> but don't really expect anything to be different with the newer kernel.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
