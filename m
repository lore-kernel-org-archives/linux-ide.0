From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ide: no need to check for the rq pointer to be NULL
Date: Mon, 10 Jan 2011 15:25:47 +0300
Message-ID: <4D2AFACB.3040909@ru.mvista.com>
References: <20110109235146.GA5353@white.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50388 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab1AJM0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 07:26:55 -0500
Received: by eye27 with SMTP id 27so8503067eye.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 04:26:54 -0800 (PST)
In-Reply-To: <20110109235146.GA5353@white.fsl.cs.sunysb.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vasily Tarasov <sectorsize512@gmail.com>
Cc: davem@davemloft.net, linux-ide@vger.kernel.org

Hello.

On 10-01-2011 2:51, Vasily Tarasov wrote:

> From: Vasily Tarasov<sectorsize512@gmail.com>

> No need to check for the rq pointer to be NULL before calling
> blk_fetch_request().  First we call it, then we test the pointer that it
> returns.

> Signed-off-by: Vasily Tarasov<sectorsize512@gmail.com>

    I'm not feeling sure about this patch...

> --- linux-2.6.37/drivers/ide/ide-io.c.orig	2011-01-04 19:50:19.000000000 -0500
> +++ linux-2.6.37/drivers/ide/ide-io.c	2011-01-09 18:15:44.000000000 -0500
> @@ -438,7 +438,7 @@ void do_ide_request(struct request_queue
>   	ide_drive_t	*drive = q->queuedata;
>   	ide_hwif_t	*hwif = drive->hwif;
>   	struct ide_host *host = hwif->host;
> -	struct request	*rq = NULL;
> +	struct request	*rq;
>   	ide_startstop_t	startstop;
>
>   	spin_unlock_irq(q->queue_lock);
> @@ -485,16 +485,13 @@ repeat:
>
>   		spin_unlock_irq(&hwif->lock);
>   		spin_lock_irq(q->queue_lock);
> +		rq = blk_fetch_request(drive->queue);
> +		spin_unlock_irq(q->queue_lock);
> +		spin_lock_irq(&hwif->lock);
>   		/*
>   		 * we know that the queue isn't empty, but this can happen
>   		 * if the q->prep_rq_fn() decides to kill a request
>   		 */
> -		if (!rq)
> -			rq = blk_fetch_request(drive->queue);

    Did you consider the scenario where the 'goto' is taken at the end of this 
*if* branch? 'rq' is non-NULL then...

> -
> -		spin_unlock_irq(q->queue_lock);
> -		spin_lock_irq(&hwif->lock);
> -
>   		if (!rq) {
>   			ide_unlock_port(hwif);
>   			goto out;

WBR, Sergei
