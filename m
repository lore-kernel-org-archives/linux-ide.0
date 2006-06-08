From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/02] libata: implement ata_eh_wait()
Date: Thu, 08 Jun 2006 16:49:29 -0400
Message-ID: <44888D59.9010000@pobox.com>
References: <20060531101932.GA8106@htj.dyndns.org> <20060531102005.GB8106@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30681 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964999AbWFHUtb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 16:49:31 -0400
In-Reply-To: <20060531102005.GB8106@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> +	spin_lock_irqsave(&ap->host_set->lock, flags);
> +
> +	while (ap->flags & (ATA_FLAG_EH_PENDING | ATA_FLAG_EH_IN_PROGRESS)) {
> +		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
> +		spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +		schedule();
> +		spin_lock_irqsave(&ap->host_set->lock, flags);
> +	}


Two comments:

* why not use completions?

* don't use schedule().  If there's nothing to schedule, it IMO chews up 
too much CPU busy-waiting.  schedule_timeout(1) will at least wait for 
the next timer tick.

