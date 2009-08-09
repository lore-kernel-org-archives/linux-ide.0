From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: SATA errors
Date: Sun, 9 Aug 2009 23:35:11 +0200
Message-ID: <19071.16655.872041.242178@pilspetsen.it.uu.se>
References: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
	<19071.10817.664277.813057@pilspetsen.it.uu.se>
	<1249852290.17536.10.camel@meteotsunami.darksilence.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:53697 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbZHIVfO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2009 17:35:14 -0400
Received: from pilspetsen.it.uu.se (daemon@pilspetsen.it.uu.se [130.238.18.39])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id n79LZCdK007909
	for <linux-ide@vger.kernel.org>; Sun, 9 Aug 2009 23:35:12 +0200 (MEST)
In-Reply-To: <1249852290.17536.10.camel@meteotsunami.darksilence.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Miah Gregory writes:
 > On Sun, 2009-08-09 at 21:57 +0200, Mikael Pettersson wrote:
 > > Miah Gregory writes:
 > 
 > >  > One of my servers has started to log slightly odd errors following one
 > >  > of the software RAID arrays having been degraded due to an error on sdb.
 > > ...
 > 
 > > 1. Did these problems start spontaneously, or did they follow some
 > >    system change like installing more disks or booting a newer kernel?
 > 
 > Spontaneously; the machine has been running the current kernel since the
 > end of January, with some brief excursions to newer kernels which were
 > reverted due to the XFS/NFS interaction problems which haven't yet been
 > pinned down. No hardware changes etc. Current uptime just over 61 days.

That is a strong indication that the core problem is hardware.

The kernel problem would be inadequate error recovery causing a
disk to be offlined after what should have been a recoverable event.

 > > 2. If there's reason to suspect a kernel issue, the disk-to-controller
 > >    mapping in this machine will tell us which driver may be at fault.
 > >    Please post a complete kernel boot log from e.g. `dmesg'.
 > 
 > That will need a reboot, as the logs from the previous boot are long
 > since rotated; will organise this as time permits.
 > 
 > > 3. If the disks are attached to the Promise controller, please try this patch:
 > >    <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.28/patch-sata_promise-reset-updates-v1-2.6.28>
 > >    It improved error recovery in a case where smart commands to a sleeping
 > >    disk of a particular model timed out.
 > 
 > Could you clarify sleeping in this context? None of the disks are being
 > spun down, if that is what is meant?

The important thing here is the "It improved error recovery" part, the
rest just described that other case where error recovery needed improving.
(A specific disk was spun down by hdparm -Y, then subjected to smart commands.
It did not like that, triggering timeouts and other errors.)
