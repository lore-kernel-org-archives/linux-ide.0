From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/2] libata: Fix NULL pointer of scsi_host in ata_port
Date: Wed, 23 Jul 2014 19:03:47 +1000
Message-ID: <53CF7A73.8010402@ozlabs.ru>
References: <1406040688-1762-1-git-send-email-qiudayu@linux.vnet.ibm.com> <53CE7C29.6050908@linux.vnet.ibm.com> <CAEuXFExJAq5hpYe8R_De7hOtGN1Jrx6HCQt0tQBAKnDTKEpaBA@mail.gmail.com> <20140722201109.GN13851@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54508 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbaGWJD6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2014 05:03:58 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so1338382pad.38
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2014 02:03:58 -0700 (PDT)
In-Reply-To: <20140722201109.GN13851@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, wenxiong@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, zhenghch@cn.ibm.com, haokexin@gmail.com

On 07/23/2014 06:11 AM, Tejun Heo wrote:
> Hello,
> 
> Can you please test the following patch?

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

on POWER8 + IBM IPR SCSI.




> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d19c37a7..773f4e6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4798,9 +4798,8 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>  static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
>  {
>  	struct ata_queued_cmd *qc = NULL;
> -	unsigned int i, tag, max_queue;
> -
> -	max_queue = ap->scsi_host->can_queue;
> +	unsigned int max_queue = ap->host->n_tags;
> +	unsigned int i, tag;
>  
>  	/* no command while frozen */
>  	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> @@ -6094,6 +6093,7 @@ void ata_host_init(struct ata_host *host, struct device *dev,
>  {
>  	spin_lock_init(&host->lock);
>  	mutex_init(&host->eh_mutex);
> +	host->n_tags = ATA_MAX_QUEUE;
>  	host->dev = dev;
>  	host->ops = ops;
>  }
> @@ -6179,11 +6179,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
>  	 * The max queue supported by hardware must not be greater than
>  	 * ATA_MAX_QUEUE.
>  	 */
> -	if (sht->can_queue > ATA_MAX_QUEUE) {
> -		dev_err(host->dev, "BUG: the hardware max queue is too large\n");
> -		WARN_ON(1);
> -		return -EINVAL;
> -	}
> +	host->n_tags = clamp(sht->can_queue, 1, ATA_MAX_QUEUE);
>  
>  	/* host must have been started */
>  	if (!(host->flags & ATA_HOST_STARTED)) {
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5ab4e3a..92abb49 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -593,6 +593,7 @@ struct ata_host {
>  	struct device 		*dev;
>  	void __iomem * const	*iomap;
>  	unsigned int		n_ports;
> +	unsigned int		n_tags;			/* nr of NCQ tags */
>  	void			*private_data;
>  	struct ata_port_operations *ops;
>  	unsigned long		flags;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Alexey
