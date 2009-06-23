From: Joe Perches <joe@perches.com>
Subject: Re: [patch 3/6] ide: always kill the whole request on error
Date: Tue, 23 Jun 2009 16:37:54 -0700
Message-ID: <1245800274.29098.75.camel@Joe-Laptop.home>
References: <200906232327.27610.bzolnier@gmail.com>
	 <20090623.161904.177489795.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:3586 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZFWXh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 19:37:58 -0400
In-Reply-To: <20090623.161904.177489795.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, petkovbb@gmail.com, htejun@gmail.com

On Tue, 2009-06-23 at 16:19 -0700, David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 23 Jun 2009 23:27:27 +0200
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: always kill the whole request on error
> > --- a/drivers/ide/ide-eh.c
> > +++ b/drivers/ide/ide-eh.c
> > @@ -149,7 +149,7 @@ static inline void ide_complete_drive_re
> >  	if (rq && blk_special_request(rq) && rq->cmd[0] == REQ_DRIVE_RESET) {
> >  		if (err <= 0 && rq->errors == 0)
> >  			rq->errors = -EIO;
> > -		ide_complete_rq(drive, err ? err : 0, ide_rq_bytes(rq));
> > +		ide_complete_rq(drive, err ? err : 0, blk_rq_bytes(rq));

Doesn't that "err ? err : 0" look odd?
Why not just err?


