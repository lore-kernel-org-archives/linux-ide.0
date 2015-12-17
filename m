From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Thu, 17 Dec 2015 16:58:14 +0200
Message-ID: <1450364294.30729.134.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18912 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966244AbbLQO6U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Dec 2015 09:58:20 -0500
In-Reply-To: <1450221935-6034-1-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-12-15 at 23:25 +0000, Mans Rullgard wrote:
> Currently this driver only works with a DesignWare DMA engine which
> it
> registers manually using the second "reg" address range and interrupt
> number from the DT node.
>=20
> This patch makes the driver instead use the "dmas" property if
> present,
> otherwise optionally falling back on the old way so existing device
> trees can continue to work.
>=20
> With this change, there is no longer any reason to depend on the
> 460EX
> machine type so drop that from Kconfig.

Looks good for me (from dw_dmac usage prospective).

>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> =C2=A0drivers/ata/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A010 ++-
> =C2=A0drivers/ata/sata_dwc_460ex.c | 192 +++++++++++++++++++++++++++-=
---
> ------------
> =C2=A02 files changed, 131 insertions(+), 71 deletions(-)
>=20
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 3fc2a56..193c673 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -296,14 +296,20 @@ config ATA_PIIX
> =C2=A0
> =C2=A0config SATA_DWC
> =C2=A0	tristate "DesignWare Cores SATA support"
> -	depends on 460EX
> -	select DW_DMAC
> =C2=A0	help
> =C2=A0	=C2=A0=C2=A0This option enables support for the on-chip SATA
> controller of the
> =C2=A0	=C2=A0=C2=A0AppliedMicro processor 460EX.
> =C2=A0
> =C2=A0	=C2=A0=C2=A0If unsure, say N.
> =C2=A0
> +config SATA_DWC_OLD_DMA
> +	bool "Support old device trees"
> +	depends on SATA_DWC && 460EX
> +	select DW_DMAC
> +	help
> +	=C2=A0=C2=A0This option enables support for old device trees withou=
t
> the
> +	=C2=A0=C2=A0"dmas" property.
> +
> =C2=A0config SATA_DWC_DEBUG
> =C2=A0	bool "Debugging driver version"
> =C2=A0	depends on SATA_DWC
> diff --git a/drivers/ata/sata_dwc_460ex.c
> b/drivers/ata/sata_dwc_460ex.c
> index 9020349..9985749 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -30,6 +30,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/device.h>
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/of_address.h>
> =C2=A0#include <linux/of_irq.h>
> =C2=A0#include <linux/of_platform.h>
> @@ -42,10 +43,6 @@
> =C2=A0#include <scsi/scsi_host.h>
> =C2=A0#include <scsi/scsi_cmnd.h>
> =C2=A0
> -/* Supported DMA engine drivers */
> -#include <linux/platform_data/dma-dw.h>
> -#include <linux/dma/dw.h>
> -
> =C2=A0/* These two are defined in "libata.h" */
> =C2=A0#undef	DRV_NAME
> =C2=A0#undef	DRV_VERSION
> @@ -148,7 +145,9 @@ struct sata_dwc_device {
> =C2=A0	struct ata_host		*host;
> =C2=A0	u8 __iomem		*reg_base;
> =C2=A0	struct sata_dwc_regs	*sata_dwc_regs;	/* DW
> Synopsys SATA specific */
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> =C2=A0	struct dw_dma_chip	*dma;
> +#endif
> =C2=A0};
> =C2=A0
> =C2=A0#define SATA_DWC_QCMD_MAX	32
> @@ -159,7 +158,6 @@ struct sata_dwc_device_port {
> =C2=A0	int			dma_pending[SATA_DWC_QCMD_MAX];
> =C2=A0
> =C2=A0	/* DMA info */
> -	struct dw_dma_slave		*dws;
> =C2=A0	struct dma_chan			*chan;
> =C2=A0	struct dma_async_tx_descriptor	*desc[SATA_DWC_QCMD_MA
> X];
> =C2=A0	u32				dma_interrupt_count;
> @@ -198,13 +196,6 @@ struct sata_dwc_host_priv {
> =C2=A0
> =C2=A0static struct sata_dwc_host_priv host_pvt;
> =C2=A0
> -static struct dw_dma_slave sata_dwc_dma_dws =3D {
> -	.src_id =3D 0,
> -	.dst_id =3D 0,
> -	.src_master =3D 0,
> -	.dst_master =3D 1,
> -};
> -
> =C2=A0/*
> =C2=A0 * Prototypes
> =C2=A0 */
> @@ -215,6 +206,90 @@ static void sata_dwc_dma_xfer_complete(struct
> ata_port *ap, u32 check_status);
> =C2=A0static void sata_dwc_port_stop(struct ata_port *ap);
> =C2=A0static void sata_dwc_clear_dmacr(struct sata_dwc_device_port
> *hsdevp, u8 tag);
> =C2=A0
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> +
> +#include <linux/platform_data/dma-dw.h>
> +#include <linux/dma/dw.h>
> +
> +static struct dw_dma_slave sata_dwc_dma_dws =3D {
> +	.src_id =3D 0,
> +	.dst_id =3D 0,
> +	.src_master =3D 0,
> +	.dst_master =3D 1,
> +};
> +
> +static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
> +{
> +	struct dw_dma_slave *dws =3D &sata_dwc_dma_dws;
> +
> +	if (dws->dma_dev !=3D chan->device->dev)
> +		return false;
> +
> +	chan->private =3D dws;
> +	return true;
> +}
> +
> +static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port
> *hsdevp)
> +{
> +	struct sata_dwc_device *hsdev =3D hsdevp->hsdev;
> +	struct dw_dma_slave *dws =3D &sata_dwc_dma_dws;
> +	dma_cap_mask_t mask;
> +
> +	dws->dma_dev =3D hsdev->dev;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	/* Acquire DMA channel */
> +	hsdevp->chan =3D dma_request_channel(mask,
> sata_dwc_dma_filter, hsdevp);
> +	if (!hsdevp->chan) {
> +		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
> +			=C2=A0__func__);
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sata_dwc_dma_init_old(struct platform_device *pdev,
> +				=C2=A0struct sata_dwc_device *hsdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int err;
> +
> +	hsdev->dma =3D devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma),
> GFP_KERNEL);
> +	if (!hsdev->dma)
> +		return -ENOMEM;
> +
> +	hsdev->dma->dev =3D &pdev->dev;
> +
> +	/* Get SATA DMA interrupt number */
> +	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
> +	if (hsdev->dma->irq =3D=3D NO_IRQ) {
> +		dev_err(&pdev->dev, "no SATA DMA irq\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Get physical SATA DMA register base address */
> +	hsdev->dma->regs =3D of_iomap(np, 1);
> +	if (!hsdev->dma->regs) {
> +		dev_err(&pdev->dev,
> +			"ioremap failed for AHBDMA register
> address\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Initialize AHB DMAC */
> +	err =3D dw_dma_probe(hsdev->dma, NULL);
> +	if (err) {
> +		iounmap(hsdev->dma->regs);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +#endif
> +
> =C2=A0static const char *get_prot_descript(u8 protocol)
> =C2=A0{
> =C2=A0	switch ((enum ata_tf_protocols)protocol) {
> @@ -783,18 +858,6 @@ static void sata_dwc_enable_interrupts(struct
> sata_dwc_device *hsdev)
> =C2=A0		in_le32(&hsdev->sata_dwc_regs->errmr));
> =C2=A0}
> =C2=A0
> -static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
> -{
> -	struct sata_dwc_device_port *hsdevp =3D param;
> -	struct dw_dma_slave *dws =3D hsdevp->dws;
> -
> -	if (dws->dma_dev !=3D chan->device->dev)
> -		return false;
> -
> -	chan->private =3D dws;
> -	return true;
> -}
> -
> =C2=A0static void sata_dwc_setup_port(struct ata_ioports *port, unsig=
ned
> long base)
> =C2=A0{
> =C2=A0	port->cmd_addr =3D (void __iomem *)base + 0x00;
> @@ -817,6 +880,26 @@ static void sata_dwc_setup_port(struct
> ata_ioports *port, unsigned long base)
> =C2=A0	port->ctl_addr =3D (void __iomem *)base + 0x20;
> =C2=A0}
> =C2=A0
> +static int sata_dwc_dma_get_channel(struct sata_dwc_device_port
> *hsdevp)
> +{
> +	struct sata_dwc_device *hsdev =3D hsdevp->hsdev;
> +	struct device *dev =3D hsdev->dev;
> +
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> +	if (!of_find_property(dev->of_node, "dmas", NULL))
> +		return sata_dwc_dma_get_channel_old(hsdevp);
> +#endif
> +
> +	hsdevp->chan =3D dma_request_slave_channel(dev, "sata-dma");
> +	if (IS_ERR(hsdevp->chan)) {
> +		dev_err(dev, "failed to allocate dma channel:
> %ld\n",
> +			PTR_ERR(hsdevp->chan));
> +		return PTR_ERR(hsdevp->chan);
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * Function : sata_dwc_port_start
> =C2=A0 * arguments : struct ata_ioports *port
> @@ -829,7 +912,6 @@ static int sata_dwc_port_start(struct ata_port
> *ap)
> =C2=A0	struct sata_dwc_device *hsdev;
> =C2=A0	struct sata_dwc_device_port *hsdevp =3D NULL;
> =C2=A0	struct device *pdev;
> -	dma_cap_mask_t mask;
> =C2=A0	int i;
> =C2=A0
> =C2=A0	hsdev =3D HSDEV_FROM_AP(ap);
> @@ -853,20 +935,9 @@ static int sata_dwc_port_start(struct ata_port
> *ap)
> =C2=A0	}
> =C2=A0	hsdevp->hsdev =3D hsdev;
> =C2=A0
> -	hsdevp->dws =3D &sata_dwc_dma_dws;
> -	hsdevp->dws->dma_dev =3D hsdev->dev;
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	/* Acquire DMA channel */
> -	hsdevp->chan =3D dma_request_channel(mask,
> sata_dwc_dma_filter, hsdevp);
> -	if (!hsdevp->chan) {
> -		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
> -			=C2=A0__func__);
> -		err =3D -EAGAIN;
> +	err =3D sata_dwc_dma_get_channel(hsdevp);
> +	if (err)
> =C2=A0		goto CLEANUP_ALLOC;
> -	}
> =C2=A0
> =C2=A0	for (i =3D 0; i < SATA_DWC_QCMD_MAX; i++)
> =C2=A0		hsdevp->cmd_issued[i] =3D SATA_DWC_CMD_ISSUED_NOT;
> @@ -1225,33 +1296,9 @@ static int sata_dwc_probe(struct
> platform_device *ofdev)
> =C2=A0	dev_notice(&ofdev->dev, "id %d, controller version
> %c.%c%c\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0idr, ver[0], ver[1], ver[2]);
> =C2=A0
> -	/* Get SATA DMA interrupt number */
> -	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
> -	if (hsdev->dma->irq =3D=3D NO_IRQ) {
> -		dev_err(&ofdev->dev, "no SATA DMA irq\n");
> -		err =3D -ENODEV;
> -		goto error_iomap;
> -	}
> -
> -	/* Get physical SATA DMA register base address */
> -	hsdev->dma->regs =3D of_iomap(np, 1);
> -	if (!hsdev->dma->regs) {
> -		dev_err(&ofdev->dev,
> -			"ioremap failed for AHBDMA register
> address\n");
> -		err =3D -ENODEV;
> -		goto error_iomap;
> -	}
> -
> =C2=A0	/* Save dev for later use in dev_xxx() routines */
> =C2=A0	hsdev->dev =3D &ofdev->dev;
> =C2=A0
> -	hsdev->dma->dev =3D &ofdev->dev;
> -
> -	/* Initialize AHB DMAC */
> -	err =3D dw_dma_probe(hsdev->dma, NULL);
> -	if (err)
> -		goto error_dma_iomap;
> -
> =C2=A0	/* Enable SATA Interrupts */
> =C2=A0	sata_dwc_enable_interrupts(hsdev);
> =C2=A0
> @@ -1263,6 +1310,14 @@ static int sata_dwc_probe(struct
> platform_device *ofdev)
> =C2=A0		goto error_out;
> =C2=A0	}
> =C2=A0
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> +	if (!of_find_property(np, "dmas", NULL)) {
> +		err =3D sata_dwc_dma_init_old(ofdev, hsdev);
> +		if (err)
> +			goto error_out;
> +	}
> +#endif
> +
> =C2=A0	/*
> =C2=A0	=C2=A0* Now, register with libATA core, this will also initiat=
e
> the
> =C2=A0	=C2=A0* device discovery process, invoking our port_start()
> handler &
> @@ -1276,11 +1331,6 @@ static int sata_dwc_probe(struct
> platform_device *ofdev)
> =C2=A0	return 0;
> =C2=A0
> =C2=A0error_out:
> -	/* Free SATA DMA resources */
> -	dw_dma_remove(hsdev->dma);
> -error_dma_iomap:
> -	iounmap(hsdev->dma->regs);
> -error_iomap:
> =C2=A0	iounmap(base);
> =C2=A0	return err;
> =C2=A0}
> @@ -1293,10 +1343,14 @@ static int sata_dwc_remove(struct
> platform_device *ofdev)
> =C2=A0
> =C2=A0	ata_host_detach(host);
> =C2=A0
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> =C2=A0	/* Free SATA DMA resources */
> -	dw_dma_remove(hsdev->dma);
> +	if (hsdev->dma) {
> +		dw_dma_remove(hsdev->dma);
> +		iounmap(hsdev->dma->regs);
> +	}
> +#endif
> =C2=A0
> -	iounmap(hsdev->dma->regs);
> =C2=A0	iounmap(hsdev->reg_base);
> =C2=A0	dev_dbg(&ofdev->dev, "done\n");
> =C2=A0	return 0;

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

