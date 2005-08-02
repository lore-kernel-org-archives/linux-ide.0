From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 02 Aug 2005 15:54:05 +0200
Message-ID: <42EF7AFD.9090507@imc-berlin.de>
References: <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <20050802125437.GA11967@suse.de> <42EF6F18.4090905@imc-berlin.de> <20050802130646.GA7519@suse.de> <42EF7747.6050208@imc-berlin.de> <20050802134546.GC2408@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060402080001060702080704"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:22537 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261520AbVHBNyH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 09:54:07 -0400
In-Reply-To: <20050802134546.GC2408@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

This is a multi-part message in MIME format.
--------------060402080001060702080704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

> On Tue, Aug 02 2005, Steven Scholz wrote:
> 
>>Jens Axboe wrote:
>>
>>
>>>On Tue, Aug 02 2005, Steven Scholz wrote:
>>>
>>>
>>>>Jens Axboe wrote:
>>>>
>>>>
>>>>
>>>>>It's not the right way, it only solves a little part of the problem.
>>>>>Killing a request with an error usually looks like this:
>>>>>
>>>>>	blkdev_dequeue_request(rq);
>>>>>	end_that_request_first(rq, 0, rq->hard_nr_sectors);
>>>>>	end_that_request_last(rq);
>>>>
>>>>How do I get the request? do_ide_request() only get the complete 
>>>>request_queue_t *q. Shell I use elv_next_request() ?
>>>
>>>Yes.
>>
>>So my workaround for now would be
>>
>>--- linux-2.6.13-rc5/drivers/ide/ide-io.c
>>+++ linux-2.6.13-rc4-at91-multiIO/drivers/ide/ide-io.c
>>@@ -1230,7 +1264,18 @@ void do_ide_request(request_queue_t *q)
>> {
>>        ide_drive_t *drive = q->queuedata;
>>
>>-       ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
>>+       if (drive->present)
>>+               ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
>>+       else {
>>+               struct request  *rq;
>>+               printk("%s() drive is not present anymore! Kill 
>>request.\n", __FUNCTION__);
>>+               rq = elv_next_request(q);
>>+               if (rq) {
>>+                       blkdev_dequeue_request(rq);
>>+                       end_that_request_first(rq, 0, rq->hard_nr_sectors);
>>+                       end_that_request_last(rq);
>>+               }
>>+       }
> 
> 
> Pretty close. Make the killing a loop:

...

[PATCH] ide: kill requests when drive is not present anymore

Signed-off-by: Steven Scholz <steven.scholz@imc-berlin.de>

Ok?

Change the CHANGELOG at your will.

--
Steven

--------------060402080001060702080704
Content-Type: text/plain;
 name="ide_kill_rq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_kill_rq.patch"

--- linux-2.6.13-rc5/drivers/ide/ide-io.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc4-at91-multiIO/drivers/ide/ide-io.c	2005-08-02 15:46:53.000000000 +0200
@@ -1230,7 +1257,17 @@ void do_ide_request(request_queue_t *q)
 {
 	ide_drive_t *drive = q->queuedata;
 
-	ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
+	if (drive->present)
+		ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
+	else {
+		struct request	*rq;
+		printk(KERN_WARNING "%s: not present, killing requests\n", drive->name);
+		while ((rq = elv_next_request(q)) != NULL) {
+			blkdev_dequeue_request(rq);
+			end_that_request_first(rq, 0, rq->hard_nr_sectors);
+			end_that_request_last(rq);
+		}
+	}
 }
 
 /*

--------------060402080001060702080704--
