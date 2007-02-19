From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: random/intermittent errors
Date: Mon, 19 Feb 2007 11:26:24 +0100 (MET)
Message-ID: <200702191026.l1JAQOUV018985@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:45165 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXBSK0f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Feb 2007 05:26:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, marcm@liquid-nexus.net

On Mon, 19 Feb 2007 12:43:50 +0800, Marc Marais wrote:
> I've decided to post this to the linux-ide list to see if I can get to the
> bottom of this problem I'm experiencing with sata_promise and my PATA drives.
> 
> I've pasted a thread from the linux-raid list where I was trying to
> troubleshoot/recover a destroyed raid5 array.
> 
> First a full history:
> 
> 1) 2.6.17.13: 3 drive PATA raid5 array with one drive starting to give read
> errors (legitimate according to SMART logs).
> 2) System lockups (no kernel panic seen) during load - I suspect due to the
> read error on the failing drive. 
> 3) Decide to upgrade to 2.6.20
> 4) Raid5 issues occur (handling of read errors caused md device to die). 
> 5) Patch from Neil to fix raid-5 error handling
> 6) Replace failed drive and add a new drive at the same time to create a 4
> drive PATA array.
> 7) Attempt to grow the array from 3 -> 4 devices which failed due to an error
> similar to this:
> 
> ata3: command timeout
> ata3: no sense translation for status: 0x40
> ata3: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata4: status=0x40 { DriveReady }
> sd 3:0:0:0: SCSI error: return code = 0x08000002
> sdd: Current [descriptor]: sense key: Aborted Command
>      Additional sense: No additional sense information
> Descriptor sense data with sense descriptors (in hex):
>          72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
>          00 00 00 00
> end_request: I/O error, dev sdc, sector 260419647
> 
> 8) Raid array is trashed, rebuild array and restore from backup.
> 9) From this point on the system is up and running - restored to working
> state. However, I'm still getting errors similar to the above during array
> accesses (read/write). Not related to load. The array (being synced) manages
> to continue operation using another drive. My concern is that this may happen
> on a degraded array in future.
> 
> Note that the error I'm getting (shown above) has happened on sdc and sdd and
> at different sectors (i.e. not a consistent read error). Also, the SMART logs
> for both drives show NO error at all, short and long SMART tests complete
> successfully. I suspect this is an issue in the driver and/or my physical
> TX4000 card.

In the 2.6.20 kernel, 20619/TX4000 is still using the same driver
code and (old) error handling code it's been using for ages,
i.e., any 20619/TX4000 issues are unrelated to the SATAII and
new EH changes that I've done. Therefore I strongly suspect
either an old driver bug, or some hardware issue.

>From your dmesg log it seems you have at least 7 disks and a DVD
drive on two different controllers, an unused AIC7XXX, and an e1000
NIC, on a mainboard with a pair of Athlon MPs and 2GB RAM. All that
screams "power consumption" and "heat generation". Please make
absolutely sure that the PSU and cooling solutions are up to the job.
It doesn't hurt to check the cables and that the card is properly
seated as well. I'm assuming each drive is jumpered as master and
is connected at the far end of its cable?

It would be very useful if you could move the drives around,
so the sdc/sdd drives that experienced errors are moved to the
ports now used by sda/sdb. That should tell us if the errors
are tied to the drives or the ports.

/Mikael
