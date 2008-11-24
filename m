From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Sun, 23 Nov 2008 22:01:11 -0500
Message-ID: <20081124030111.GC2163@mit.edu>
References: <4928E010.4090801@kernel.org> <4929023C.2060302@suse.de> <20081123123514.GI5707@parisc-linux.org> <1227447584.4901.405.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52742 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075AbYKXDGr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 22:06:47 -0500
Content-Disposition: inline
In-Reply-To: <1227447584.4901.405.camel@macbook.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Tejun Heo <teheo@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Dongjun Shin <djshin90@gmail.com>, chris.mason@oracle.com

On Sun, Nov 23, 2008 at 01:39:44PM +0000, David Woodhouse wrote:
> On Sun, 2008-11-23 at 05:35 -0700, Matthew Wilcox wrote:
> > The current VFAT filesystem implements DISCARD. 
> 
> As does btrfs. I think I posted ext2 patches a little while ago too? Or
> someone else did. Did they get merged?

Looks like they didn't get merged.  I thought akpm was going to merge
them.  Ext4 has discard support though.  It doesn't port easily to
ext3 since it ext4 has a new block allocator.

					- Ted
