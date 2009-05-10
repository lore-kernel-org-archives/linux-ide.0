From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/14] ide-atapi: switch to rq->resid_len
Date: Sun, 10 May 2009 23:32:32 +0200
Message-ID: <200905102332.33022.bzolnier@gmail.com>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <1241855134-4984-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:44286 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbZEJVgA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 May 2009 17:36:00 -0400
In-Reply-To: <1241855134-4984-4-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 09 May 2009 09:45:23 Borislav Petkov wrote:
> Now that we have rq->resid_len, use it to account partial completion
> amount during the lifetime of an rq, decrementing it on each successful
> transfer. As a result, get rid of now unused pc->xferred.
> 
> While at it, remove noisy debug call in ide_prep_sense.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-atapi.c |   17 ++++++++---------
>  drivers/ide/ide-tape.c  |   11 ++++-------
>  include/linux/ide.h     |    2 --
>  3 files changed, 12 insertions(+), 18 deletions(-)

WARNING: line over 80 characters
#118: FILE: drivers/ide/ide-tape.c:370:
+               int blocks = (blk_rq_bytes(rq) - rq->resid_len) / tape->blk_size;
