From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.20-mm2
Date: Tue, 20 Feb 2007 02:20:21 +0100
Message-ID: <200702200220.22721.rjw@sisk.pl>
References: <20070217215146.30e7ffa3.akpm@linux-foundation.org> <200702181344.54959.rjw@sisk.pl> <20070218114326.35d7645b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56334 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932770AbXBTB0G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Feb 2007 20:26:06 -0500
In-Reply-To: <20070218114326.35d7645b.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Sunday, 18 February 2007 20:43, Andrew Morton wrote:
> On Sun, 18 Feb 2007 13:44:54 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Sunday, 18 February 2007 06:51, Andrew Morton wrote:
> > > 
> > > Temporarily at
> > > 
> > >   http://userweb.kernel.org/~akpm/2.6.20-mm2/
> > > 
> > > Will appear later at
> > > 
> > >  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20/2.6.20-mm2/
> > 
> > Two problems:
> > 
> > 1) A showstopper with the root partition on RAID1:
> > 
> > md: raid1 personality registered for level 1
> > [--snip--]
> > md: multipath personality registered for level -4
> > register_blkdev: failed to get major for mdp
> > [--snip--]
> > VFS: Cannot open root device "md1" or unknown-block(0,0)
> 
> Someone else reported that against mainline.  Can you please debug it a bit?

For now I can only say 2.6.20 + origin.patch breaks.

However, it's a SUSE 10.1 system with gcc 4.1.0 and this may be the reason.
I'll check that tomorrow.
