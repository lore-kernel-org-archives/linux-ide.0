From: Marc MERLIN <marc@merlins.org>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330
Date: Tue, 2 Oct 2007 23:38:40 -0700
Message-ID: <20071003063840.GC2533@merlins.org>
References: <20071002170445.GB2902@merlins.org> <47030CC0.8040601@gmail.com> <20071003055936.GB2533@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:56708 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXJCGir (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 02:38:47 -0400
Content-Disposition: inline
In-Reply-To: <20071003055936.GB2533@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Oct 02, 2007 at 10:59:36PM -0700, Marc MERLIN wrote:
> On Wed, Oct 03, 2007 at 12:30:08PM +0900, Tejun Heo wrote:
> > 1. Does booting with fewer number of drives (say 5) help?
>  
> Boot is ok with 10 drives now with your latest code (20070808 instead
> of 20070803)

Let me correct this.

Actually 20070803 vs 20070808 doesn't seem to make a difference at boot.
Sometimes the boot is clean, sometimes it's not.

I removed the 5 good drives, moved the 5 "bad" TB ones to the good slots
(i.e. using another swappable backplane, other cables, and another PMP chip
(I have two chips: one in port 1 and 2 of my sil3124).
Unfortunately, moving the drives to all these new things yielded the same 
unreliable boot detection so far.

I reseated the drives one more time just to be sure. This time they booted
ok, but I'm pretty sure it's just the random works/doesn't work thing.
I'll rebuild the array overnight and let you know in 8-9h if the array
rebuilt and if it can take a mke2fs without blowing up.

In the meantime, if you have any suggestions for slowing the drive's speed
down to 1.5Gbps, or other ways to debug those random erros I'm seeing, I'm
all ears.

Here is a link to the drive specs if that helps:
http://www.hitachigst.com/portal/site/en/menuitem.8027a91c954924ae4bda9f30eac4f0a0/

Thanks
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
