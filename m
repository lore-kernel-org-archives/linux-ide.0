From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 2/2] block: add function for waiting for a specific free
	tag
Date: Wed, 20 May 2009 10:28:15 -0700
Message-ID: <da824cf30905201028y3c26c875v708ccb81878b85fd@mail.gmail.com>
References: <20090520065942.GD11363@kernel.dk>
	 <20090520070104.GF11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:36876 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZETR2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 13:28:17 -0400
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id n4KHSHgn017703
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 18:28:17 +0100
Received: from an-out-0708.google.com (anac3.prod.google.com [10.100.54.3])
	by spaceape10.eur.corp.google.com with ESMTP id n4KHSFVS015838
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 10:28:16 -0700
Received: by an-out-0708.google.com with SMTP id c3so424795ana.4
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 10:28:15 -0700 (PDT)
In-Reply-To: <20090520070104.GF11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com

On Wed, May 20, 2009 at 12:01 AM, Jens Axboe <jens.axboe@oracle.com> wr=
ote:
>
> We need this in libata to ensure that we don't race between internal
> tag usage and the block layer usage.
>
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> ---
> =C2=A0block/blk-tag.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 99 =
++++++++++++++++++++++++++++++++-------------
> =C2=A0drivers/ata/libata-core.c | =C2=A0 29 +++++++++----
> =C2=A0include/linux/blkdev.h =C2=A0 =C2=A0| =C2=A0 =C2=A03 +
> =C2=A03 files changed, 95 insertions(+), 36 deletions(-)
>
> diff --git a/block/blk-tag.c b/block/blk-tag.c
> index e9a7501..208468b 100644
> --- a/block/blk-tag.c
> +++ b/block/blk-tag.c
> @@ -149,6 +149,7 @@ static struct blk_queue_tag *__blk_queue_init_tag=
s(struct request_queue *q,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&tags->refcnt, 1);
> + =C2=A0 =C2=A0 =C2=A0 init_waitqueue_head(&tags->waitq);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return tags;
> =C2=A0fail:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(tags);
> @@ -264,6 +265,65 @@ int blk_queue_resize_tags(struct request_queue *=
q, int new_depth)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(blk_queue_resize_tags);
>
> +void blk_queue_acquire_tag(struct request_queue *q, int tag)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct blk_queue_tag *bqt;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!blk_queue_tagged(q) || !q->queue_tags)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 bqt =3D q->queue_tags;
> + =C2=A0 =C2=A0 =C2=A0 do {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFINE_WAIT(wait);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!test_and_set_=
bit_lock(tag, bqt->tag_map))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prepare_to_wait(&b=
qt->waitq, &wait, TASK_UNINTERRUPTIBLE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_and_set_b=
it_lock(tag, bqt->tag_map)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 spin_unlock_irq(q->queue_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 schedule();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 spin_lock_irq(q->queue_lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finish_wait(&bqt->=
waitq, &wait);
> + =C2=A0 =C2=A0 =C2=A0 } while (1);
> +}

Should blk_queue_acquire_tag() also be EXPORT_SYMBOL like
blk_queue_release_tag() is?

> +
> +void blk_queue_release_tag(struct request_queue *q, int tag)
> +{
=2E..
> +}
> +EXPORT_SYMBOL(blk_queue_release_tag);

thanks,
grant
