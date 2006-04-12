From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Wed, 12 Apr 2006 17:46:15 -0400
Message-ID: <443D7527.6050805@garzik.org>
References: <200604111915.45564.b.jacques@planet.nl> <200604122110.51723.b.jacques@planet.nl> <443D5424.1010008@garzik.org> <200604122259.05546.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31156 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932324AbWDLVqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 17:46:18 -0400
In-Reply-To: <200604122259.05546.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: linux-ide@vger.kernel.org

Bastiaan Jacques wrote:

Thanks, a couple remaining minor nits:


> --- drivers/scsi/ahci.c.orig	2006-04-11 18:58:32.000000000 +0200
> +++ drivers/scsi/ahci.c	2006-04-12 22:45:37.000000000 +0200
> @@ -73,6 +73,7 @@ enum {
>  	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
>  
>  	board_ahci		= 0,
> +	board_via_vt8251_ahci   = 1,

too long, and puts ahci at the end.

suggest board_ahci_vt8251.


>  	/* global controller registers */
>  	HOST_CAP		= 0x00, /* host capabilities */
> @@ -153,6 +154,9 @@ enum {
>  
>  	/* hpriv->flags bits */
>  	AHCI_FLAG_MSI		= (1 << 0),
> +
> +	/* ap->flags bits */
> +	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
>  };
>  
>  struct ahci_cmd_hdr {
> @@ -256,6 +260,16 @@ static const struct ata_port_info ahci_p
>  		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
>  		.port_ops	= &ahci_ops,
>  	},
> +	/* board_via_vt8251_ahci */
> +	{
> +		.sht		= &ahci_sht,
> +		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
> +				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> +				  AHCI_FLAG_RESET_NEEDS_CLO,
> +		.pio_mask	= 0x03, /* pio3-4 */

pio mask should be the same as the previous entry (0x1f).

Never trust vendor patches, they are often patched against ancient 
libata versions.


> +		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
> +		.port_ops	= &ahci_ops,
> +	},
>  };
>  
>  static const struct pci_device_id ahci_pci_tbl[] = {
> @@ -297,6 +311,8 @@ static const struct pci_device_id ahci_p
>  	  board_ahci }, /* ATI SB600 non-raid */
>  	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ATI SB600 raid */
> +	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_via_vt8251_ahci }, /* VT8251 */
>  	{ }	/* terminate list */
>  };
>  
> @@ -535,9 +551,27 @@ static int ahci_poll_register(void __iom
>  	return -1;
>  }
>  
> -static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
> +static int ahci_clo(struct ata_port *ap)
>  {
> +	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>  	struct ahci_host_priv *hpriv = ap->host_set->private_data;
> +	u32 tmp;
> +
> +	if (!(hpriv->cap & HOST_CAP_CLO))
> +		return -EOPNOTSUPP;
> +
> +	tmp = readl(port_mmio + PORT_CMD);
> +	tmp |= PORT_CMD_CLO;
> +	writel(tmp, port_mmio + PORT_CMD);
> +
> +	if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0, 1, 500))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
> +{
>  	struct ahci_port_priv *pp = ap->private_data;
>  	void __iomem *mmio = ap->host_set->mmio_base;
>  	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
> @@ -565,23 +599,13 @@ static int ahci_softreset(struct ata_por
>  	/* check BUSY/DRQ, perform Command List Override if necessary */
>  	ahci_tf_read(ap, &tf);
>  	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
> -		u32 tmp;
> +		rc = ahci_clo(ap);
>  
> -		if (!(hpriv->cap & HOST_CAP_CLO)) {
> -			rc = -EIO;
> -			reason = "port busy but no CLO";
> +		if (rc == -EOPNOTSUPP) {
> +			reason = "port busy but CLO unavailable";
>  			goto fail_restart;
> -		}
> -
> -		tmp = readl(port_mmio + PORT_CMD);
> -		tmp |= PORT_CMD_CLO;
> -		writel(tmp, port_mmio + PORT_CMD);
> -		readl(port_mmio + PORT_CMD); /* flush */
> -
> -		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
> -				       1, 500)) {
> -			rc = -EIO;
> -			reason = "CLO failed";
> +		} else if (rc == -EIO) {
> +			reason = "port busy but CLO failed";
>  			goto fail_restart;
>  		}
>  	}
> @@ -695,6 +719,12 @@ static void ahci_postreset(struct ata_po
>  
>  static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
>  {
> +	if (ap->flags & AHCI_FLAG_RESET_NEEDS_CLO &&

Please add parens for easy reading

> +	    ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY) {

likewise

	Jeff


