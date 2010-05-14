From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Fri, 14 May 2010 15:51:54 +0200
Message-ID: <201005141551.55066.marek.vasut@gmail.com>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:48110 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab0ENNxX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 09:53:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so304743fgg.1
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 06:53:22 -0700 (PDT)
In-Reply-To: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, radoslav.deak@voipac.com

Dne Po 10. kv=C4=9Btna 2010 05:02:05 Marek Vasut napsal(a):
> This patch adds a driver for a harddrive attached to PXA address and =
data
> bus. Unlike pata_platform, this driver allows usage of PXA DMA contro=
ller,
> making the transmission speed 3x higher.
>=20
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Hey, any updates on this ?
> ---
>  arch/arm/mach-pxa/include/mach/pata_pxa.h |   33 +++
>  drivers/ata/Kconfig                       |   11 +
>  drivers/ata/Makefile                      |    1 +
>  drivers/ata/pata_pxa.c                    |  383
> +++++++++++++++++++++++++++++ 4 files changed, 428 insertions(+), 0
> deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
>  create mode 100644 drivers/ata/pata_pxa.c
>=20
> diff --git a/arch/arm/mach-pxa/include/mach/pata_pxa.h
> b/arch/arm/mach-pxa/include/mach/pata_pxa.h new file mode 100644
> index 0000000..6cf7df1
> --- /dev/null
> +++ b/arch/arm/mach-pxa/include/mach/pata_pxa.h
> @@ -0,0 +1,33 @@
> +/*
> + * Generic PXA PATA driver
> + *
> + * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License as publishe=
d by
> + *  the Free Software Foundation; either version 2, or (at your opti=
on)
> + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public Licens=
e
> + *  along with this program; see the file COPYING.  If not, write to
> + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,=
 USA.
> + */
> +
> +#ifndef	__MACH_PATA_PXA_H__
> +#define	__MACH_PATA_PXA_H__
> +
> +struct pata_pxa_pdata {
> +	/* PXA DMA DREQ<0:2> pin */
> +	uint32_t	dma_dreq;
> +	/* Register shift */
> +	uint32_t	reg_shift;
> +	/* IRQ flags */
> +	uint32_t	irq_flags;
> +};
> +
> +#endif	/* __MACH_PATA_PXA_H__ */
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 01c52c4..5cd3e8c 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -684,6 +684,17 @@ config PATA_VIA
>=20
>  	  If unsure, say N.
>=20
> +config PATA_PXA
> +	tristate "PXA DMA-capable PATA support"
> +	depends on ARCH_PXA
> +	help
> +	  This option enables support for harddrive attached to PXA CPU's b=
us.
> +
> +	  NOTE: This driver utilizes PXA DMA controller, in case your hardw=
are
> +	        is not capable of doing MWDMA, use pata_platform instead.
> +
> +	  If unsure, say N.
> +
>  config PATA_WINBOND
>  	tristate "Winbond SL82C105 PATA support"
>  	depends on PCI
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index fc936d4..5ecf45a 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_PATA_PLATFORM)	+=3D pata_platform.o
>  obj-$(CONFIG_PATA_AT91)	+=3D pata_at91.o
>  obj-$(CONFIG_PATA_OF_PLATFORM)	+=3D pata_of_platform.o
>  obj-$(CONFIG_PATA_ICSIDE)	+=3D pata_icside.o
> +obj-$(CONFIG_PATA_PXA)		+=3D pata_pxa.o
>  # Should be last but two libata driver
>  obj-$(CONFIG_PATA_ACPI)		+=3D pata_acpi.o
>  # Should be last but one libata driver
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> new file mode 100644
> index 0000000..66ab1ac
> --- /dev/null
> +++ b/drivers/ata/pata_pxa.c
> @@ -0,0 +1,383 @@
> +/*
> + * Generic PXA PATA driver
> + *
> + * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License as publishe=
d by
> + *  the Free Software Foundation; either version 2, or (at your opti=
on)
> + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public Licens=
e
> + *  along with this program; see the file COPYING.  If not, write to
> + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,=
 USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/blkdev.h>
> +#include <linux/ata.h>
> +#include <linux/libata.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/slab.h>
> +#include <linux/completion.h>
> +
> +#include <scsi/scsi_host.h>
> +
> +#include <mach/pxa2xx-regs.h>
> +#include <mach/pata_pxa.h>
> +#include <mach/dma.h>
> +
> +#define DRV_NAME	"pata_pxa"
> +#define DRV_VERSION	"0.1"
> +
> +struct pata_pxa_data {
> +	uint32_t		dma_channel;
> +	struct pxa_dma_desc	*dma_desc;
> +	dma_addr_t		dma_desc_addr;
> +	uint32_t		dma_desc_id;
> +
> +	/* DMA IO physical address */
> +	uint32_t		dma_io_addr;
> +	/* PXA DREQ<0:2> pin selector */
> +	uint32_t		dma_dreq;
> +
> +	struct completion	dma_done;
> +};
> +
> +/*
> + * Setup the DMA descriptors. The size is transfer capped at 4k per
> descriptor, + * if the transfer is longer, it is split into multiple
> chained descriptors. + */
> +static void pxa_load_dmac(struct scatterlist *sg, struct ata_queued_=
cmd
> *qc) +{
> +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> +
> +	uint32_t cpu_len, seg_len;
> +	dma_addr_t cpu_addr;
> +
> +	cpu_addr =3D sg_dma_address(sg);
> +	cpu_len =3D sg_dma_len(sg);
> +
> +	do {
> +		seg_len =3D (cpu_len > 0x1000) ? 0x1000 : cpu_len;
> +
> +		pd->dma_desc[pd->dma_desc_id].ddadr =3D pd->dma_desc_addr +
> +			((pd->dma_desc_id + 1) * sizeof(struct pxa_dma_desc));
> +
> +		pd->dma_desc[pd->dma_desc_id].dcmd =3D DCMD_BURST32 | DCMD_WIDTH2=20
|
> +					(DCMD_LENGTH & seg_len);
> +
> +		if (qc->tf.flags & ATA_TFLAG_WRITE) {
> +			pd->dma_desc[pd->dma_desc_id].dsadr =3D cpu_addr;
> +			pd->dma_desc[pd->dma_desc_id].dtadr =3D pd->dma_io_addr;
> +			pd->dma_desc[pd->dma_desc_id].dcmd |=3D DCMD_INCSRCADDR |
> +						DCMD_FLOWTRG;
> +		} else {
> +			pd->dma_desc[pd->dma_desc_id].dsadr =3D pd->dma_io_addr;
> +			pd->dma_desc[pd->dma_desc_id].dtadr =3D cpu_addr;
> +			pd->dma_desc[pd->dma_desc_id].dcmd |=3D DCMD_INCTRGADDR |
> +						DCMD_FLOWSRC;
> +		}
> +
> +		cpu_len -=3D seg_len;
> +		cpu_addr +=3D seg_len;
> +		pd->dma_desc_id++;
> +
> +	} while(cpu_len);
> +
> +	/* Should not happen */
> +	if (seg_len & 0x1f)
> +		DALGN |=3D (1 << pd->dma_dreq);
> +}
> +
> +/*
> + * Configure the DMA controller, load the DMA descriptors, but don't=
 start
> the + * DMA controller yet. Only issue the ATA command.
> + */
> +static void pxa_bmdma_setup(struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> +	int si =3D 0;
> +	struct scatterlist *sg;
> +
> +	pd->dma_desc_id =3D 0;
> +
> +	DCSR(pd->dma_channel) =3D 0;
> +	DALGN &=3D ~(1 << pd->dma_dreq);
> +
> +	for_each_sg(qc->sg, sg, qc->n_elem, si)
> +		pxa_load_dmac(sg, qc);
> +
> +	pd->dma_desc[pd->dma_desc_id - 1].ddadr =3D DDADR_STOP;
> +
> +	/* Fire IRQ only at the end of last block */
> +	pd->dma_desc[pd->dma_desc_id - 1].dcmd |=3D DCMD_ENDIRQEN;
> +
> +	DDADR(pd->dma_channel) =3D pd->dma_desc_addr;
> +	DRCMR(pd->dma_dreq) =3D DRCMR_MAPVLD | pd->dma_channel;
> +	qc->ap->ops->sff_exec_command(qc->ap, &qc->tf);
> +}
> +
> +/*
> + * Execute the DMA transfer.
> + */
> +static void pxa_bmdma_start(struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> +	init_completion(&pd->dma_done);
> +	DCSR(pd->dma_channel) =3D DCSR_RUN;
> +}
> +
> +/*
> + * Wait until the DMA transfer completes, then stop the DMA controll=
er.
> + */
> +static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> +
> +	if (DCSR(pd->dma_channel) & DCSR_RUN)
> +		if (wait_for_completion_timeout(&pd->dma_done, HZ))
> +			BUG();
> +
> +	DCSR(pd->dma_channel) =3D 0;
> +}
> +
> +/*
> + * Read DMA status. The bmdma_stop() will take care of properly fini=
shing
> the + * DMA transfer so we always have DMA-complete interrupt here.
> + */
> +static unsigned char pxa_bmdma_status(struct ata_port *ap)
> +{
> +	return ATA_DMA_INTR;
> +}
> +
> +/*
> + * No IRQ register present so we do nothing.
> + */
> +static void pxa_irq_clear(struct ata_port *ap)
> +{
> +}
> +
> +/*
> + * Check for ATAPI DMA. ATAPI DMA is unsupported by this driver. It'=
s
> still + * unclear why ATAPI has DMA issues.
> + */
> +static int pxa_check_atapi_dma(struct ata_queued_cmd *qc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static struct scsi_host_template pxa_ata_sht =3D {
> +	ATA_BMDMA_SHT(DRV_NAME),
> +};
> +
> +static struct ata_port_operations pxa_ata_port_ops =3D {
> +	.inherits		=3D &ata_bmdma_port_ops,
> +	.cable_detect		=3D ata_cable_40wire,
> +
> +	.bmdma_setup		=3D pxa_bmdma_setup,
> +	.bmdma_start		=3D pxa_bmdma_start,
> +	.bmdma_stop		=3D pxa_bmdma_stop,
> +	.bmdma_status		=3D pxa_bmdma_status,
> +
> +	.check_atapi_dma	=3D pxa_check_atapi_dma,
> +
> +	.sff_irq_clear		=3D pxa_irq_clear,
> +};
> +
> +/*
> + * DMA interrupt handler.
> + */
> +static void pxa_ata_dma_irq(int dma, void *port)
> +{
> +	uint32_t dcsr;
> +	struct ata_port *ap =3D port;
> +	struct pata_pxa_data *pd =3D ap->private_data;
> +
> +	dcsr =3D DCSR(dma);
> +	DCSR(dma) =3D dcsr;
> +	if (dcsr & DCSR_STOPSTATE)
> +		complete(&pd->dma_done);
> +}
> +
> +static int __devinit pxa_ata_probe(struct platform_device *pdev)
> +{
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	struct pata_pxa_data *data;
> +	struct resource *cmd_res;
> +	struct resource *ctl_res;
> +	struct resource *dma_res;
> +	struct resource *irq_res;
> +	struct pata_pxa_pdata *pdata =3D pdev->dev.platform_data;
> +
> +	/*
> +	 * Resource validation, three resources are needed:
> +	 *  - CMD port base address
> +	 *  - CTL port base address
> +	 *  - DMA port base address
> +	 *  - IRQ pin
> +	 */
> +	if (pdev->num_resources !=3D 4) {
> +		dev_err(&pdev->dev, "invalid number of resources\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * CMD port base address
> +	 */
> +	cmd_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(cmd_res =3D=3D NULL))
> +		return -EINVAL;
> +
> +	/*
> +	 * CTL port base address
> +	 */
> +	ctl_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (unlikely(ctl_res =3D=3D NULL))
> +		return -EINVAL;
> +
> +	/*
> +	 * DMA port base address
> +	 */
> +	dma_res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	if (unlikely(dma_res =3D=3D NULL))
> +		return -EINVAL;
> +
> +	/*
> +	 * IRQ pin
> +	 */
> +	irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (unlikely(irq_res =3D=3D NULL))
> +		return -EINVAL;
> +
> +	/*
> +	 * Allocate the host
> +	 */
> +	host =3D ata_host_alloc(&pdev->dev, 1);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	ap		=3D host->ports[0];
> +	ap->ops		=3D &pxa_ata_port_ops;
> +	ap->pio_mask	=3D ATA_PIO4;
> +	ap->mwdma_mask	=3D ATA_MWDMA2;
> +	ap->flags	=3D ATA_FLAG_MMIO;
> +
> +	ap->ioaddr.cmd_addr	=3D devm_ioremap(&pdev->dev, cmd_res->start,
> +						resource_size(cmd_res));
> +	ap->ioaddr.ctl_addr	=3D devm_ioremap(&pdev->dev, ctl_res->start,
> +						resource_size(ctl_res));
> +	ap->ioaddr.bmdma_addr	=3D devm_ioremap(&pdev->dev, dma_res->start,
> +						resource_size(dma_res));
> +
> +	/*
> +	 * Adjust register offsets
> +	 */
> +	ap->ioaddr.altstatus_addr =3D ap->ioaddr.ctl_addr;
> +	ap->ioaddr.data_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_DATA << pdata->reg_shift);
> +	ap->ioaddr.error_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_ERR << pdata->reg_shift);
> +	ap->ioaddr.feature_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_FEATURE << pdata->reg_shift);
> +	ap->ioaddr.nsect_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_NSECT << pdata->reg_shift);
> +	ap->ioaddr.lbal_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_LBAL << pdata->reg_shift);
> +	ap->ioaddr.lbam_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_LBAM << pdata->reg_shift);
> +	ap->ioaddr.lbah_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_LBAH << pdata->reg_shift);
> +	ap->ioaddr.device_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_DEVICE << pdata->reg_shift);
> +	ap->ioaddr.status_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_STATUS << pdata->reg_shift);
> +	ap->ioaddr.command_addr	=3D ap->ioaddr.cmd_addr +
> +					(ATA_REG_CMD << pdata->reg_shift);
> +
> +	/*
> +	 * Allocate and load driver's internal data structure
> +	 */
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(struct pata_pxa_data),
> +								GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ap->private_data =3D data;
> +	data->dma_dreq =3D pdata->dma_dreq;
> +	data->dma_io_addr =3D dma_res->start;
> +
> +	/*
> +	 * Request the DMA channel
> +	 */
> +	data->dma_channel =3D pxa_request_dma(DRV_NAME, DMA_PRIO_LOW,
> +						pxa_ata_dma_irq, ap);
> +	if (data->dma_channel < 0)
> +		return -EBUSY;
> +
> +	/*
> +	 * Stop and clear the DMA channel
> +	 */
> +	DCSR(data->dma_channel) =3D 0;
> +
> +	/*
> +	 * Allocate space for the DMA descriptors
> +	 */
> +	data->dma_desc =3D dmam_alloc_coherent(&pdev->dev, PAGE_SIZE,
> +					&data->dma_desc_addr, GFP_KERNEL);
> +
> +	/*
> +	 * Activate the ATA host
> +	 */
> +	return ata_host_activate(host, irq_res->start, ata_sff_interrupt,
> +				pdata->irq_flags, &pxa_ata_sht);
> +}
> +
> +static int __devexit pxa_ata_remove(struct platform_device *pdev)
> +{
> +	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
> +	struct pata_pxa_data *data =3D host->ports[0]->private_data;
> +
> +	pxa_free_dma(data->dma_channel);
> +
> +	ata_host_detach(host);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pxa_ata_driver =3D {
> +	.probe		=3D pxa_ata_probe,
> +	.remove		=3D __devexit_p(pxa_ata_remove),
> +	.driver		=3D {
> +		.name		=3D DRV_NAME,
> +		.owner		=3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init pxa_ata_init(void)
> +{
> +	return platform_driver_register(&pxa_ata_driver);
> +}
> +
> +static void __exit pxa_ata_exit(void)
> +{
> +	platform_driver_unregister(&pxa_ata_driver);
> +}
> +
> +module_init(pxa_ata_init);
> +module_exit(pxa_ata_exit);
> +
> +MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
> +MODULE_DESCRIPTION("DMA-capable driver for PATA on PXA CPU");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_ALIAS("platform:" DRV_NAME);
