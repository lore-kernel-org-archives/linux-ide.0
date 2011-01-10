From: Vasily Tarasov <sectorsize512@gmail.com>
Subject: Re: [PATCH] ide: no need to check for the rq pointer to be NULL
Date: Mon, 10 Jan 2011 12:30:44 -0500
Message-ID: <20110110173044.GA3495@white.fsl.cs.sunysb.edu>
References: <20110109235146.GA5353@white.fsl.cs.sunysb.edu>
 <4D2AFACB.3040909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42409 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1AJRaw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 12:30:52 -0500
Received: by qyk12 with SMTP id 12so22205265qyk.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 09:30:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2AFACB.3040909@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: davem@davemloft.net, linux-ide@vger.kernel.org

Ooops, you're right, ide_kill_rq() sets  hwif->rq (and rq in turn) to NULL.
Please disregard this patch.

Vasily

On Mon, Jan 10, 2011 at 03:25:47PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 10-01-2011 2:51, Vasily Tarasov wrote:
> 
> >From: Vasily Tarasov<sectorsize512@gmail.com>
> 
> >No need to check for the rq pointer to be NULL before calling
> >blk_fetch_request().  First we call it, then we test the pointer that it
> >returns.
> 
> >Signed-off-by: Vasily Tarasov<sectorsize512@gmail.com>
> 
>    I'm not feeling sure about this patch...
> 
> >--- linux-2.6.37/drivers/ide/ide-io.c.orig	2011-01-04 19:50:19.000000000 -0500
> >+++ linux-2.6.37/drivers/ide/ide-io.c	2011-01-09 18:15:44.000000000 -0500
> >@@ -438,7 +438,7 @@ void do_ide_request(struct request_queue
> >  	ide_drive_t	*drive = q->queuedata;
> >  	ide_hwif_t	*hwif = drive->hwif;
> >  	struct ide_host *host = hwif->host;
> >-	struct request	*rq = NULL;
> >+	struct request	*rq;
> >  	ide_startstop_t	startstop;
> >
> >  	spin_unlock_irq(q->queue_lock);
> >@@ -485,16 +485,13 @@ repeat:
> >
> >  		spin_unlock_irq(&hwif->lock);
> >  		spin_lock_irq(q->queue_lock);
> >+		rq = blk_fetch_request(drive->queue);
> >+		spin_unlock_irq(q->queue_lock);
> >+		spin_lock_irq(&hwif->lock);
> >  		/*
> >  		 * we know that the queue isn't empty, but this can happen
> >  		 * if the q->prep_rq_fn() decides to kill a request
> >  		 */
> >-		if (!rq)
> >-			rq = blk_fetch_request(drive->queue);
> 
>    Did you consider the scenario where the 'goto' is taken at the
> end of this *if* branch? 'rq' is non-NULL then...
> 
> >-
> >-		spin_unlock_irq(q->queue_lock);
> >-		spin_lock_irq(&hwif->lock);
> >-
> >  		if (!rq) {
> >  			ide_unlock_port(hwif);
> >  			goto out;
> 
> WBR, Serge
