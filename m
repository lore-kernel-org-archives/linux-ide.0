From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2/6] ide: fix ide_kill_rq() for special ide-{floppy,tape} driver requests
Date: Wed, 24 Jun 2009 12:09:53 +0200
Message-ID: <200906241209.53891.bzolnier@gmail.com>
References: <200906232326.06830.bzolnier@gmail.com> <20090623.234929.32348223.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46314 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbZFXKEF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 06:04:05 -0400
In-Reply-To: <20090623.234929.32348223.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, petkovbb@gmail.com, htejun@gmail.com

On Wednesday 24 June 2009 08:49:29 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 23 Jun 2009 23:26:06 +0200
> 
> > @@ -152,7 +152,7 @@ void ide_kill_rq(ide_drive_t *drive, str
> >  
> >  	if ((media == ide_floppy || media == ide_tape) && drv_req) {
> >  		rq->errors = 0;
> > -		ide_complete_rq(drive, 0, blk_rq_bytes(rq));
> > +		ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));
> >  	} else {
> >  		if (media == ide_tape)
> >  			rq->errors = IDE_DRV_ERROR_GENERAL;
> 
> I've done some research and this logic of returning "0" appears to be
> intentional.
> 
> It keeps the block layer from printing the "I/O error" kernel log
> message during completion of the request.

It would be pretty illogical behavior for driver to intentionally not
let user know about the failed requests..

> IDE tape as one example, seems to have it's own system of passing
> errors back up to the special command completion, via rq->errors
> and IDE_DRV_ERROR_GENERAL.

Please look at the patch/code:

 		rq->errors = 0;
-		ide_complete_rq(drive, 0, blk_rq_bytes(rq));
+		ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));

and notice rq->errors line.

> See idetape_queue_rw_tail() and ide_tape_callback() for example.
> 
> IDE floppy has similar pieces of logic, and possibly similar desires
> wrt. emission of the block layer I/O error log message during
> special requests.
> 
> When something sticks out like an eyesore (as this -EIO thing does)
> and seems to make no sense at all, there often is some obscure
> reason.

The obscure reasons is just the fact that both ide-floppy and ide-tape
had a they own duplicated/buggy request completion routines.

While they were being unified the whole bunch of similar class of bugs
were fixed so I agree that there may still be more issues to deal with
there.
