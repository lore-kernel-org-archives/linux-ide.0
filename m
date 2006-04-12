From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Wed, 12 Apr 2006 15:25:24 -0400
Message-ID: <443D5424.1010008@garzik.org>
References: <200604111915.45564.b.jacques@planet.nl> <20060412004232.GA31115@htj.dyndns.org> <200604122110.51723.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26288 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932095AbWDLTZ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 15:25:29 -0400
In-Reply-To: <200604122110.51723.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Bastiaan Jacques wrote:
> Jeff: when everybody is happy with my patch, I'll resubmit it to this list in
> accordance with the guidelines you linked to (if that's okay with you).

Looking pretty good so far, minor comments inline...


> --- drivers/scsi/ahci.c.orig	2006-04-11 18:58:32.000000000 +0200
> +++ drivers/scsi/ahci.c	2006-04-12 20:53:23.000000000 +0200
> @@ -152,7 +152,8 @@
>  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
>  
>  	/* hpriv->flags bits */
> -	AHCI_FLAG_MSI		= (1 << 0),
> +	AHCI_FLAG_MSI			= (1 << 0),
> +	AHCI_FLAG_RESET_NEEDS_CLO 	= (1 << 1),
>  };
>  
>  struct ahci_cmd_hdr {
> @@ -297,6 +298,8 @@
>  	  board_ahci }, /* ATI SB600 non-raid */
>  	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ATI SB600 raid */
> +	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* VT8251 */
>  	{ }	/* terminate list */
>  };
>  
> @@ -535,9 +538,28 @@
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
> +	readl(port_mmio + PORT_CMD); /* flush */

ahci_poll_register() should take care of flush for you.


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
> @@ -565,23 +587,12 @@
>  	/* check BUSY/DRQ, perform Command List Override if necessary */
>  	ahci_tf_read(ap, &tf);
>  	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
> -		u32 tmp;
> +		if ((rc = ahci_clo(ap))) {

Don't combine an assignment and an 'if' test in the same line.

This style of statement+if is a constant source of bugs, because it is 
much more difficult for the human eye to notice that two statements are 
present rather than one, and it takes longer for the human brain to 
figure out whether the original author intended to use '==' rather than '='.


> +			if (rc & -EOPNOTSUPP)

rc isn't a bitmask, the test should be "rc == -EOPNOTSUPP"


> +				reason = "port busy but CLO unavailable";
> +			else
> +				reason = "port busy but CLO failed";
>  
> -		if (!(hpriv->cap & HOST_CAP_CLO)) {
> -			rc = -EIO;
> -			reason = "port busy but no CLO";
> -			goto fail_restart;
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
>  			goto fail_restart;
>  		}
>  	}
> @@ -695,6 +706,15 @@
>  
>  static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
>  {
> +	struct ahci_host_priv *hpriv = ap->host_set->private_data;
> +
> +	if (hpriv->flags & AHCI_FLAG_RESET_NEEDS_CLO) {
> +		if (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY) {

combine these two 'if' statements into a single 'if' statement with '&&'


> +			/* ATA_BUSY hasn't cleared, so send a CLO */
> +			ahci_clo(ap);
> +		}
> +	}
> +
>  	return ata_drive_probe_reset(ap, ata_std_probeinit,
>  				     ahci_softreset, ahci_hardreset,
>  				     ahci_postreset, classes);
> @@ -1266,6 +1286,10 @@
>  	if (pdev->vendor == 0x197b)
>  		pci_write_config_byte(pdev, 0x41, 0xa1);
>  
> +	/* VIA VT8251-specific fixup: CLO before reset */
> +	if (pdev->device == 0x3349)
> +		hpriv->flags |= AHCI_FLAG_RESET_NEEDS_CLO;

This is flawed because it doesn't check the PCI vendor ID.

In any case, the proper way to do this is:

1) create board_ahci_via next to board_ahci

2) duplicate entry #0 (board_ahci) of ahci_port_info[] as entry #1 
(board_ahci_via).

3) Add AHCI_FLAG_RESET_NEEDS_CLO to entry #1.

4) test ap->flags & AHCI_FLAG_RESET_NEEDS_CLO

5) when adding VIA PCI device to ahci_pci_tbl[], the final entry should 
be 'board_ahci_via'

You could do it has an hpriv->flag, but its easier and more standard to 
pass chip-specific flags in the manner I have described.

	Jeff


