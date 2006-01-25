From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Wed, 25 Jan 2006 10:12:50 -0500
Message-ID: <20060125151250.GD14225@havoc.gtf.org>
References: <20060124194343.GB25402@gollum.tnic> <20060124194741.GG23269@havoc.gtf.org> <58cb370e0601250704v4aa89fc2n5f7194bbacd4a278@mail.gmail.com> <20060125150646.GC14225@havoc.gtf.org> <20060125151343.GE4212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:31914 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751221AbWAYPMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jan 2006 10:12:51 -0500
Content-Disposition: inline
In-Reply-To: <20060125151343.GE4212@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov <bbpetkov@yahoo.de>, linux-ide@vger.kernel.org, htejun@gmail.com, randy_d_dunlap@linux.intel.com

On Wed, Jan 25, 2006 at 04:13:44PM +0100, Jens Axboe wrote:
> It looks cleaner, though. printk() lines are usually the worst to keep
> from wrapping, saving a tab indentation there seems like it would be
> worth it imho.

We have an explosion of printk() macros in the kernel already, and
hiding the 'if' test has little value to me...

	Jeff



