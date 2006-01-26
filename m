From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 15:11:17 +0100
Message-ID: <58cb370e0601260611y67abe723w6085ab30e7e6274e@mail.gmail.com>
References: <20060126055050.GA4737@htj.dyndns.org>
	 <20060126091805.GO4212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:54295 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932324AbWAZOLx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jan 2006 09:11:53 -0500
Received: by nproxy.gmail.com with SMTP id x29so129915nfb
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 06:11:18 -0800 (PST)
In-Reply-To: <20060126091805.GO4212@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@laposte.net, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On 1/26/06, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Jan 26 2006, Tejun Heo wrote:
> > Hello, Nicolas.  Hello, all.
> >
> > Nicolas, I'm probably the guy who broke your filesystem.  :-p This FUA
> > (forced-unit-access)thing made into the mainline lately, and it seems
> > that your drive is reporting FUA support but doesn't really do it
> > properly when it's asked to.
>
> It's strange. I have 3 out of 4 drives in a box here reporting FUA
> capability, and I have now tested all three of them both with plain FUA
> writes and NCQ FUA tagged writes. I used data integrity verifying
> writes, and the data is sound as well. fs likewise, I used ext3 mounted
> with barriers enabled.

You are just lucky ;-).  There are drives out there having buggy NCQ
support.  Windows driver for Sil have them listed in .inf file, you can also
find discussions on various internet forums about problems (including
data corruption) with these drives and controllers supporting NCQ.

However there is official firmware update so hopefully it can be fixed
(unfortunately we still need to blacklist buggy firmware revisions).

I wouldn't be surprised if there is similar situation with FUA support.
Does anybody know if Windows use FUA?

Bartlomiej
