From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 14:59:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org>
References: <456CB72A.3010004@local.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:51385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757802AbWK1W7j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 17:59:39 -0500
In-Reply-To: <456CB72A.3010004@local.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonas Lundgren <jonas@local.se>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org



On Tue, 28 Nov 2006, Jonas Lundgren wrote:
> 
> Example of what I mean with crappy performance:
> dd if=/dev/zero of=test232 bs=1M count=100; time sync
> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB) copied, 0.130424 s, 804 MB/s
> real 0m21.104s

Ok, that's definitely not the same thing I see.

I get

	real    0m2.673s

for the "time sync" part of your example, so the chipset can definitely do 
better than your 4-5 MB/s.

And your read performance seems fine. Strange.

I suspect it's related to your RAID usage. I've only got a single disk in 
my system. Maybe there is something problematic in sending commands to 
alternating SATA ports on the same controller with the i965 thing?

The "switching between SATA ports" thing migt actually be a clue, because 
while I've had this thing for a few weeks, I only used the DVD drive for 
the first time the day before yesterday, and didn't actually even have the 
SCSI CD-ROM support compiled in until then (copied a config from another 
machine that had the DVD-rom on the legacy side, so it used the more 
common IDE-CD thing).

So maybe these _are_ related somehow, and my problem showed up because I 
actually had concurrent access to my DVD drive (some KDE media daemon 
checking to see if I inserted a music CD or something?). Jeff, Tejun, is 
there any reason to believe that the two channels on a PIIX ata controller 
are somehow "tied together" and it could be problematic for concurrent 
accesses?

Jonas definitely has the same error messages:

> Dmesg output from the error(s): (sda and sdb are 2 * 74GB raptor SATA
> drives in a Linux software raid0)
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x20)
> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)
> ata1: soft resetting port
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07

That all looks exactly like mine did.

Except:

> ata1: EH complete
> SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back

Jonas' disks came back.

So while Jonas' behaviour/problems otherwise don't seem to match mine at 
all, there might be some underlying commonality..

			Linus
