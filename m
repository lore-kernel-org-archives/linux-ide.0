From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Mon, 11 Feb 2008 19:30:01 +0300
Message-ID: <47B07809.6010404@ru.mvista.com>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc> <200802101438.46698.bzolnier@gmail.com> <1202653165.3136.18.camel@localhost.localdomain> <200802101932.06946.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:25467 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755369AbYBKQ3H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 11:29:07 -0500
In-Reply-To: <200802101932.06946.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@infradead.org>, Sebastian Siewior <ide+bug@ml.breakpoint.cc>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Bartlomiej Zolnierkiewicz wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide-disk: fix flush requests (take 2)

> commit 813a0eb233ee67d7166241a8b389b6a76f2247f9
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Fri Jan 25 22:17:10 2008 +0100

>     ide: switch idedisk_prepare_flush() to use REQ_TYPE_ATA_TASKFILE requests

> ...

> broke flush requests.

> Allocating IDE command structure on the stack for flush requests is not
> a very brilliant idea:

> - idedisk_prepare_flush() only prepares the request and it doesn't wait
>   for it to be completed

> - there are can be multiple flush requests queued in the queue

> Fix the problem (per hints from James Bottomley) by:
> - dynamically allocating ide_task_t instance using kmalloc(..., GFP_ATOMIC)
> - adding new taskfile flag (IDE_TFLAG_DYN)
> - calling kfree() in ide_end_drive_command() if IDE_TFLAG_DYN is set
>   (while at it rename 'args' to 'task' and fix whitespace damage)

> [ This will be fixed properly before 2.6.25 but this bug is rather
>   critical and the proper solution requires some more work + testing. ]

> Thanks to Sebastian Siewior and Christoph Hellwig for reporitng the
> problem and testing patches (extra thanks to Sebastian for bisecting
> it to the guilty commmit).
> 
> Cc: Sebastian Siewior <ide-bug@ml.breakpoint.cc>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Jens Axboe <jens.axboe@oracle.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-disk.c
> ===================================================================
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -590,20 +590,24 @@ static ide_proc_entry_t idedisk_proc[] =
>  static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
>  {
>  	ide_drive_t *drive = q->queuedata;
> -	ide_task_t task;
> +	ide_task_t *task = kmalloc(sizeof(*task), GFP_ATOMIC);
>  
> -	memset(&task, 0, sizeof(task));
> +	/* FIXME: map struct ide_taskfile on rq->cmd[] */
> +	BUG_ON(task == NULL);
> +
> +	memset(task, 0, sizeof(*task));

    Why not kzalloc() then?

MBR, Sergei
