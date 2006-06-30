From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: make both legacy ports share one host_set
 , take #2
Date: Fri, 30 Jun 2006 12:15:28 -0400
Message-ID: <44A54E20.9050401@pobox.com>
References: <44977C93.7090001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45754 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932767AbWF3QPe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 12:15:34 -0400
In-Reply-To: <44977C93.7090001@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Unicorn Chang <uchang@tw.ibm.com>
Cc: linux-ide@vger.kernel.org, "Tejun Heo ]" <htejun@gmail.com>

Unicorn Chang wrote:
> @@ -5336,11 +5383,21 @@ int ata_device_add(const struct ata_prob
>  				ap->ioaddr.cmd_addr,
>  				ap->ioaddr.ctl_addr,
>  				ap->ioaddr.bmdma_addr,
> -				ent->irq);
> +				irq);
>  
>  		ata_chk_status(ap);
>  		host_set->ops->irq_clear(ap);
>  		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
> +
> +		if (ap->ioaddr.irq){
> +			/* obtain nonshared per-port irq */
> +			rc = request_irq(irq, ent->port_ops->irq_handler, 0, DRV_NAME, ap);
> +			if (rc) {
> +				dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
> +						irq, rc);
> +				goto err_out;
> +			}
> +		}
>  		count++;
>  	}
>  
> @@ -5348,12 +5405,14 @@ int ata_device_add(const struct ata_prob
>  		goto err_free_ret;
>  
>  	/* obtain irq, that is shared between channels */
> -	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
> -			 DRV_NAME, host_set);
> -	if (rc) {
> -		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
> -			   ent->irq, rc);
> -		goto err_out;
> +	if (ent->irq){
> +		rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
> +				 DRV_NAME, host_set);
> +		if (rc) {
> +			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
> +				   ent->irq, rc);
> +			goto err_out;
> +		}
>  	}


I'm sorry, but any patch that adds additional request_irq() calls to
libata in this manner will be NAK'd.

The current location of request_irq() inside libata is a design mistake
on my part, and this sort of change compounds that mistake.

An improved control flow, which moves request_irq() from libata-core to
LLDD, might be:

* LLDD initializes the host controller, in driver.c (as it does today)
* LLDD, perhaps via bmdma helpers, makes certain that no pending
interrupt conditions exist (many LLDDs do this today)
* LLDD, perhaps via bmdma helpers, calls request_irq()
	- problem: need to pass it a useful pointer
	  -> move drivers to familiar model where LLDD allocs
	     host_set and ports, does <stuff>, then
	     registers host_set/ports with system
* LLDD proceeds to register itself with libata core

Overall, the current libata request_irq() design restricts us from doing
a better job with legacy ports (your case), and also prevents doing
advanced stuff with MSI-X and other approaching technologies.

	Jeff


