From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/5] libata: make ata_dev_knobble() per-device
Date: Thu, 26 Jan 2006 23:33:36 -0500
Message-ID: <43D9A2A0.2080801@pobox.com>
References: <11382890432663-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28858 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932223AbWA0Edj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:33:39 -0500
In-Reply-To: <11382890432663-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> ata_dev_knobble() unconditionally used the first device of the port to
> determine whether a device is bridged or not.  This causes bridge
> limit to be incorrectly applied or unapplied for hosts with slave
> devices (e.g. ata_piix).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> 315dd661a46e94e44c6f9481465bac93f8ea84ef
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index f6511bd..c92f96f 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1483,9 +1483,10 @@ err_out:
>  }
>  
>  
> -static inline u8 ata_dev_knobble(const struct ata_port *ap)
> +static inline u8 ata_dev_knobble(const struct ata_port *ap,
> +				 struct ata_device *dev)
>  {
> -	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
> +	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
>  }
>  
>  /**
> @@ -1500,9 +1501,9 @@ static inline u8 ata_dev_knobble(const s
>  void ata_dev_config(struct ata_port *ap, unsigned int i)
>  {
>  	/* limit bridge transfers to udma5, 200 sectors */
> -	if (ata_dev_knobble(ap)) {
> +	if (ata_dev_knobble(ap, &ap->device[i])) {
>  		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
> -			ap->id, ap->device->devno);
> +		       ap->id, i);

patch is OK, but at the same time you should

1) remove the inline, its out of fashion

2) make ata_dev_knobble() return [machine] int rather than u8.  It's 
really just a bool.

BTW, if you were bored one day, it would be nice to figure out how to 
use gcc's [and C99's] bool type for stuff like this.

