From: Mark Lord <liml@rtr.ca>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Fri, 16 Mar 2007 17:17:19 -0400
Message-ID: <45FB095F.1020009@rtr.ca>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca> <45FAAA22.7060000@tw.ibm.com> <45FAB418.2070402@rtr.ca> <45FAD204.2060700@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:4145 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965949AbXCPVRW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 17:17:22 -0400
In-Reply-To: <45FAD204.2060700@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Albert Lee wrote:
>..
> Maybe we can wait a moment and give the slow ATAPI devices some time to set DRQ.
> Could you please try if the attached patch works, thanks.
> --
> albert
> 
> --- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-15 18:03:27.000000000 +0800
> +++ linux-2.6.20.3-mod2/drivers/ata/libata-core.c	2007-03-17 01:12:53.000000000 +0800
> @@ -4384,6 +4384,19 @@ fsm_start:
>  		 */
>  		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		/* wait for some slow ATAPI devices to set DRQ */
> +		if (unlikely((status & ATA_DRQ) == 0) &&
> +		    is_atapi_taskfile(&qc->tf)) {
> +			int max = 100;
> +
> +			do {
> +				udelay(10);
> +				status = ata_chk_status(ap);
> +				max--;
> +				ata_port_printk(ap, KERN_ERR, "wait for DRQ %d\n", 100-max);	
> +			} while (((status & ATA_DRQ) == 0) && (max > 0));
> +		}
> +
>  		/* check device status */
>  		if (unlikely((status & ATA_DRQ) == 0)) {
>  			/* handle BSY=0, DRQ=0 as error */
> 

I patched the above in, and it was NEVER hit.

-ml
