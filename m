From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE detection
Date: Sun, 19 Apr 2009 06:42:38 +0900
Message-ID: <49EA494E.9070007@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com> <200904181851.50010.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46896 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbZDRVmq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 17:42:46 -0400
In-Reply-To: <200904181851.50010.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Can't we just apply them both? :)

I don't think Borislav's patch is correct.

> Could it be that we just need to take care if this case:
> 
>         if (rq->cmd[13] & REQ_IDETAPE_PC2) {
>                 idetape_media_access_finished(drive);
>                 return ide_stopped;
>         }
> 
> [all other code-paths set pc before calling ide_tape_issue_pc()]

drive->pc is not supposed to be set in do_request().  It should point
to the previous pc structure for REQUEST_SENSE retry handling.  Note
that in this case the previous command pc structure is guaranteed to
be valid.  It's a fragile and confusing logic but, well, that's how
the current code works.

Thanks.

-- 
tejun
