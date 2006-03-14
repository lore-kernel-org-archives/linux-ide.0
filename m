From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata-dev: add flush task to ata_exec_internal()
Date: Tue, 14 Mar 2006 15:12:44 +0900
Message-ID: <44165EDC.3070800@gmail.com>
References: <44163628.2000001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:9514 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750943AbWCNGNM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2006 01:13:12 -0500
Received: by xproxy.gmail.com with SMTP id s14so926844wxc
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 22:13:11 -0800 (PST)
In-Reply-To: <44163628.2000001@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Add ata_port_flush_task() to ata_exec_internal().
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> It seems we also need ata_port_flush_task() in ata_exec_internal().
> 
> Patch against the upstream branch
> (fb21f0d0ec7e31cc814165e1a9d2662d9c9dd980).
> 
> For your review, thanks,
> 
> Albert
> 
> --- upstream0/drivers/scsi/libata-core.c	2006-03-14 10:31:01.000000000 +0800
> +++ exec_internal/drivers/scsi/libata-core.c	2006-03-14 10:55:24.000000000 +0800
> @@ -962,6 +962,8 @@ ata_exec_internal(struct ata_port *ap, s
>  	spin_unlock_irqrestore(&ap->host_set->lock, flags);
>  
>  	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
> +		ata_port_flush_task(ap);
> +
>  		spin_lock_irqsave(&ap->host_set->lock, flags);
>  
>  		/* We're racing with irq here.  If we lose, the
> 

Yes, we certainly need this. The irq handling isn't really correct 
either as irq handlers don't clear interrupt conditions on spurious 
interrupts. I hope/plan to address this during EH work.

Anyways, ACK.

Thanks.

-- 
tejun
