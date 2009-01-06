From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through
 sysfs
Date: Tue, 6 Jan 2009 19:46:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0901061920540.4888@blonde.anvils>
References: <fa.+H1UnEqOmFht/vMPmVy8ellbQi0@ifi.uio.no>
 <fa.RLz5WOGorLui5GRkc963Ww1kXqg@ifi.uio.no> <fa.x4ejZ7Kj7ZZRu88Sond1Cap6XxY@ifi.uio.no>
 <49628720.6050101@yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:43040 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbZAFTrJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 14:47:09 -0500
In-Reply-To: <49628720.6050101@yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Sitsofe Wheeler <sitsofe@yahoo.com>, Kay Sievers <kay.sievers@vrfy.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, 5 Jan 2009, Sitsofe Wheeler wrote:
> Kay Sievers wrote:
> > On Mon, Jan 5, 2009 at 19:54, Jens Axboe <jens.axboe@oracle.com> wrote:
> > > On Mon, Jan 05 2009, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > > +static struct queue_sysfs_entry queue_nonrot_entry = {
> > > > +     .attr = {.name = "nonrot", .mode = S_IRUGO | S_IWUSR },
> > > > +     .show = queue_nonrot_show,
> > > > +     .store = queue_nonrot_store,
> > > > +};
> > > > +
> > > Lets please use a better name for export reasons, non-rotational is a
> > > lot better. Nobody will know what nonrot means :-)
> > 
> > What's that negation good for? Can't we just have "rotational", like
> > we have "removable" and not "non-removable"? :)
> 
> How about cheapseek? fastrandom? flash? ssd? However the internal flag is
> called QUEUE_FLAG_NONROT so it kind of makes sense just to leave it as
> nonrot...

Many thanks to Bart (and Alan) for this patch:
just what I'd been hoping for when I wrote (25 Nov)
But how to get my SD card, accessed by USB card reader, reported as NONROT?

However, may I join Kai in protesting the negative boolean flag?
I've never quite recovered from CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER;
and while this is obviously nowhere near the same league, I'd much
rather stay well away.

I don't like the "nonrot" or "rotational" at all myself: though you
may be able to advance convincing arguments why it's not accidental,
isn't the rotationality pretty much incidental to whether the seeks
are cheap?  I imagine a long bar loaded with data, which zips back
and forth through the reader: nothing rotational, but expensive seeks.
(I had been going to propose magnetic tape, but the rotation of the
spools muddies that argument.)

When doing the swap patch, though I toed the line with SWP_NONROT
for quite a while (I do dislike using different names for the same
notion at different levels), I couldn't stomach it in the end, and
went for SWP_SOLIDSTATE.

But I particularly like Sitsofe's "cheapseek".  Is that is an accurate
representation of how the I/O schedulers treat it?  then please can we
name the user-visible sysfs file accordingly?

The kernel-internal name is much less important, though I'd be pretty
happy to have CHEAPSEEK instead of NONROT throughout there too.

Oh, another problem with NONROT: flash rots a lot sooner than disk,
doesn't it?

Hugh
