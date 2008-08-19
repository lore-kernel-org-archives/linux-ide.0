From: Mark Lord <liml@rtr.ca>
Subject: Re: Flush drive cache before issuing ATA_16 from userspace?
Date: Tue, 19 Aug 2008 18:05:29 -0400
Message-ID: <48AB43A9.3000003@rtr.ca>
References: <48AACDA1.7070206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41250 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYHSWFc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Aug 2008 18:05:32 -0400
In-Reply-To: <48AACDA1.7070206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
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
>         res 40/00:00:00:4f:c2/00:01:00:00:00/00 Emask 0x4 (timeout)
> ata2.00: status: { DRDY }
> ata2: soft resetting link
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> ..
> 
> That's an IDENTIFY (0xEC) command timing out.
> The hddtemp program does it's work by issuing IDENTIFY and SMART
> commands to the target drive, /dev/sdb in this case.
> 
>     ioctl(3, 0x30d, 0xbfd2c418)
>     ioctl(3, 0x31f, 0xbfd2c60c)
>     ioctl(3, 0x31f, 0xbfd2c614)
>     ioctl(3, 0x31f, 0xbfd2c408)
> 
> So that 0xEC most likely came from the hddtemp program,
> since libata doesn't normally issue them after probing.
> 
> So why is it timing out?  Well, these drives have 32MB onboard caches,
> and I'm guessing that something (firmware, whatever) tries to empty that
> cache before processing the issued IDENTIFY command.  And we time out
> before the drive has a chance to actually process the IDENTIFY.
..

Another possibility could be some kind of bug in libata or ahci.c.
It seems unlikely -- .qc_defer ought to prevent issues -- but I haven't
really poked around in there.  And this is a "production" machine :)
so we don't like to use it (much) for debugging kernels if we can help it.

Cheers
