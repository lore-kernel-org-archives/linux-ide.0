From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] libata: Add multi-count transfer debugging
Date: Wed, 06 May 2009 23:02:47 -0600
Message-ID: <4A026B77.2000801@gmail.com>
References: <4A01946E.1020300@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:18843 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbZEGFCv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 May 2009 01:02:51 -0400
Received: by yx-out-2324.google.com with SMTP id 3so341154yxj.1
        for <linux-ide@vger.kernel.org>; Wed, 06 May 2009 22:02:50 -0700 (PDT)
In-Reply-To: <4A01946E.1020300@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Ward Vandewege <ward@gnu.org>

Carl-Daniel Hailfinger wrote:
> On my Asus M2A-VM (SB600) board, the SATA disks use multi-count
> transfers only with some BIOS variants.
> Dumping the relevant config words helps debugging a lot.
> 
> Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
> 
> --- a/drivers/ata/libata-core.c	2009-05-06 14:24:32.000000000 +0200
> +++ b/drivers/ata/libata-core.c	2009-05-06 15:27:06.000000000 +0200
> @@ -2390,11 +2390,11 @@
>  	/* print device capabilities */
>  	if (ata_msg_probe(ap))
>  		ata_dev_printk(dev, KERN_DEBUG,
> -			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
> -			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
> +			       "%s: cfg 47:%04x 49:%04x 59:%04x 82:%04x 83:%04x"
> +			       " 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
>  			       __func__,
> -			       id[49], id[82], id[83], id[84],
> -			       id[85], id[86], id[87], id[88]);
> +			       id[47], id[49], id[59], id[82], id[83],
> +			       id[84], id[85], id[86], id[87], id[88]);
>  
>  	/* initialize to-be-configured parameters */
>  	dev->flags &= ~ATA_DFLAG_CFG_MASK;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Keep in mind that multi-count transfers are only meaningful for PIO 
read/write commands (it controls the number of sectors transferred for 
each DRQ assertion), which would only be used if the device didn't 
support DMA - unlikely for SATA..
