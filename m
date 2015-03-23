From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 05/10] mfd: syscon: Add Atmel MC (Memory Controller)
 registers definition
Date: Mon, 23 Mar 2015 14:47:06 +0000
Message-ID: <20150323144706.GK24804@x1>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426545886-19162-6-git-send-email-alexandre.belloni@free-electrons.com>
 <550FE38F.7070701@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32931 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbCWOrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2015 10:47:11 -0400
Received: by wixw10 with SMTP id w10so36144253wix.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2015 07:47:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <550FE38F.7070701@atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, 23 Mar 2015, Nicolas Ferre wrote:

> Le 16/03/2015 23:44, Alexandre Belloni a =C3=A9crit :
> > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> >=20
> > The at91rm9200 SoC embeds a Memory Controller block which is used t=
o
> > configure several aspects of the platform:
> > - AHB/APB Bus behavior
> > - SDRAM Controller
> > - EBI (External Bus Interface) and SMC (Static Memory Controller) c=
onfig
> >=20
> > Those registers might be accessed by different drivers, hence we ne=
ed to
> > define it as a syscon device.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>=20
> Alexandre, don't you need to Ack this patch at least?

If he is submitting, he needs his SoB.

> > ---
> >  include/linux/mfd/syscon/atmel-mc.h | 144 ++++++++++++++++++++++++=
++++++++++++
> >  1 file changed, 144 insertions(+)
> >  create mode 100644 include/linux/mfd/syscon/atmel-mc.h
> >=20
> > diff --git a/include/linux/mfd/syscon/atmel-mc.h b/include/linux/mf=
d/syscon/atmel-mc.h
> > new file mode 100644
> > index 000000000000..cb7d9fe89e44
> > --- /dev/null
> > +++ b/include/linux/mfd/syscon/atmel-mc.h
> > @@ -0,0 +1,144 @@
> > +/*
> > + * Copyright (C) 2005 Ivan Kokshaysky
> > + * Copyright (C) SAN People
> > + *
> > + * Memory Controllers (MC, EBI, SMC, SDRAMC, BFC) - System periphe=
rals
> > + * registers.
> > + * Based on AT91RM9200 datasheet revision E.
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef _LINUX_MFD_SYSCON_ATMEL_MC_H_
> > +#define _LINUX_MFD_SYSCON_ATMEL_MC_H_
> > +
> > +/* Memory Controller */
> > +#define AT91_MC_RCR			0x00
> > +#define AT91_MC_RCB			BIT(0)
> > +
> > +#define AT91_MC_ASR			0x04
> > +#define AT91_MC_UNADD			BIT(0)
> > +#define AT91_MC_MISADD			BIT(1)
> > +#define AT91_MC_ABTSZ			GENMASK(9, 8)
> > +#define AT91_MC_ABTSZ_BYTE		(0 << 8)
> > +#define AT91_MC_ABTSZ_HALFWORD		(1 << 8)
> > +#define AT91_MC_ABTSZ_WORD		(2 << 8)
> > +#define AT91_MC_ABTTYP			GENMASK(11, 10)
> > +#define AT91_MC_ABTTYP_DATAREAD		(0 << 10)
> > +#define AT91_MC_ABTTYP_DATAWRITE	(1 << 10)
> > +#define AT91_MC_ABTTYP_FETCH		(2 << 10)
> > +#define AT91_MC_MST(n)			BIT(16 + (n))
> > +#define AT91_MC_SVMST(n)		BIT(24 + (n))
> > +
> > +#define AT91_MC_AASR			0x08
> > +
> > +#define AT91_MC_MPR			0x0c
> > +#define AT91_MPR_MSTP(n)		GENMASK(2 + ((x) * 4), ((x) * 4))
> > +
> > +/* External Bus Interface (EBI) registers */
> > +#define AT91_MC_EBI_CSA			0x60
> > +#define AT91_MC_EBI_CS(n)		BIT(x)
> > +#define AT91_MC_EBI_NUM_CS		8
> > +
> > +#define AT91_MC_EBI_CFGR		0x64
> > +#define AT91_MC_EBI_DBPUC		BIT(0)
> > +
> > +/* Static Memory Controller (SMC) registers */
> > +#define	AT91_MC_SMC_CSR(n)		(0x70 + ((n) * 4))
> > +#define AT91_MC_SMC_NWS			GENMASK(6, 0)
> > +#define AT91_MC_SMC_NWS_(x)		((x) << 0)
> > +#define AT91_MC_SMC_WSEN		BIT(7)
> > +#define AT91_MC_SMC_TDF			GENMASK(11, 8)
> > +#define AT91_MC_SMC_TDF_(x)		((x) << 8)
> > +#define AT91_MC_SMC_TDF_MAX		0xf
> > +#define AT91_MC_SMC_BAT			BIT(12)
> > +#define AT91_MC_SMC_DBW			GENMASK(14, 13)
> > +#define AT91_MC_SMC_DBW_16		(1 << 13)
> > +#define AT91_MC_SMC_DBW_8		(2 << 13)
> > +#define AT91_MC_SMC_DPR			BIT(15)
> > +#define AT91_MC_SMC_ACSS		GENMASK(17, 16)
> > +#define AT91_MC_SMC_ACSS_(x)		((x) << 16)
> > +#define AT91_MC_SMC_ACSS_MAX		3
> > +#define AT91_MC_SMC_RWSETUP		GENMASK(26, 24)
> > +#define AT91_MC_SMC_RWSETUP_(x)		((x) << 24)
> > +#define AT91_MC_SMC_RWHOLD		GENMASK(30, 28)
> > +#define AT91_MC_SMC_RWHOLD_(x)		((x) << 28)
> > +#define AT91_MC_SMC_RWHOLDSETUP_MAX	7
> > +
> > +/* SDRAM Controller registers */
> > +#define AT91_MC_SDRAMC_MR		0x90
> > +#define AT91_MC_SDRAMC_MODE		GENMASK(3, 0)
> > +#define AT91_MC_SDRAMC_MODE_NORMAL	(0 << 0)
> > +#define AT91_MC_SDRAMC_MODE_NOP		(1 << 0)
> > +#define AT91_MC_SDRAMC_MODE_PRECHARGE	(2 << 0)
> > +#define AT91_MC_SDRAMC_MODE_LMR		(3 << 0)
> > +#define AT91_MC_SDRAMC_MODE_REFRESH	(4 << 0)
> > +#define AT91_MC_SDRAMC_DBW_16		BIT(4)
> > +
> > +#define AT91_MC_SDRAMC_TR		0x94
> > +#define AT91_MC_SDRAMC_COUNT		GENMASK(11, 0)
> > +
> > +#define AT91_MC_SDRAMC_CR		0x98
> > +#define AT91_MC_SDRAMC_NC		GENMASK(1, 0)
> > +#define AT91_MC_SDRAMC_NC_8		(0 << 0)
> > +#define AT91_MC_SDRAMC_NC_9		(1 << 0)
> > +#define AT91_MC_SDRAMC_NC_10		(2 << 0)
> > +#define AT91_MC_SDRAMC_NC_11		(3 << 0)
> > +#define AT91_MC_SDRAMC_NR		GENMASK(3, 2)
> > +#define AT91_MC_SDRAMC_NR_11		(0 << 2)
> > +#define AT91_MC_SDRAMC_NR_12		(1 << 2)
> > +#define AT91_MC_SDRAMC_NR_13		(2 << 2)
> > +#define	AT91_MC_SDRAMC_NB		BIT(4)
> > +#define AT91_MC_SDRAMC_NB_2		(0 << 4)
> > +#define AT91_MC_SDRAMC_NB_4		(1 << 4)
> > +#define AT91_MC_SDRAMC_CAS		GENMASK(6, 5)
> > +#define AT91_MC_SDRAMC_CAS_2		(2 << 5)
> > +#define AT91_MC_SDRAMC_TWR		GENMASK(10,  7)
> > +#define AT91_MC_SDRAMC_TRC		GENMASK(14, 11)
> > +#define AT91_MC_SDRAMC_TRP		GENMASK(18, 15)
> > +#define AT91_MC_SDRAMC_TRCD		GENMASK(22, 19)
> > +#define AT91_MC_SDRAMC_TRAS		GENMASK(26, 23)
> > +#define AT91_MC_SDRAMC_TXSR		GENMASK(30, 27)
> > +
> > +#define AT91_MC_SDRAMC_SRR		0x9c
> > +#define AT91_MC_SDRAMC_SRCB		BIT(0)
> > +
> > +#define AT91_MC_SDRAMC_LPR		0xa0
> > +#define AT91_MC_SDRAMC_LPCB		BIT(0)
> > +
> > +#define AT91_MC_SDRAMC_IER		0xa4
> > +#define AT91_MC_SDRAMC_IDR		0xa8
> > +#define AT91_MC_SDRAMC_IMR		0xac
> > +#define AT91_MC_SDRAMC_ISR		0xb0
> > +#define AT91_MC_SDRAMC_RES		BIT(0)
> > +
> > +/* Burst Flash Controller register */
> > +#define AT91_MC_BFC_MR			0xc0
> > +#define AT91_MC_BFC_BFCOM		GENMASK(1, 0)
> > +#define AT91_MC_BFC_BFCOM_DISABLED	(0 << 0)
> > +#define AT91_MC_BFC_BFCOM_ASYNC		(1 << 0)
> > +#define AT91_MC_BFC_BFCOM_BURST		(2 << 0)
> > +#define AT91_MC_BFC_BFCC		GENMASK(3, 2)
> > +#define AT91_MC_BFC_BFCC_MCK		(1 << 2)
> > +#define AT91_MC_BFC_BFCC_DIV2		(2 << 2)
> > +#define AT91_MC_BFC_BFCC_DIV4		(3 << 2)
> > +#define AT91_MC_BFC_AVL			GENMASK(7,  4)
> > +#define AT91_MC_BFC_PAGES		GENMASK(10, 8)
> > +#define AT91_MC_BFC_PAGES_NO_PAGE	(0 << 8)
> > +#define AT91_MC_BFC_PAGES_16		(1 << 8)
> > +#define AT91_MC_BFC_PAGES_32		(2 << 8)
> > +#define AT91_MC_BFC_PAGES_64		(3 << 8)
> > +#define AT91_MC_BFC_PAGES_128		(4 << 8)
> > +#define AT91_MC_BFC_PAGES_256		(5 << 8)
> > +#define AT91_MC_BFC_PAGES_512		(6 << 8)
> > +#define AT91_MC_BFC_PAGES_1024		(7 << 8)
> > +#define AT91_MC_BFC_OEL			GENMASK(13, 12)
> > +#define AT91_MC_BFC_BAAEN		BIT(16)
> > +#define AT91_MC_BFC_BFOEH		BIT(17)
> > +#define AT91_MC_BFC_MUXEN		BIT(18)
> > +#define AT91_MC_BFC_RDYEN		BIT(19)
> > +
> > +#endif /* _LINUX_MFD_SYSCON_ATMEL_MC_H_ */
> >=20
>=20
> I'm not a big fan of the use of BIT/GENMASK macros in mix with the <<
> operator, but I guess it can be done anyway, so I'm okay:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Please ensure Nicolas' Ack is applied to your next submission.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
