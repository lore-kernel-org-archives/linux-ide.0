From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/12] libata: EH / pio tasks synchronization
Date: Sun, 22 Jan 2006 04:58:11 -0500
Message-ID: <43D35733.1040609@pobox.com>
References: <11379167111043-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34022 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932349AbWAVJ6O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:58:14 -0500
In-Reply-To: <11379167111043-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> This patch makes sure that pio tasks are flushed before proceeding
> with EH.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

> +static void ata_flush_pio_tasks(struct ata_port *ap)
> +{
> +	int tmp = 0;
> +	unsigned long flags;
> +
> +	DPRINTK("ENTER\n");
> +
> +	spin_lock_irqsave(&ap->host_set->lock, flags);
> +	ap->flags |= ATA_FLAG_FLUSH_PIO_TASK;
> +	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +
> +	DPRINTK("flush #1\n");
> +	flush_workqueue(ata_wq);
> +
> +	/*
> +	 * At this point, if a task is running, it's guaranteed to see
> +	 * the FLUSH flag; thus, it will never queue pio tasks again.
> +	 * Cancel and flush.
> +	 */
> +	tmp |= cancel_delayed_work(&ap->pio_task);
> +	tmp |= cancel_delayed_work(&ap->packet_task);
> +	if (!tmp) {
> +		DPRINTK("flush #2\n");
> +		flush_workqueue(ata_wq);
> +	}
> +
> +	spin_lock_irqsave(&ap->host_set->lock, flags);
> +	ap->flags &= ~ATA_FLAG_FLUSH_PIO_TASK;
> +	ap->hsm_task_state = HSM_ST_IDLE;
> +	spin_unlock_irqrestore(&ap->host_set->lock, flags);

Mostly ok, except

1) forcing hsm_task_state to HSM_ST_IDLE seems unlikely to be correct. 
The error handling code should already be doing that.

2) should break this patch up into two pieces:  add and use new helpers, 
and add flush code.

