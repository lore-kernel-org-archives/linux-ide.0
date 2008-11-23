From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Sun, 23 Nov 2008 13:39:44 +0000
Message-ID: <1227447584.4901.405.camel@macbook.infradead.org>
References: <4928E010.4090801@kernel.org> <4929023C.2060302@suse.de>
	 <20081123123514.GI5707@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:38549 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873AbYKWNjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 08:39:52 -0500
In-Reply-To: <20081123123514.GI5707@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <teheo@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Dongjun Shin <djshin90@gmail.com>, chris.mason@oracle.com

On Sun, 2008-11-23 at 05:35 -0700, Matthew Wilcox wrote:
> The current VFAT filesystem implements DISCARD. 

As does btrfs. I think I posted ext2 patches a little while ago too? Or
someone else did. Did they get merged?

>  Here's the patch I've
> been testing -- it's not right; it causes SSDs from two different vendors
> to hang.  I'm waiting for a free slot on the SATA protocol analyser to
> figure out what's we're doing wrong.
> 
> Note that the SCSI UNMAP command does not yet have an official number,
> so this patch cannot yet be applied (... how much longer until ATA is no
> longer part of SCSI?)
> 
> We don't attempt to put non-contiguous ranges into a single TRIM yet.

We don't even merge contiguous ranges -- I still need to fix the
elevators to stop writes crossing writes, before we can stop discards
from also being barriers. (Discards are just writes, for the purpose of
that conversation).

> We currently assume all SCSI devices support UNMAP instead of checking
> the feature flag (because last time I looked, I couldn't tell what flag
> I was supposed to check).  Once we do that, I need to set that flag in
> libata-scsi depending on the support for the TRIM bit in the identify
> command.

The code in drivers/ide does check the feature, although I'm not 100%
sure I got that part right.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

