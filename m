From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Problem with disk
Date: Sat, 6 May 2006 13:11:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0605061304560.5626-100000@coffee.psychology.mcmaster.ca>
References: <445BF302.4050709@emc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:28295 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1750991AbWEFRM4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 13:12:56 -0400
In-Reply-To: <445BF302.4050709@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: David.Ronis@McGill.CA, linux-ide@vger.kernel.org

> >this is true, but extremely conservative/paranoid.  it makes a lot 
> >of sense if you're handling banking transactions or if you really
> >see a lot of abrupt power-offs (yank the battery).  what are the chances
> >of a drive failing to write dirty blocks when idle, halting?
> >
> The write cache in modern drives is multiple megabytes - 8 or 16MB is 
> not uncommon. The chances that you have data that is lost on a power 
> failure in the write cache is actually quite high...

but we're not talking about power failures in the middle of peak activity.
afaikt, drives also never dedicate their whole cache to writeback - they 
keep plenty available for reads, as well.  it would also be rather surprising
if the firmware was completely oblivious about limiting the age of
writebacks; after all always delaying writes until you run out of cache 
capacity is _not_ a winning strategy (even ignoring safety issues.)

during a normal shutdown, can you think of some reason the drive would have 
LOTS of outstanding writes?  that's the real point.  depending on kernel
version, linux should be doing a cache-flush command and standby, then
eventually calling bios poweroff.  it's very possible that this is going 
wrong (rumors of disks that claim to implement, but ignore cache-flush,
or perhaps ones that stupidly don't flush on standby, or even bios poweroff
that happens so fast that the disks isn't done flushing...)  but turning 
off all writeback is overkill (especially when there's some other obvious 
sign of distress...)

