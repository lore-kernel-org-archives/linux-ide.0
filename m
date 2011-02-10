From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 20:19:19 +0100
Message-ID: <20110210191919.GN3770@htj.dyndns.org>
References: <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
 <4D52ECB6.4010408@cfl.rr.com>
 <20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
 <4D5306F8.6050106@cfl.rr.com>
 <20110209213904.4aff945d@lxorguk.ukuu.org.uk>
 <4D532FFC.2020503@cfl.rr.com>
 <20110210124644.0cec1287@lxorguk.ukuu.org.uk>
 <4D543572.4010807@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49563 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab1BJTTX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:19:23 -0500
Received: by bwz15 with SMTP id 15so2440461bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 11:19:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D543572.4010807@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Feb 10, 2011 at 01:58:58PM -0500, Phillip Susi wrote:
> > It's unfortunate you won't listen but continue to spout stuff from a
> > standard no vendor, no OS and no product ever followed. ATA is not built
> > on strict adherance to formal standards, nor is the PC.
> 
> Microsoft's OS follows it.

Try to do anything slightly advanced with BIOS RAIDs.  It works only
when you stay inside the pretty confined use case dictated by the
hardware/driver vendor and what's supported varies widely depending on
which BIOS RAID you're using.  Really, think about how they would
handle hot swap.

> Even if dmraid works around it, you are still left with:
> 
> 1)  Possibly trashing data the bios put on the hd and told you not to touch

Unlocking doesn't equal thrashing and if root wants to ignore BIOS
suggestions, root shall be able to.

More importantly, BIOSen having control over some part of disk never
works reliably.  It might have worked ten years ago when hardware
configuration never changed without intervening system resets and
POSTs.  These days, it's just not possible.  Hardware comes and goes
while the system is running and there's no way for BIOS to do anything
about it.

The only valid use case would be stuff like recovery partitions on
laptops and instant boot thingies on some motherboards.  Installation
tools seemed to deal with them well enough.

> 2)  Rebooting after running Linux leaves the drive unlocked, which
> causes the fakeraid bios to complain that your raid is broken.  People
> don't like that.

That's something BIOS writers should deal with.  Report it to them.
Distros can be nice and lock it again during shutdown sequence from
userland too but I don't think it's something which should dictate the
decisions.

Thanks.

-- 
tejun
