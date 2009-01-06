From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Tue, 6 Jan 2009 08:35:15 +0100
Message-ID: <20090106073515.GY32491@kernel.dk>
References: <200901051952.58029.bzolnier@gmail.com> <20090105185428.GS32491@kernel.dk> <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:17517 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbZAFHgU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 02:36:20 -0500
Content-Disposition: inline
In-Reply-To: <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, Jan 05 2009, Kay Sievers wrote:
> On Mon, Jan 5, 2009 at 19:54, Jens Axboe <jens.axboe@oracle.com> wrote:
> > On Mon, Jan 05 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> >> +static struct queue_sysfs_entry queue_nonrot_entry = {
> >> +     .attr = {.name = "nonrot", .mode = S_IRUGO | S_IWUSR },
> >> +     .show = queue_nonrot_show,
> >> +     .store = queue_nonrot_store,
> >> +};
> >> +
> >
> > Lets please use a better name for export reasons, non-rotational is a
> > lot better. Nobody will know what nonrot means :-)
> 
> What's that negation good for? Can't we just have "rotational", like
> we have "removable" and not "non-removable"? :)

Non-rotational is the term typically used, since rotational is the norm
(still). So I think the negation actually makes sense in this case :-)

-- 
Jens Axboe

