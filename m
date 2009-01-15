From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through
	sysfs
Date: Thu, 15 Jan 2009 18:17:09 -0500
Message-ID: <1232061429.5966.87.camel@localhost.localdomain>
References: <200901051952.58029.bzolnier@gmail.com>
	 <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>
	 <20090106073515.GY32491@kernel.dk> <4964866D.8010503@msgid.tls.msk.ru>
	 <1231342473.3282.19.camel@localhost.localdomain> <496ECBA0.60209@gmail.com>
	 <87f94c370901150707h10506e99reaa40c23e32ab18c@mail.gmail.com>
	 <1232035561.5966.48.camel@localhost.localdomain>
	 <da824cf30901151055o2385ef74x918e8390e576d807@mail.gmail.com>
	 <1232046039.5966.54.camel@localhost.localdomain>
	 <da824cf30901151445q6b54c0b1nbf24f03849e1a5b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:40165 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752662AbZAOXRP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 18:17:15 -0500
In-Reply-To: <da824cf30901151445q6b54c0b1nbf24f03849e1a5b3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Greg Freemyer <greg.freemyer@gmail.com>, Tejun Heo <htejun@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Kay Sievers <kay.sievers@vrfy.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 2009-01-15 at 14:45 -0800, Grant Grundler wrote:
> On Thu, Jan 15, 2009 at 11:00 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> ...
> >> Code can test for zero/nonzero or (preferably) more fine grained.
> >> e.g. "avgreadcost > 1ms" or "avgwritecost". I'm hoping this test
> >> can be abstracted into a macro.
> >
> > Um these really have to be things we can get out of the device at boot
> > time without effort (as in part of the data the device can give in a
> > single command).  I'll be shot for increasing boot time so we can work
> > out these parameters ...
> 
> No. The whole point is we should not care what it is at boot time.
> It should be based on recent history of what is going on.
> At boot time we read the partition table and we superblocks to mount
> file systems.
> That's fine to start with. So I don't see any need to add some synthetic test
> to establish initial values.
> 
> The rest of the code should work regardless of what the values start out to be.
> This is true for the previous proposed patch too when user space has
> to decide what the right policy is.

OK, so they could be calculated on the fly in the elevators, I suppose.
But what would the value be?  Right now we use the nonrotational flag to
basically not bother with plugging (no point if no seek penalty) on
certain events where we'd previously have waited for other I/O to join.
But that's really a seek penalty parameter rather than the idea of read
or write costing (although the elevators usually track these dynamically
anyway ... as part of the latency calculations but not explicitly).

James


