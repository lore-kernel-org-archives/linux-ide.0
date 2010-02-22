From: Mark Lord <kernel@teksavvy.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Mon, 22 Feb 2010 16:49:40 -0500
Message-ID: <4B82FBF4.10702@teksavvy.com>
References: <20100220142826.62dd5989@pluto-lenny.milky.way> <4B802B54.1080009@gmail.com> <20100221022613.1096fd12@uranus> <51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com> <20100221225544.5a9ded51@pluto-lenny.milky.way> <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com> <20100222141802.2bcbf607@pluto-lenny.milky.way> <20100222190522.GD1025@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:18981 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754170Ab0BVVtp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Feb 2010 16:49:45 -0500
In-Reply-To: <20100222190522.GD1025@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: "Benjamin S." <sbenni@gmx.de>, Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 02/22/10 14:05, Jens Axboe wrote:

--- a/block/blk-core.c
+++ b/block/blk-core.c
...
@@ -1857,8 +1857,15 @@ void blk_dequeue_request(struct request *rq)
          * and to it is freed is accounted as io that is in progress at
          * the driver side.
          */
-       if (blk_account_rq(rq))
+       if (blk_account_rq(rq)) {
                 q->in_flight[rq_is_sync(rq)]++;
+               /*
+                * Mark this device as supporting hardware queuing, if
+                * we have more IOs in flight than 4.
+                */
+               if (!blk_queue_queuing(q) && queue_in_flight(q) > 4)
+                       set_bit(QUEUE_FLAG_CQ, &q->queue_flags);
+       }
  }
...

Mmm.. So is this code actually trying to rely upon the software being quick
enough to queue five or more commands before the drive completes one of them?

Wouldn't a better way be to just look at the queue_depth, for SCSI/SATA at least?

-ml
