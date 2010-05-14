From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Fri, 14 May 2010 18:03:45 -0400
Message-ID: <4BEDC8C1.30703@garzik.org>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:52576 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab0ENWDs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 18:03:48 -0400
Received: by gxk9 with SMTP id 9so2003260gxk.8
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 15:03:47 -0700 (PDT)
In-Reply-To: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com

On 05/09/2010 11:02 PM, Marek Vasut wrote:
> This patch adds a driver for a harddrive attached to PXA address and data bus.
> Unlike pata_platform, this driver allows usage of PXA DMA controller, making the
> transmission speed 3x higher.
>
> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> ---
>   arch/arm/mach-pxa/include/mach/pata_pxa.h |   33 +++
>   drivers/ata/Kconfig                       |   11 +
>   drivers/ata/Makefile                      |    1 +
>   drivers/ata/pata_pxa.c                    |  383 +++++++++++++++++++++++++++++
>   4 files changed, 428 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
>   create mode 100644 drivers/ata/pata_pxa.c
>
> diff --git a/arch/arm/mach-pxa/include/mach/pata_pxa.h b/arch/arm/mach-pxa/include/mach/pata_pxa.h
> new file mode 100644
> index 0000000..6cf7df1
> --- /dev/null
> +++ b/arch/arm/mach-pxa/include/mach/pata_pxa.h
> @@ -0,0 +1,33 @@
> +/*
> + * Generic PXA PATA driver
> + *
> + * Copyright (C) 2010 Marek Vasut<marek.vasut@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2, or (at your option)
> + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; see the file COPYING.  If not, write to
> + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef	__MACH_PATA_PXA_H__
> +#define	__MACH_PATA_PXA_H__
> +
> +struct pata_pxa_pdata {
> +	/* PXA DMA DREQ<0:2>  pin */
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
>
>   	  If unsure, say N.
>
> +config PATA_PXA
> +	tristate "PXA DMA-capable PATA support"
> +	depends on ARCH_PXA
> +	help
> +	  This option enables support for harddrive attached to PXA CPU's bus.
> +	
> +	  NOTE: This driver utilizes PXA DMA controller, in case your hardware
> +	        is not capable of doing MWDMA, use pata_platform instead.
> +
> +	  If unsure, say N.
> +
>   config PATA_WINBOND
>   	tristate "Winbond SL82C105 PATA support"
>   	depends on PCI
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index fc936d4..5ecf45a 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
>   obj-$(CONFIG_PATA_AT91)	+= pata_at91.o
>   obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
>   obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
> +obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
>   # Should be last but two libata driver
>   obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
>   # Should be last but one libata driver
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> new file mode 100644
> index 0000000..66ab1ac
> --- /dev/null
> +++ b/drivers/ata/pata_pxa.c
> @@ -0,0 +1,383 @@
> +/*
> + * Generic PXA PATA driver
> + *
> + * Copyright (C) 2010 Marek Vasut<marek.vasut@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2, or (at your option)
> + *  any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; see the file COPYING.  If not, write to
> + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/init.h>
> +#include<linux/blkdev.h>
> +#include<linux/ata.h>
> +#include<linux/libata.h>
> +#include<linux/platform_device.h>
> +#include<linux/gpio.h>
> +#include<linux/slab.h>
> +#include<linux/completion.h>
> +
> +#include<scsi/scsi_host.h>
> +
> +#include<mach/pxa2xx-regs.h>
> +#include<mach/pata_pxa.h>
> +#include<mach/dma.h>
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
> +	/* PXA DREQ<0:2>  pin selector */
> +	uint32_t		dma_dreq;
> +
> +	struct completion	dma_done;
> +};
> +
> +/*
> + * Setup the DMA descriptors. The size is transfer capped at 4k per descriptor,
> + * if the transfer is longer, it is split into multiple chained descriptors.
> + */
> +static void pxa_load_dmac(struct scatterlist *sg, struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd = qc->ap->private_data;
> +
> +	uint32_t cpu_len, seg_len;
> +	dma_addr_t cpu_addr;
> +
> +	cpu_addr = sg_dma_address(sg);
> +	cpu_len = sg_dma_len(sg);
> +
> +	do {
> +		seg_len = (cpu_len>  0x1000) ? 0x1000 : cpu_len;
> +
> +		pd->dma_desc[pd->dma_desc_id].ddadr = pd->dma_desc_addr +
> +			((pd->dma_desc_id + 1) * sizeof(struct pxa_dma_desc));
> +
> +		pd->dma_desc[pd->dma_desc_id].dcmd = DCMD_BURST32 | DCMD_WIDTH2 |
> +					(DCMD_LENGTH&  seg_len);
> +
> +		if (qc->tf.flags&  ATA_TFLAG_WRITE) {
> +			pd->dma_desc[pd->dma_desc_id].dsadr = cpu_addr;
> +			pd->dma_desc[pd->dma_desc_id].dtadr = pd->dma_io_addr;
> +			pd->dma_desc[pd->dma_desc_id].dcmd |= DCMD_INCSRCADDR |
> +						DCMD_FLOWTRG;
> +		} else {
> +			pd->dma_desc[pd->dma_desc_id].dsadr = pd->dma_io_addr;
> +			pd->dma_desc[pd->dma_desc_id].dtadr = cpu_addr;
> +			pd->dma_desc[pd->dma_desc_id].dcmd |= DCMD_INCTRGADDR |
> +						DCMD_FLOWSRC;
> +		}
> +	
> +		cpu_len -= seg_len;
> +		cpu_addr += seg_len;
> +		pd->dma_desc_id++;
> +
> +	} while(cpu_len);
> +
> +	/* Should not happen */
> +	if (seg_len&  0x1f)
> +		DALGN |= (1<<  pd->dma_dreq);
> +}

normally this is done in the fill_sg step, part of qc_prep.  is that 
doable for pata_pxa?


> +static void pxa_bmdma_setup(struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd = qc->ap->private_data;
> +	int si = 0;
> +	struct scatterlist *sg;
> +
> +	pd->dma_desc_id = 0;
> +
> +	DCSR(pd->dma_channel) = 0;
> +	DALGN&= ~(1<<  pd->dma_dreq);
> +
> +	for_each_sg(qc->sg, sg, qc->n_elem, si)
> +		pxa_load_dmac(sg, qc);
> +
> +	pd->dma_desc[pd->dma_desc_id - 1].ddadr = DDADR_STOP;
> +
> +	/* Fire IRQ only at the end of last block */
> +	pd->dma_desc[pd->dma_desc_id - 1].dcmd |= DCMD_ENDIRQEN;
> +
> +	DDADR(pd->dma_channel) = pd->dma_desc_addr;
> +	DRCMR(pd->dma_dreq) = DRCMR_MAPVLD | pd->dma_channel;
> +	qc->ap->ops->sff_exec_command(qc->ap,&qc->tf);
> +}
> +
> +/*
> + * Execute the DMA transfer.
> + */
> +static void pxa_bmdma_start(struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd = qc->ap->private_data;
> +	init_completion(&pd->dma_done);
> +	DCSR(pd->dma_channel) = DCSR_RUN;
> +}
> +
> +/*
> + * Wait until the DMA transfer completes, then stop the DMA controller.
> + */
> +static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
> +{
> +	struct pata_pxa_data *pd = qc->ap->private_data;
> +
> +	if (DCSR(pd->dma_channel)&  DCSR_RUN)
> +		if (wait_for_completion_timeout(&pd->dma_done, HZ))
> +			BUG();
> +
> +	DCSR(pd->dma_channel) = 0;

a little bit more description than BUG() would be useful.  BUG() is a 
bit unfriendly and vague way to report errors.

> + * Read DMA status. The bmdma_stop() will take care of properly finishing the
> + * DMA transfer so we always have DMA-complete interrupt here.
> + */
> +static unsigned char pxa_bmdma_status(struct ata_port *ap)
> +{
> +	return ATA_DMA_INTR;
> +}

are you able to detect bus error?


> + */
> +static void pxa_irq_clear(struct ata_port *ap)
> +{
> +}
> +
> +/*
> + * Check for ATAPI DMA. ATAPI DMA is unsupported by this driver. It's still
> + * unclear why ATAPI has DMA issues.
> + */
> +static int pxa_check_atapi_dma(struct ata_queued_cmd *qc)
> +{
> +	return -EOPNOTSUPP;
> +}

This is a bug.  Return 1 or 0.  This statement actually tells libata to 
-enable- DMA!
