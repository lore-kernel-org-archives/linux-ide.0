From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Sat, 15 May 2010 00:23:45 +0200
Message-ID: <201005150023.45336.marek.vasut@gmail.com>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com> <4BEDC8C1.30703@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51853 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab0ENWZO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 18:25:14 -0400
Received: by fxm6 with SMTP id 6so1995573fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 15:25:12 -0700 (PDT)
In-Reply-To: <4BEDC8C1.30703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com

Dne So 15. kv=C4=9Btna 2010 00:03:45 Jeff Garzik napsal(a):
> On 05/09/2010 11:02 PM, Marek Vasut wrote:
> > This patch adds a driver for a harddrive attached to PXA address an=
d data
> > bus. Unlike pata_platform, this driver allows usage of PXA DMA
> > controller, making the transmission speed 3x higher.
> >=20
> > Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> > ---
> >=20
> >   arch/arm/mach-pxa/include/mach/pata_pxa.h |   33 +++
> >   drivers/ata/Kconfig                       |   11 +
> >   drivers/ata/Makefile                      |    1 +
> >   drivers/ata/pata_pxa.c                    |  383
> >   +++++++++++++++++++++++++++++ 4 files changed, 428 insertions(+),=
 0
> >   deletions(-)
> >   create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
> >   create mode 100644 drivers/ata/pata_pxa.c
> >=20
> > diff --git a/arch/arm/mach-pxa/include/mach/pata_pxa.h
> > b/arch/arm/mach-pxa/include/mach/pata_pxa.h new file mode 100644
> > index 0000000..6cf7df1
> > --- /dev/null
> > +++ b/arch/arm/mach-pxa/include/mach/pata_pxa.h
> > @@ -0,0 +1,33 @@
> > +/*
> > + * Generic PXA PATA driver
> > + *
> > + * Copyright (C) 2010 Marek Vasut<marek.vasut@gmail.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or =
modify
> > + *  it under the terms of the GNU General Public License as publis=
hed by
> > + *  the Free Software Foundation; either version 2, or (at your op=
tion)
> > + *  any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful=
,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public Lice=
nse
> > + *  along with this program; see the file COPYING.  If not, write =
to
> > + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 0213=
9,
> > USA. + */
> > +
> > +#ifndef	__MACH_PATA_PXA_H__
> > +#define	__MACH_PATA_PXA_H__
> > +
> > +struct pata_pxa_pdata {
> > +	/* PXA DMA DREQ<0:2>  pin */
> > +	uint32_t	dma_dreq;
> > +	/* Register shift */
> > +	uint32_t	reg_shift;
> > +	/* IRQ flags */
> > +	uint32_t	irq_flags;
> > +};
> > +
> > +#endif	/* __MACH_PATA_PXA_H__ */
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index 01c52c4..5cd3e8c 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -684,6 +684,17 @@ config PATA_VIA
> >=20
> >   	  If unsure, say N.
> >=20
> > +config PATA_PXA
> > +	tristate "PXA DMA-capable PATA support"
> > +	depends on ARCH_PXA
> > +	help
> > +	  This option enables support for harddrive attached to PXA CPU's=
 bus.
> > +
> > +	  NOTE: This driver utilizes PXA DMA controller, in case your har=
dware
> > +	        is not capable of doing MWDMA, use pata_platform instead.
> > +
> > +	  If unsure, say N.
> > +
> >=20
> >   config PATA_WINBOND
> >  =20
> >   	tristate "Winbond SL82C105 PATA support"
> >   	depends on PCI
> >=20
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index fc936d4..5ecf45a 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -79,6 +79,7 @@ obj-$(CONFIG_PATA_PLATFORM)	+=3D pata_platform.o
> >=20
> >   obj-$(CONFIG_PATA_AT91)	+=3D pata_at91.o
> >   obj-$(CONFIG_PATA_OF_PLATFORM)	+=3D pata_of_platform.o
> >   obj-$(CONFIG_PATA_ICSIDE)	+=3D pata_icside.o
> >=20
> > +obj-$(CONFIG_PATA_PXA)		+=3D pata_pxa.o
> >=20
> >   # Should be last but two libata driver
> >   obj-$(CONFIG_PATA_ACPI)		+=3D pata_acpi.o
> >   # Should be last but one libata driver
> >=20
> > diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> > new file mode 100644
> > index 0000000..66ab1ac
> > --- /dev/null
> > +++ b/drivers/ata/pata_pxa.c
> > @@ -0,0 +1,383 @@
> > +/*
> > + * Generic PXA PATA driver
> > + *
> > + * Copyright (C) 2010 Marek Vasut<marek.vasut@gmail.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or =
modify
> > + *  it under the terms of the GNU General Public License as publis=
hed by
> > + *  the Free Software Foundation; either version 2, or (at your op=
tion)
> > + *  any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful=
,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public Lice=
nse
> > + *  along with this program; see the file COPYING.  If not, write =
to
> > + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 0213=
9,
> > USA. + */
> > +
> > +#include<linux/kernel.h>
> > +#include<linux/module.h>
> > +#include<linux/init.h>
> > +#include<linux/blkdev.h>
> > +#include<linux/ata.h>
> > +#include<linux/libata.h>
> > +#include<linux/platform_device.h>
> > +#include<linux/gpio.h>
> > +#include<linux/slab.h>
> > +#include<linux/completion.h>
> > +
> > +#include<scsi/scsi_host.h>
> > +
> > +#include<mach/pxa2xx-regs.h>
> > +#include<mach/pata_pxa.h>
> > +#include<mach/dma.h>
> > +
> > +#define DRV_NAME	"pata_pxa"
> > +#define DRV_VERSION	"0.1"
> > +
> > +struct pata_pxa_data {
> > +	uint32_t		dma_channel;
> > +	struct pxa_dma_desc	*dma_desc;
> > +	dma_addr_t		dma_desc_addr;
> > +	uint32_t		dma_desc_id;
> > +
> > +	/* DMA IO physical address */
> > +	uint32_t		dma_io_addr;
> > +	/* PXA DREQ<0:2>  pin selector */
> > +	uint32_t		dma_dreq;
> > +
> > +	struct completion	dma_done;
> > +};
> > +
> > +/*
> > + * Setup the DMA descriptors. The size is transfer capped at 4k pe=
r
> > descriptor, + * if the transfer is longer, it is split into multipl=
e
> > chained descriptors. + */
> > +static void pxa_load_dmac(struct scatterlist *sg, struct ata_queue=
d_cmd
> > *qc) +{
> > +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> > +
> > +	uint32_t cpu_len, seg_len;
> > +	dma_addr_t cpu_addr;
> > +
> > +	cpu_addr =3D sg_dma_address(sg);
> > +	cpu_len =3D sg_dma_len(sg);
> > +
> > +	do {
> > +		seg_len =3D (cpu_len>  0x1000) ? 0x1000 : cpu_len;
> > +
> > +		pd->dma_desc[pd->dma_desc_id].ddadr =3D pd->dma_desc_addr +
> > +			((pd->dma_desc_id + 1) * sizeof(struct pxa_dma_desc));
> > +
> > +		pd->dma_desc[pd->dma_desc_id].dcmd =3D DCMD_BURST32 | DCMD_WIDTH=
2=20
|
> > +					(DCMD_LENGTH&  seg_len);
> > +
> > +		if (qc->tf.flags&  ATA_TFLAG_WRITE) {
> > +			pd->dma_desc[pd->dma_desc_id].dsadr =3D cpu_addr;
> > +			pd->dma_desc[pd->dma_desc_id].dtadr =3D pd->dma_io_addr;
> > +			pd->dma_desc[pd->dma_desc_id].dcmd |=3D DCMD_INCSRCADDR |
> > +						DCMD_FLOWTRG;
> > +		} else {
> > +			pd->dma_desc[pd->dma_desc_id].dsadr =3D pd->dma_io_addr;
> > +			pd->dma_desc[pd->dma_desc_id].dtadr =3D cpu_addr;
> > +			pd->dma_desc[pd->dma_desc_id].dcmd |=3D DCMD_INCTRGADDR |
> > +						DCMD_FLOWSRC;
> > +		}
> > +
> > +		cpu_len -=3D seg_len;
> > +		cpu_addr +=3D seg_len;
> > +		pd->dma_desc_id++;
> > +
> > +	} while(cpu_len);
> > +
> > +	/* Should not happen */
> > +	if (seg_len&  0x1f)
> > +		DALGN |=3D (1<<  pd->dma_dreq);
> > +}
>=20
> normally this is done in the fill_sg step, part of qc_prep.  is that
> doable for pata_pxa?

Yes, I think it'd be doable. Though I can't test now (and it will proba=
bly take=20
some time until I can again). Would it be possible to leave it this way=
 and then=20
send another patch on top of it once I test it on the hardware ?
>=20
> > +static void pxa_bmdma_setup(struct ata_queued_cmd *qc)
> > +{
> > +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> > +	int si =3D 0;
> > +	struct scatterlist *sg;
> > +
> > +	pd->dma_desc_id =3D 0;
> > +
> > +	DCSR(pd->dma_channel) =3D 0;
> > +	DALGN&=3D ~(1<<  pd->dma_dreq);
> > +
> > +	for_each_sg(qc->sg, sg, qc->n_elem, si)
> > +		pxa_load_dmac(sg, qc);
> > +
> > +	pd->dma_desc[pd->dma_desc_id - 1].ddadr =3D DDADR_STOP;
> > +
> > +	/* Fire IRQ only at the end of last block */
> > +	pd->dma_desc[pd->dma_desc_id - 1].dcmd |=3D DCMD_ENDIRQEN;
> > +
> > +	DDADR(pd->dma_channel) =3D pd->dma_desc_addr;
> > +	DRCMR(pd->dma_dreq) =3D DRCMR_MAPVLD | pd->dma_channel;
> > +	qc->ap->ops->sff_exec_command(qc->ap,&qc->tf);
> > +}
> > +
> > +/*
> > + * Execute the DMA transfer.
> > + */
> > +static void pxa_bmdma_start(struct ata_queued_cmd *qc)
> > +{
> > +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> > +	init_completion(&pd->dma_done);
> > +	DCSR(pd->dma_channel) =3D DCSR_RUN;
> > +}
> > +
> > +/*
> > + * Wait until the DMA transfer completes, then stop the DMA contro=
ller.
> > + */
> > +static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
> > +{
> > +	struct pata_pxa_data *pd =3D qc->ap->private_data;
> > +
> > +	if (DCSR(pd->dma_channel)&  DCSR_RUN)
> > +		if (wait_for_completion_timeout(&pd->dma_done, HZ))
> > +			BUG();
> > +
> > +	DCSR(pd->dma_channel) =3D 0;
>=20
> a little bit more description than BUG() would be useful.  BUG() is a
> bit unfriendly and vague way to report errors.

BUG() doesn't happen here so the user won't come into any contact with =
it unless=20
he sets the drive on fire or something. And in case user comes in conta=
ct with=20
it, this is all I need to know to help him. Or maybe dev_err() would be=
 good=20
here ?
>=20
> > + * Read DMA status. The bmdma_stop() will take care of properly
> > finishing the + * DMA transfer so we always have DMA-complete inter=
rupt
> > here.
> > + */
> > +static unsigned char pxa_bmdma_status(struct ata_port *ap)
> > +{
> > +	return ATA_DMA_INTR;
> > +}
>=20
> are you able to detect bus error?

Sadly, no. Nor can I detect any other condition.
>=20
> > + */
> > +static void pxa_irq_clear(struct ata_port *ap)
> > +{
> > +}
> > +
> > +/*
> > + * Check for ATAPI DMA. ATAPI DMA is unsupported by this driver. I=
t's
> > still + * unclear why ATAPI has DMA issues.
> > + */
> > +static int pxa_check_atapi_dma(struct ata_queued_cmd *qc)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
>=20
> This is a bug.  Return 1 or 0.  This statement actually tells libata =
to
> -enable- DMA!

=46or this I can send v2 of this patch. Possibly, pata_ali and pata_ns8=
7415 would=20
then be worth fixing as well?

Cheers!
