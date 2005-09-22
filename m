From: Pavel Machek <pavel@suse.cz>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Thu, 22 Sep 2005 12:36:06 +0200
Message-ID: <20050922103605.GA1527@openzaurus.ucw.cz>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31166 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751311AbVIXJ5v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Sep 2005 05:57:51 -0400
Content-Disposition: inline
In-Reply-To: <433221A1.5000600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joshua Kwan <joshk@triplehelix.org>, axboe@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi!

> >Is Jens' patch still relevant? If so, should it be rediffed and 
> >merged
> >into mainline? It doesn't seem to cause any weird side-effects.
> >
> >More importantly, I would be inclined to properly rediff Jens' patch 
> >and
> >merge it into Debian 2.6.12 kernel sources if there aren't any such
> >side-effects, since it benefits everyone using SATA and 
> >suspend-to-ram
> >(that is, users of relatively modern laptops.)
> 
> Jens' patch is technical correct for SATA, but really we want to do 
> more stuff at the SCSI layer (see James Bottomley's response to Jens' 
> patch).
> 
> Unfortunately, this also implies that we have to figure out which 
> SCSI devices are available to be power-managed, and which SCSI 
> devices are on a shared bus that should never be suspended.

I think that shared buses are rare enough to be safely ignored.
We could simply say "never ever suspend machine with some
disks on shared bus".

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

