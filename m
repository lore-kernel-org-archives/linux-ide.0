From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Thu, 22 Sep 2005 08:01:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509220759180.20059@shark.he.net>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
 <20050922061849.GJ7929@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:34954 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030392AbVIVPBZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2005 11:01:25 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 08:01:23 -0700
In-Reply-To: <20050922061849.GJ7929@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Thu, 22 Sep 2005, Jens Axboe wrote:

> On Wed, Sep 21 2005, Jeff Garzik wrote:
> > Joshua Kwan wrote:
> > >Is Jens' patch still relevant? If so, should it be rediffed and merged
> > >into mainline? It doesn't seem to cause any weird side-effects.
> > >
> > >More importantly, I would be inclined to properly rediff Jens' patch and
> > >merge it into Debian 2.6.12 kernel sources if there aren't any such
> > >side-effects, since it benefits everyone using SATA and suspend-to-ram
> > >(that is, users of relatively modern laptops.)
> >
> > Jens' patch is technical correct for SATA, but really we want to do more
> > stuff at the SCSI layer (see James Bottomley's response to Jens' patch).
> >
> > Unfortunately, this also implies that we have to figure out which SCSI
> > devices are available to be power-managed, and which SCSI devices are on
> > a shared bus that should never be suspended.
> >
> > So currently we are in limbo...
>
> Which is a shame, since it means that software suspend on sata is
> basically impossible :)

so just go with Jens's patch for SATA until SCSI knows more
about power management??

-- 
~Randy
