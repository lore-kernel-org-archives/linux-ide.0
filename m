From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED] ahci: add "em_buffer" attribute for AHCI hosts
Date: Sat, 10 Apr 2010 10:50:29 +0900
Message-ID: <4BBFD965.8020603@kernel.org>
References: <1268131075.2000.6.camel@harry-desktop>	 <1270539831.1963.29.camel@harry-desktop> <1270800011.1942.8.camel@harry-desktop> <4BBEFDEC.7020506@kernel.org> <1793EC4BDC456040AA0FC17136E1732B207127@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49415 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab0DJBrJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Apr 2010 21:47:09 -0400
In-Reply-To: <1793EC4BDC456040AA0FC17136E1732B207127@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhang, Harry" <Harry.Zhang@amd.com>
Cc: "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

> Add "em_buffer" attribute for SATA AHCI hosts to enable user access
> AHCI EM (enclosure management) buffer in user space if the host
> support EM.
> 
> AHCI driver should support SGPIO EM message. However the SATA/AHCI
> spec does no define the SGPIO message format filled in EM
> buffer. Different HW vendors may have different definitions. The
> mainly purpose of "em_buffer" attribute is to solve this issue by
> allowing HW vendors to provide user space SGPIO drivers and tools.

Yeap, the only way to deal with the SGPIO case seems to be to provide
a way for userland to directly generate and consume messages.

> @@ -931,18 +937,20 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * create message header - this is all zero except for
> -	 * the message size, which is 4 bytes.
> -	 */
> -	message[0] |= (4 << 8);
> +	if (ahci_em_messages & 0x01) {
> +		/*
> +		 * create message header - this is all zero except for
> +		 * the message size, which is 4 bytes.
> +		 */
> +		message[0] |= (4 << 8);

This isn't your fault but there can be multiple ahci controllers on
the system and controlling EM capability via a module parameter
doesn't really work.  There needs to be some mechanism to configure
this automatically.

> +static ssize_t ahci_em_buffer_store(struct ata_port *ap,
> +				    const char *buf, size_t size)
> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +	void __iomem *em_mmio = mmio + hpriv->em_loc;
> +	struct ahci_em_buf_msg *msg = (struct ahci_em_buf_msg *)buf;
> +	u32 em_ctl;
> +	unsigned long flags;
> +	int i, tmp;
> +
> +	/* check message validity */
> +	tmp = sizeof(struct ahci_em_buf_msg);
> +	if (size % 4 || size < tmp || size > tmp + msg->len * 4 ||
> +			msg->start + msg->len > hpriv->em_buf_sz / 4) {
> +		return -EINVAL;
> +	}

Please don't share data structure directly with userland this way.
The action of storing can indicate TM.  I don't think RST needs to be
exported to userland verbatim.  @start is unnecessary if the whole
message is written always and @len can be determined from the write
size.  IOW, simply writing the raw message should be enough.

Also, isn't it also necessary to implement 'read'?

> +static ssize_t
> +ata_scsi_em_buffer_store(struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +
> +	if (ap->ops->em_buffer_store && (ap->flags & ATA_FLAG_EM))
> +		return ap->ops->em_buffer_store(ap, buf, count);
> +	return -EINVAL;
> +}
> +DEVICE_ATTR(em_buffer, S_IWUSR, NULL, ata_scsi_em_buffer_store);
> +EXPORT_SYMBOL_GPL(dev_attr_em_buffer);

Let's just put it in libahci.c for now and move it to common part if
anything else ever requires SGPIO EM.

Thanks.

--
tejun
