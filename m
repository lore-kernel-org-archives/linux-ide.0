From: Jens Axboe <axboe@suse.de>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Wed, 25 Jan 2006 16:16:48 +0100
Message-ID: <20060125151645.GF4212@suse.de>
References: <20060124194343.GB25402@gollum.tnic> <20060124194741.GG23269@havoc.gtf.org> <58cb370e0601250704v4aa89fc2n5f7194bbacd4a278@mail.gmail.com> <20060125150646.GC14225@havoc.gtf.org> <20060125151343.GE4212@suse.de> <20060125151250.GD14225@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:59978 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751226AbWAYPP3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jan 2006 10:15:29 -0500
Content-Disposition: inline
In-Reply-To: <20060125151250.GD14225@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov <bbpetkov@yahoo.de>, linux-ide@vger.kernel.org, htejun@gmail.com, randy_d_dunlap@linux.intel.com

On Wed, Jan 25 2006, Jeff Garzik wrote:
> On Wed, Jan 25, 2006 at 04:13:44PM +0100, Jens Axboe wrote:
> > It looks cleaner, though. printk() lines are usually the worst to keep
> > from wrapping, saving a tab indentation there seems like it would be
> > worth it imho.
> 
> We have an explosion of printk() macros in the kernel already, and
> hiding the 'if' test has little value to me...

Well that's mainly because every driver / sub-system roll their own
debug-printk system. It's not about hiding the if test imo, it's about
saving the identation.

-- 
Jens Axboe

