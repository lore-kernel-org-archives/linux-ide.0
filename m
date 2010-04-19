From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ahci: add "em_buffer" attribute for AHCI hosts
Date: Mon, 19 Apr 2010 13:57:28 +0900
Message-ID: <4BCBE2B8.4030004@kernel.org>
References: <1271647047.3518.7.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59847 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab0DSEx7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Apr 2010 00:53:59 -0400
In-Reply-To: <1271647047.3518.7.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Shane.Huang@amd.com

Hello,

On 04/19/2010 12:17 PM, Harry Zhang wrote:
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c44d112..8ca16f5 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1185,7 +1185,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  		/* set enclosure management message type */
>  		if (ap->flags & ATA_FLAG_EM)
> -			ap->em_message_type = ahci_em_messages;
> +			ap->em_message_type = hpriv->em_msg_type;
>  
>  
>  		/* disabled/not-implemented port */
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 733def2..6605b03 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -220,13 +220,16 @@ enum {
>  	ICH_MAP				= 0x90, /* ICH MAP register */
>  
>  	/* em constants */
> -	EM_MAX_SLOTS			= 8,
> -	EM_MAX_RETRY			= 5,
> +	EM_MAX_SLOTS		= 8,
> +	EM_MAX_RETRY		= 5,

Why change the indentation?

>  };
>  
>  struct ahci_cmd_hdr {
> @@ -282,9 +285,10 @@ struct ahci_host_priv {
>  	u32			saved_cap2;	/* saved initial cap2 */
>  	u32			saved_port_map;	/* saved initial port_map */
>  	u32 			em_loc; /* enclosure management location */
> +	u32			em_buf_sz;	/* EM buffer size in byte*/
> +	u32			em_msg_type;	/* EM message type */
>  };
>  
> -extern int ahci_em_messages;
>  extern int ahci_ignore_sss;

Please separate out em message enable control changes into a separate
patch.

> +static ssize_t ahci_read_em_buffer(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +	void __iomem *em_mmio = mmio + hpriv->em_loc;
> +	u32 em_ctl, msg;
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +
> +	em_ctl = readl(mmio + HOST_EM_CTL);
> +	if (!(ap->flags & ATA_FLAG_EM) || em_ctl & EM_CTL_XMT ||
> +					!(em_ctl & EM_CTL_MR)) {
> +		spin_unlock_irqrestore(ap->lock, flags);
> +		return -EINVAL;
> +	}

Wouldn't !MR be better represented by -EAGAIN?

> +	if (!(em_ctl & EM_CTL_SMB))
> +		em_mmio += hpriv->em_buf_sz;
> +
> +	for (i = 0; i < hpriv->em_buf_sz; i += 4) {
> +		msg = readl(em_mmio + i);
> +		buf[i] = msg & 0xff;
> +		buf[i + 1] = (msg >> 8) & 0xff;
> +		buf[i + 2] = (msg >> 16) & 0xff;
> +		buf[i + 3] = (msg >> 24) & 0xff;
> +	}

Maybe it would be a good idea to check em_buf_sz against PAGE_SIZE?
Hmmm... a question, does the standard define anything about endian?

Other than the above small points, things generally look good to me.
Implementing proper r/w blocking semantics would be nice but given
that ahci doesn't implement EM interrupts (right?), I think the
minimal implementation is okay.

Thanks.

-- 
tejun
