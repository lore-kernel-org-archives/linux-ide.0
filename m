From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 15:27:14 +0100
Message-ID: <20060126142714.GA4290@suse.de>
References: <20060126055050.GA4737@htj.dyndns.org> <20060126091805.GO4212@suse.de> <58cb370e0601260611y67abe723w6085ab30e7e6274e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:836 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932342AbWAZOf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 09:35:29 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0601260611y67abe723w6085ab30e7e6274e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@laposte.net, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Thu, Jan 26 2006, Bartlomiej Zolnierkiewicz wrote:
> On 1/26/06, Jens Axboe <axboe@suse.de> wrote:
> > On Thu, Jan 26 2006, Tejun Heo wrote:
> > > Hello, Nicolas.  Hello, all.
> > >
> > > Nicolas, I'm probably the guy who broke your filesystem.  :-p This FUA
> > > (forced-unit-access)thing made into the mainline lately, and it seems
> > > that your drive is reporting FUA support but doesn't really do it
> > > properly when it's asked to.
> >
> > It's strange. I have 3 out of 4 drives in a box here reporting FUA
> > capability, and I have now tested all three of them both with plain FUA
> > writes and NCQ FUA tagged writes. I used data integrity verifying
> > writes, and the data is sound as well. fs likewise, I used ext3 mounted
> > with barriers enabled.
> 
> You are just lucky ;-).  There are drives out there having buggy NCQ
> support.  Windows driver for Sil have them listed in .inf file, you can also

Oh yeah, I'm very well aware of NCQ firmware issues. Interesting about
the Sil inf file having them listed, I started a blacklist myself for
NCQ and I'll be sure to look at theirs!

> find discussions on various internet forums about problems (including
> data corruption) with these drives and controllers supporting NCQ.

But that's a seperate story, it's just plain FUA that is the case here.

> However there is official firmware update so hopefully it can be fixed
> (unfortunately we still need to blacklist buggy firmware revisions).
> 
> I wouldn't be surprised if there is similar situation with FUA support.
> Does anybody know if Windows use FUA?

Actually I'm a little surprised, honestly. It's a pretty simple feature.
It's not like NCQ where I can understand that bugs can creap into the
firmware (although some are so buggy it's unbelivable).

-- 
Jens Axboe

