From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Mon, 22 Feb 2010 17:22:31 -0600
Message-ID: <51f3faa71002221522p74744f28ue1bb3db4558818c9@mail.gmail.com>
References: <20100220142826.62dd5989@pluto-lenny.milky.way>
	 <4B802B54.1080009@gmail.com> <20100221022613.1096fd12@uranus>
	 <51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com>
	 <20100221225544.5a9ded51@pluto-lenny.milky.way>
	 <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com>
	 <20100222141802.2bcbf607@pluto-lenny.milky.way>
	 <20100222190522.GD1025@kernel.dk> <4B82FBF4.10702@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f177.google.com ([209.85.223.177]:43044 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab0BVXWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Feb 2010 18:22:32 -0500
Received: by iwn7 with SMTP id 7so2596892iwn.4
        for <linux-ide@vger.kernel.org>; Mon, 22 Feb 2010 15:22:31 -0800 (PST)
In-Reply-To: <4B82FBF4.10702@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, "Benjamin S." <sbenni@gmx.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, Feb 22, 2010 at 3:49 PM, Mark Lord <kernel@teksavvy.com> wrote:
> On 02/22/10 14:05, Jens Axboe wrote:
>
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> ...
> @@ -1857,8 +1857,15 @@ void blk_dequeue_request(struct request *rq)
> =A0 =A0 =A0 =A0 * and to it is freed is accounted as io that is in pr=
ogress at
> =A0 =A0 =A0 =A0 * the driver side.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (blk_account_rq(rq))
> + =A0 =A0 =A0 if (blk_account_rq(rq)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->in_flight[rq_is_sync(rq)]++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Mark this device as supporting har=
dware queuing, if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we have more IOs in flight than 4.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!blk_queue_queuing(q) && queue_in_f=
light(q) > 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(QUEUE_FLAG_CQ, =
&q->queue_flags);
> + =A0 =A0 =A0 }
> =A0}
> ...
>
> Mmm.. So is this code actually trying to rely upon the software being=
 quick
> enough to queue five or more commands before the drive completes one =
of
> them?
>
> Wouldn't a better way be to just look at the queue_depth, for SCSI/SA=
TA at
> least?

Yeah, that seems like a rather fragile heuristic to me..
