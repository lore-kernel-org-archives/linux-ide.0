From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/5] sil24:  make error_intr less verbose
Date: Wed, 16 Nov 2005 07:38:52 -0500
Message-ID: <437B285C.8020809@pobox.com>
References: <20051116080935.GE22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36787 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750740AbVKPMiz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 07:38:55 -0500
In-Reply-To: <20051116080935.GE22807@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> sil24_error_intr is too verbose.  Shut it up.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Index: work/drivers/scsi/sata_sil24.c
> ===================================================================
> --- work.orig/drivers/scsi/sata_sil24.c	2005-11-16 17:05:19.000000000 +0900
> +++ work/drivers/scsi/sata_sil24.c	2005-11-16 17:08:05.000000000 +0900
> @@ -678,9 +678,9 @@ static void sil24_error_intr(struct ata_
>  	if (serror)
>  		writel(serror, port + PORT_SERROR);
>  
> -	printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
> -	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
> -	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
> +	DPRINTK("ata%u: error interrupt on port%d\n"
> +		"  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
> +		ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);

Mild NAK.

I am grappling with this on AHCI too :)  This is because ATA_ERR is much 
more common on ATAPI, yes?

My preferred change would be

	if ((class != ATA_DEV_ATAPI) ||
	    (sil24_cmd_err > PORT_CERR_SDB))
		printk()

so that truly uncommon errors are always printed, but users logs are not 
spammed.

Another option is to do

	if (ata_ratelimit())
		printk()

Regards,

	Jeff


