From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] rate-limit libata-scsi status/error message
Date: Sat, 18 Feb 2006 09:13:04 -0500
Message-ID: <43F72B70.5040107@rtr.ca>
References: <20060217213733.36040150.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:50624 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751280AbWBRONG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Feb 2006 09:13:06 -0500
In-Reply-To: <20060217213733.36040150.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, jgarzik <jgarzik@pobox.com>

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Rate-limit a translated ATA status/error message.
> I have a kernel log that is 2/3 full of these messages
> due to a CD/DVD drive being empty.
...
> -	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
> -	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
> -	       *sk, *asc, *ascq);
> +	if (printk_ratelimit())
> +		printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
> +			"SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n",
> +			id, drv_stat, drv_err, *sk, *asc, *ascq);

That message shouldn't even be enabled for non DEBUG cases.
I suspect Jeff will remove it for 2.6.17..

-ml
