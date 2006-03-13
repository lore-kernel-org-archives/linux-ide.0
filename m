From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: clean up IDENTIFY printing
Date: Mon, 13 Mar 2006 00:52:23 -0500
Message-ID: <44150897.1060602@garzik.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org> <20060313053350.GD29870@htj.dyndns.org> <20060313054807.GA24419@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932321AbWCMFwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 00:52:25 -0500
In-Reply-To: <20060313054807.GA24419@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> @@ -1120,12 +1114,6 @@ static int ata_dev_read_id(struct ata_po
>  
>  	swap_buf_le16(id, ATA_ID_WORDS);
>  
> -	/* print device capabilities */
> -	printk(KERN_DEBUG "ata%u: dev %u cfg "
> -	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
> -	       ap->id, dev->devno,
> -	       id[49], id[82], id[83], id[84], id[85], id[86], id[87], id[88]);
> -
>  	/* sanity check */
>  	if ((class == ATA_DEV_ATA) != ata_id_is_ata(id)) {
>  		rc = -EINVAL;
> @@ -1204,6 +1192,10 @@ static int ata_dev_configure(struct ata_
>  
>  	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
>  
> +	if (print_info)
> +		ata_dump_id(dev->id, KERN_DEBUG, "ata%u: dev %u cfg ",
> +			    ap->id, dev->devno);
> +

Also, the use of vscnprintf() feels like overengineering.  How many 
places really need to print out this stuff?  Just one?

	Jeff


