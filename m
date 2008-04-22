From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 00/11] removing the on-stack struct request
Date: Tue, 22 Apr 2008 11:14:28 +0200
Message-ID: <58cb370e0804220214va6b7379tfa5b18acf36fd1a7@mail.gmail.com>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:39309 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbYDVJOa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 05:14:30 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2988362fkr.5
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2008 02:14:28 -0700 (PDT)
In-Reply-To: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, jens.axboe@oracle.com, Borislav Petkov <petkovbb@gmail.com>

Hi,

On Tue, Apr 22, 2008 at 2:26 AM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> This patchset converts some of the users of struct request on the
>  stack to use blk_get_request (as discussed in the large command
>  support thread [*1]).
>
>  IDE has the most users of the on-stack struct request. The on-stack
>  struct request has the benefit that it'll always work but I think that
>  using blk_get_request properly make the code clearer.
>
>  I've not got rid of all the on-stack struct request yet, but at least
>  this patchset removes the users of struct request that calls
>  blk_put_request. That is, we can remove the following hack in
>  blk_put_request:
>
>  /*
>   * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
>   * following if (q) test.
>   */
>  if (q) {
>         spin_lock_irqsave(q->queue_lock, flags);
>         __blk_put_request(q, req);
>         spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>
>  This patchset is against Bartlomiej's ide tree. #1-9 patches are for
>  the IDE subsystem and #10-11 are for the block layer. #10-11 depends
>  on #1-9 so probably it would be easier to push all the patch via a
>  single tree.
>
>  [*1]
>  http://marc.info/?l=linux-scsi&m=120817161219068&w=2

Looks promising but probably I'll not be able to review it properly
this week (I'm busy with my real job) and the next week (I'll be busy
with pushing overdue IDE updates).  OTOH I'm hoping that Borislav
would be able to take a look in the meantime.

Thanks,
Bart
