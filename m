From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH 06/11] ide: make ide_do_drive_cmd return rq->errors
Date: Wed, 23 Apr 2008 17:25:12 +0900
Message-ID: <20080423171232U.tomof@acm.org>
References: <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<20080423073222.GB7482@gollum.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:36851 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbYDWIZT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 04:25:19 -0400
In-Reply-To: <20080423073222.GB7482@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Wed, 23 Apr 2008 09:32:22 +0200
Borislav Petkov <petkovbb@googlemail.com> wrote:

> Hi,
> 
> On Tue, Apr 22, 2008 at 09:26:37AM +0900, FUJITA Tomonori wrote:
> > ide_do_drive_cmd forges an error value (-EIO) instead of
> > rq->errors. idetape_queue_rw_tail wants rq->errors so this patch makes
> > ide_do_drive_cmd return rq->errors.
> > 
> > For compatibility, this patch makes the users of ide_do_drive_cmd
> > return -EIO instead of a return value of ide_do_drive_cmd
> > (rq->errors).
> 
> i don't see the reason for it. In the end, the only error type that is being
> handed to and fro is -EIO and nobody is interested in rq->errors. So, whether
> ide_do_drive_cmd or its callers return -EIO is kinda unimportant. In the second
> case, however, you have simply added more code (as per the diffstat below) with
> no apparent functionality. It would only make sense, IMHO, if you would
> differentiate behaviour based on rq->errors...

I did this only because idetape_queue_rw_tail seems to have
differentiate behaviour based on rq->errors:


static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
				 struct idetape_bh *bh)
{
...

	(void) ide_do_drive_cmd(drive, &rq, ide_wait);

	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
		return 0;

	if (tape->merge_stage)
		idetape_init_merge_stage(tape);
	if (rq.errors == IDETAPE_ERROR_GENERAL)
		return -EIO;


If we can do something like:

	ret = ide_do_drive_cmd(drive, &rq, ide_wait);

	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
		return 0;

	if (tape->merge_stage)
		idetape_init_merge_stage(tape);
	if (ret)
		return -EIO;


Then yeah, we don't need this patch.
