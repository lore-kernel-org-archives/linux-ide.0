From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/9] ahci.c conversion
Date: Fri, 30 Jun 2006 01:30:17 +0900
Message-ID: <44A40019.1090905@gmail.com>
References: <20060629160938.GC23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:33620 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750919AbWF2Q34 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:29:56 -0400
Received: by wr-out-0506.google.com with SMTP id 50so105053wri
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 09:29:55 -0700 (PDT)
In-Reply-To: <20060629160938.GC23122@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> This converts the relevant places of ahci.c to the new scheme.
> 
> Signed-off-by: <petkov@math.uni-muenster.de>
> 
> --- libata-dev/drivers/scsi/ahci.c.orig	2006-06-28 09:13:10.000000000 +0200
> +++ libata-dev/drivers/scsi/ahci.c	2006-06-29 17:29:06.000000000 +0200
> @@ -617,10 +617,10 @@ static int ahci_softreset(struct ata_por
>  	u8 *fis;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
>  
>  	if (ata_port_offline(ap)) {
> -		DPRINTK("PHY reports no device\n");
> +		ata_port_printk(ap, ATA_MSG_CMD, "PHY reports no device\n");

Not really CMD, I think it should be ATA_MSG_DEBUG.

<--snip-->
>  	if (ata_ratelimit())
> -		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
> +		ata_port_printk(ap, ATA_MSG_DRV, "spurious interrupt "
>  				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
>  				status, ap->active_tag, ap->sactive);

I don't really understand why it should be DRV not INFO.  Is this to 
discern between core and LLD messages?

-- 
tejun
