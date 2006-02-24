From: Jon K Hellan <hellan@acm.org>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Fri, 24 Feb 2006 08:08:40 +0100
Message-ID: <1140764920.15855.9.camel@localhost>
References: <loom.20060222T182150-518@post.gmane.org>
	 <43FD18F5.20002@gmail.com> <1140677987.11943.16.camel@localhost>
	 <20060223071921.GA24592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tyholt.uninett.no ([158.38.60.10]:64435 "EHLO tyholt.uninett.no")
	by vger.kernel.org with ESMTP id S1750769AbWBXHJB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 02:09:01 -0500
In-Reply-To: <20060223071921.GA24592@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On Thu, 2006-02-23 at 16:19 +0900, Tejun Heo wrote:

> Can you try the following patch?  It's a kind of long shot.

Long shot? Seems to work. I didn't see any lockups during the 12 hours I
tested. The bug normally shows up in less than 1 hour. Out of curiosity,
what does the patch do?

Regards

Jon
>   I just
> want to make sure.  And even if it doesn't work, it wouldn't do any
> harm.
> 
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index e14ed4e..2f71924 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -215,12 +215,13 @@ static const struct {
>  	unsigned long scr;	/* SATA control register block */
>  	unsigned long sien;	/* SATA Interrupt Enable register */
>  	unsigned long xfer_mode;/* data transfer mode register */
> +	unsigned long sfis_cfg;	/* SATA FIS reception config register */
>  } sil_port[] = {
>  	/* port 0 ... */
> -	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
> -	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
> -	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
> -	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
> +	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4, 0x14c },
> +	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4, 0x1cc },
> +	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4, 0x34c },
> +	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4, 0x3cc },
>  	/* ... port 3 */
>  };
>  
> @@ -372,7 +373,7 @@ static int sil_init_one (struct pci_dev 
>  	unsigned long base;
>  	void __iomem *mmio_base;
>  	int rc;
> -	unsigned int i;
> +	unsigned int i, cnt;
>  	int pci_dev_busy = 0;
>  	u32 tmp, irq_mask;
>  	u8 cls;
> @@ -466,11 +467,23 @@ static int sil_init_one (struct pci_dev 
>  		if ((tmp & SIL_INTR_STEERING) == 0)
>  			writel(tmp | SIL_INTR_STEERING,
>  			       mmio_base + SIL_IDE2_BMDMA);
> -
>  	} else {
>  		irq_mask = SIL_MASK_2PORT;
>  	}
>  
> +	/* R_ERR on DMA activate FIS errata workaround */
> +	for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
> +		tmp = readl(mmio_base + sil_port[i].sfis_cfg);
> +		if ((tmp & 0x3) != 0x01)
> +			continue;
> +		if (!cnt)
> +			dev_printk(KERN_INFO, &pdev->dev,
> +				   "Applying R_ERR on DMA activate "
> +				   "FIS errata fix\n");
> +		writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
> +		cnt++;
> +	}
> +
>  	/* make sure IDE0/1/2/3 interrupts are not masked */
>  	tmp = readl(mmio_base + SIL_SYSCFG);
>  	if (tmp & irq_mask) {

