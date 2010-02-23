From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Tue, 23 Feb 2010 07:21:23 +0100
Message-ID: <20100223062123.GG1025@kernel.dk>
References: <20100220142826.62dd5989@pluto-lenny.milky.way> <4B802B54.1080009@gmail.com> <20100221022613.1096fd12@uranus> <51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com> <20100221225544.5a9ded51@pluto-lenny.milky.way> <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com> <20100222141802.2bcbf607@pluto-lenny.milky.way> <20100222190522.GD1025@kernel.dk> <4B82FBF4.10702@teksavvy.com> <51f3faa71002221522p74744f28ue1bb3db4558818c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:56098 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab0BWGVZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Feb 2010 01:21:25 -0500
Content-Disposition: inline
In-Reply-To: <51f3faa71002221522p74744f28ue1bb3db4558818c9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, "Benjamin S." <sbenni@gmx.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, Feb 22 2010, Robert Hancock wrote:
> On Mon, Feb 22, 2010 at 3:49 PM, Mark Lord <kernel@teksavvy.com> wrot=
e:
> > On 02/22/10 14:05, Jens Axboe wrote:
> >
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > ...
> > @@ -1857,8 +1857,15 @@ void blk_dequeue_request(struct request *rq)
> > =A0 =A0 =A0 =A0 * and to it is freed is accounted as io that is in =
progress at
> > =A0 =A0 =A0 =A0 * the driver side.
> > =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 if (blk_account_rq(rq))
> > + =A0 =A0 =A0 if (blk_account_rq(rq)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->in_flight[rq_is_sync(rq)]++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Mark this device as supporting h=
ardware queuing, if
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we have more IOs in flight than =
4.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!blk_queue_queuing(q) && queue_in=
_flight(q) > 4)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(QUEUE_FLAG_CQ=
, &q->queue_flags);
> > + =A0 =A0 =A0 }
> > =A0}
> > ...
> >
> > Mmm.. So is this code actually trying to rely upon the software bei=
ng quick
> > enough to queue five or more commands before the drive completes on=
e of
> > them?

Yes, it'll trigger easily. If it's the boot drive, it'll be on before
booting has completed.

> > Wouldn't a better way be to just look at the queue_depth, for SCSI/=
SATA at
> > least?
>=20
> Yeah, that seems like a rather fragile heuristic to me..

It may seem fragile, but it's not. Queue depth is device information
that isn't available at the block level.

--=20
Jens Axboe

