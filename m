From: Ryan <rgb005@latech.edu>
Subject: (unknown)
Date: Sun, 18 Apr 2004 18:24:45 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1082330685.40830e3da9c73@webmail.LaTech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from selene.LaTech.edu ([138.47.18.25]:44487 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S264211AbUDRXYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Apr 2004 19:24:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by LaTech.edu (Postfix) with ESMTP id 5114330A060
	for <linux-ide@vger.kernel.org>; Sun, 18 Apr 2004 18:24:46 -0500 (CDT)
Received: from LaTech.edu ([127.0.0.1])
 by localhost (selene.latech.edu [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 83671-01-17 for <linux-ide@vger.kernel.org>;
 Sun, 18 Apr 2004 18:24:45 -0500 (CDT)
Received: from localhost (helius.LaTech.edu [138.47.18.18])
	by LaTech.edu (Postfix) with ESMTP id B60B1309FB5
	for <linux-ide@vger.kernel.org>; Sun, 18 Apr 2004 18:24:45 -0500 (CDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


> >
> >Promise's S150 SX4 SATA controller supports hotswap and automatic array
> >rebuilds.  
> >
> Really?  How long has it done that?  The last libata status report I saw
> from Jeff Garzik said hotswap was still unsupported.  Has that changed?  
> Do you know if any other interface card's driver supports it yet?  It
> supports that standard SCSI hot-plug utilities or what?
>

I said the CARD supports it, not the drivers.  Perhaps I was a bit unclear on
that.  Currently the SX4 is supported through the sata_promise driver.  It has
NO support for any controller-level RAID or drive hotswapping.  Jeff Garzik, I
think, is working on the SX4 driver.  As far as I know, with the SX4, RAID
rebuilding and hotswapping within an array should be handled at the hardware
level by the card (at least for RAID5 arrays), but I really don't know that
much about how it all fits together.  I could very well be wrong.


> >The problem with it is that at the moment there is no driver support
> >for the SX4's RAID functionality.  So in the meantime I'm using Linux's
> >software RAID5 on the card.  It's really quite slow (25mb/s) but that's
> mostly
> >due to the current driver support, from what I've been told.
> >  
> >
> I run RAID1, I trade space for performance and simplicity.  I run
> latency sensitive stuff, so RAID1's read performance is what I need.  It
> lowered average latency 40% and increased seeks/sec by 80% as compared
> to a single disk setup.  Plus it'll do parallel sequential reads at
> 100MB/s, if I had sequential access patterns.  It doesn't appear to have
> any noticeable affect on CPU usage either.

>From what Jeff said, drive access is slowed considerably on the SX4 due to how
the current driver accesses the disk.  And I quote:

"SX4 is vastly different.  Each request must bounce through a DIMM, which
hurts performance.  Further, only one DIMM copy to/from system memory
can be occuring at any one time, while you can be executing up to 4 ATA
commands (one for each SATA port) in parallel."  --Jeff Garzik

So no matter what RAID array I use, I'm greatly limited by the current driver
design.  Like I said, 25mb/s on a single drive, and I'm geting about 29mb/s for
the whole array.  I'd expect around an 80mb/s read on the array with the
"ideal" drivers.  And some more from Jeff:

"SX4 is really designed for RAID acceleration.  One may to improve
performance (which I plan to implement) is using the DIMM as a
write-through cache."

Drive performance can really be split up into a couple of different areas:
Disk-level, controller-level, and driver-level.  Some disks are inherently
faster than others.  Some controllers are better than others at certain things
(the SX4 is SUPPOSED to be a RAID card, not a simple controller card) and then,
drivers can either suck or not.  I guess you could say RAID is either
controller-level, driver-level, or both.

Personally, I have to commend the guys working on the Promise SATA driver(s), I
think they've done a great job getting this all together.  I'm looking forward
to seeing an SX4 driver that supports all of the wonderful things the card can
do.

>
> -ryan
>


-- 
huh?

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

