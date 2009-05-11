From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/14] ide-atapi: switch to rq->resid_len
Date: Mon, 11 May 2009 13:22:59 +0200
Message-ID: <200905111322.59728.bzolnier@gmail.com>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <200905102332.33022.bzolnier@gmail.com> <20090511072349.GA21045@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:37465 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbZEKMFE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 08:05:04 -0400
In-Reply-To: <20090511072349.GA21045@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bp@kernel.org
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 11 May 2009 09:23:49 Borislav Petkov wrote:
> On Sun, May 10, 2009 at 11:32:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 09 May 2009 09:45:23 Borislav Petkov wrote:
> > > Now that we have rq->resid_len, use it to account partial completion
> > > amount during the lifetime of an rq, decrementing it on each successful
> > > transfer. As a result, get rid of now unused pc->xferred.
> > > 
> > > While at it, remove noisy debug call in ide_prep_sense.
> > > 
> > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > ---
> > >  drivers/ide/ide-atapi.c |   17 ++++++++---------
> > >  drivers/ide/ide-tape.c  |   11 ++++-------
> > >  include/linux/ide.h     |    2 --
> > >  3 files changed, 12 insertions(+), 18 deletions(-)
> > 
> > WARNING: line over 80 characters
> > #118: FILE: drivers/ide/ide-tape.c:370:
> > +               int blocks = (blk_rq_bytes(rq) - rq->resid_len) / tape->blk_size;
> 
> No worries, I haven't forgotten the checkpatch thing but the line is
> 81 chars and I just didn't want to split it because of _one_ char. The
> benefit of readability of having it on one line should be more important
> than one stupid static rule. I think we should relax it if enforcing it
> worsens readability...
> 
>                int blocks = (blk_rq_bytes(rq) - rq->resid_len) /
> 			     tape->blk_size;
> 
> Now this looks awful, IMHO. I'd much rather not listen to checkpatch
> here.

Please think outside of checkpatch.pl box, since 'blocks' shouldn't be 'int'
in the first place:

		unsigned int blocks =
			(blk_rq_bytes(rq) - rq->resid_len) / tape->blk_size;
