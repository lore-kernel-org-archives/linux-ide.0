Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC7C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 20 Oct 2022 23:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJTXEI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJTXD7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2022 19:03:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF2222EC94
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666307033; x=1697843033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LE+uK/qoTMEybIbQv0Zk753SwzykBZitfS4zR6YuQjU=;
  b=WRCXyX58y8ULXL8UlM+LWCKtGQWVrAO/I4g31LstfGzCJfAstzVR8xwI
   C2KgUmye34GGl++PAs5Ts7+KDUUrwnPbQ95GR/EBWzaqyQzmsPr1BwX3/
   AjvN+SX2W8R7Jxh01idRSpY1TfrNP5bJ7U8m0UbW7lF5rqAKmIxK75Ir9
   NqpwJOOtqsSc0F02HmsgcqBdb47WcHELLVev3zMBvGPbd/YIFaGhfSOVn
   gbU5vqQjQRJHlQ2zpY5hj6Qg5rT7BG0s0oAxNbJOjv5r+hw+BNNZekCPB
   y8UKmQhcth2uP2QE1RwkXvYPuR5zhu8sGiIaysERQvl6vhT4737mftX69
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326488334"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 07:03:44 +0800
IronPort-SDR: Cy0LZf2N8Kj163OryIdqSCNTn0FlSd2QRB9wLy/O7cqgjj7zb9+ZGNOMeiHI9eeYJBxINjzKdN
 WTrt1zUzEOn5eddb6PmTV1u8tLmt8kr9Qszp1B/29miUr2foFhSrd5zdJpSkbpOno1mpIv4qqE
 mVNlb2BGXlLXJ8Vc5q5Ukib/1a5DTFYYCnGNIUoCWFmSHnRVfJDdaFFy3MxR4BHhUnVtHytAjt
 JDuycx1S2pauU1irWRzksNDK4PxpZDG7xLrV8Pawf2RPWajonw65aHkgHGSjReZGDRCtmWzwPM
 aVOfoDiCkOKO2cglMj1f+MS0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 15:17:33 -0700
IronPort-SDR: Nh8Lw52skCJzY4GlTcm0rh9cRCMNf1jYvdxPM52fIadPY6w7dCd+VGrnZgVQSV/zRZTNzWVotF
 +YeP7ob2Bc+PFo8Mc/rXRXO8fnBhuS42T9RaDAzWt8ohkMo55afXw3BD2ub4hm/OJrPFVLRRMG
 L7WzKqQ5xVhqIB/Udxmv7wMyi/mebaQpFmmbMeVoa+HgFkPMUPecLDYStpsdoYXAJamwjjQUWy
 zMthrPngGU8SOkOosaGs3yhh/wSlNzEa7XgSTojkcZPNEbK3px11GUfuqod6o8Qqos+0twM8LP
 epU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 16:03:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtjnr1dvzz1Rwt8
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 16:03:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666307021; x=1668899022; bh=LE+uK/qoTMEybIbQv0Zk753SwzykBZitfS4
        zR6YuQjU=; b=CG6neP1/go3LqnQd5gso/bZ6iAkb5mhyAbeOHhIy3zS9DXw+mYt
        CEpaNzE6qFe1lRCu0Dm6OyLObK58vg+6nK16XYaamh3rHnal9KRtaXTvO3DAtUrk
        AdiSfrqroDTamIRwffVVnbJXkk+S9JILYcpzXzGOmtWvovjXGN3otJe1etj1NpOP
        T/UKezvTDcT7UWGHw1h1plMDx0eNnRHmfnvIgEMbBqAStYaxMjibPliwMECmupzc
        6Mz6jkf74WBhj7pYbLHxZrYow/BsTcwLGbsRxgJC6DetQmLtX0ABxQBT+5+2wEXm
        PsL9HFKg1Jqf3uDiyoPbJ+OJLc/03XaD5zQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n0im3FByJfCw for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 16:03:41 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtjnm0vpJz1RvLy;
        Thu, 20 Oct 2022 16:03:39 -0700 (PDT)
Message-ID: <3213cf28-80a4-b3e5-274c-d51b1e9e04d5@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 08:03:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 11/14] pata: remove palmchip bk3710 driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-12-arnd@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221019152947.3857217-12-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/20/22 00:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This device was used only on the davinci dm644x platform that
> is now gone, and no references to the device remain in the
> kernel.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to libata tree for-6.2 branch (and for-next).
Note that I fixed-up the patch title to:

ata: remove palmchip pata_bk3710 driver

Thanks !

> ---
>  drivers/ata/Kconfig       |  10 -
>  drivers/ata/Makefile      |   1 -
>  drivers/ata/pata_bk3710.c | 380 --------------------------------------
>  3 files changed, 391 deletions(-)
>  delete mode 100644 drivers/ata/pata_bk3710.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 36833a862998..2986fc9c797e 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -609,16 +609,6 @@ config PATA_ATP867X
>  
>  	  If unsure, say N.
>  
> -config PATA_BK3710
> -	tristate "Palmchip BK3710 PATA support"
> -	depends on ARCH_DAVINCI || COMPILE_TEST
> -	select PATA_TIMINGS
> -	help
> -	  This option enables support for the integrated IDE controller on
> -	  the TI DaVinci SoC.
> -
> -	  If unsure, say N.
> -
>  config PATA_CMD64X
>  	tristate "CMD64x PATA support"
>  	depends on PCI
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 34623365d9a6..d2e36d367274 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -54,7 +54,6 @@ obj-$(CONFIG_PATA_AMD)		+= pata_amd.o
>  obj-$(CONFIG_PATA_ARTOP)	+= pata_artop.o
>  obj-$(CONFIG_PATA_ATIIXP)	+= pata_atiixp.o
>  obj-$(CONFIG_PATA_ATP867X)	+= pata_atp867x.o
> -obj-$(CONFIG_PATA_BK3710)	+= pata_bk3710.o
>  obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
>  obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
>  obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530.o
> diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> deleted file mode 100644
> index fad95cfecced..000000000000
> --- a/drivers/ata/pata_bk3710.c
> +++ /dev/null
> @@ -1,380 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -/*
> - * Palmchip BK3710 PATA controller driver
> - *
> - * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * Based on palm_bk3710.c:
> - *
> - * Copyright (C) 2006 Texas Instruments.
> - * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>
> - */
> -
> -#include <linux/ata.h>
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -#include <linux/kernel.h>
> -#include <linux/libata.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/types.h>
> -
> -#define DRV_NAME "pata_bk3710"
> -
> -#define BK3710_TF_OFFSET	0x1F0
> -#define BK3710_CTL_OFFSET	0x3F6
> -
> -#define BK3710_BMISP		0x02
> -#define BK3710_IDETIMP		0x40
> -#define BK3710_UDMACTL		0x48
> -#define BK3710_MISCCTL		0x50
> -#define BK3710_REGSTB		0x54
> -#define BK3710_REGRCVR		0x58
> -#define BK3710_DATSTB		0x5C
> -#define BK3710_DATRCVR		0x60
> -#define BK3710_DMASTB		0x64
> -#define BK3710_DMARCVR		0x68
> -#define BK3710_UDMASTB		0x6C
> -#define BK3710_UDMATRP		0x70
> -#define BK3710_UDMAENV		0x74
> -#define BK3710_IORDYTMP		0x78
> -
> -static struct scsi_host_template pata_bk3710_sht = {
> -	ATA_BMDMA_SHT(DRV_NAME),
> -};
> -
> -static unsigned int ideclk_period; /* in nanoseconds */
> -
> -struct pata_bk3710_udmatiming {
> -	unsigned int rptime;	/* tRP -- Ready to pause time (nsec) */
> -	unsigned int cycletime;	/* tCYCTYP2/2 -- avg Cycle Time (nsec) */
> -				/* tENV is always a minimum of 20 nsec */
> -};
> -
> -static const struct pata_bk3710_udmatiming pata_bk3710_udmatimings[6] = {
> -	{ 160, 240 / 2 },	/* UDMA Mode 0 */
> -	{ 125, 160 / 2 },	/* UDMA Mode 1 */
> -	{ 100, 120 / 2 },	/* UDMA Mode 2 */
> -	{ 100,  90 / 2 },	/* UDMA Mode 3 */
> -	{ 100,  60 / 2 },	/* UDMA Mode 4 */
> -	{  85,  40 / 2 },	/* UDMA Mode 5 */
> -};
> -
> -static void pata_bk3710_setudmamode(void __iomem *base, unsigned int dev,
> -				    unsigned int mode)
> -{
> -	u32 val32;
> -	u16 val16;
> -	u8 tenv, trp, t0;
> -
> -	/* DMA Data Setup */
> -	t0 = DIV_ROUND_UP(pata_bk3710_udmatimings[mode].cycletime,
> -			  ideclk_period) - 1;
> -	tenv = DIV_ROUND_UP(20, ideclk_period) - 1;
> -	trp = DIV_ROUND_UP(pata_bk3710_udmatimings[mode].rptime,
> -			   ideclk_period) - 1;
> -
> -	/* udmastb Ultra DMA Access Strobe Width */
> -	val32 = ioread32(base + BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8));
> -	val32 |= t0 << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_UDMASTB);
> -
> -	/* udmatrp Ultra DMA Ready to Pause Time */
> -	val32 = ioread32(base + BK3710_UDMATRP) & (0xFF << (dev ? 0 : 8));
> -	val32 |= trp << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_UDMATRP);
> -
> -	/* udmaenv Ultra DMA envelop Time */
> -	val32 = ioread32(base + BK3710_UDMAENV) & (0xFF << (dev ? 0 : 8));
> -	val32 |= tenv << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_UDMAENV);
> -
> -	/* Enable UDMA for Device */
> -	val16 = ioread16(base + BK3710_UDMACTL) | (1 << dev);
> -	iowrite16(val16, base + BK3710_UDMACTL);
> -}
> -
> -static void pata_bk3710_setmwdmamode(void __iomem *base, unsigned int dev,
> -				     unsigned short min_cycle,
> -				     unsigned int mode)
> -{
> -	const struct ata_timing *t;
> -	int cycletime;
> -	u32 val32;
> -	u16 val16;
> -	u8 td, tkw, t0;
> -
> -	t = ata_timing_find_mode(mode);
> -	cycletime = max_t(int, t->cycle, min_cycle);
> -
> -	/* DMA Data Setup */
> -	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
> -	td = DIV_ROUND_UP(t->active, ideclk_period);
> -	tkw = t0 - td - 1;
> -	td--;
> -
> -	val32 = ioread32(base + BK3710_DMASTB) & (0xFF << (dev ? 0 : 8));
> -	val32 |= td << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_DMASTB);
> -
> -	val32 = ioread32(base + BK3710_DMARCVR) & (0xFF << (dev ? 0 : 8));
> -	val32 |= tkw << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_DMARCVR);
> -
> -	/* Disable UDMA for Device */
> -	val16 = ioread16(base + BK3710_UDMACTL) & ~(1 << dev);
> -	iowrite16(val16, base + BK3710_UDMACTL);
> -}
> -
> -static void pata_bk3710_set_dmamode(struct ata_port *ap,
> -				    struct ata_device *adev)
> -{
> -	void __iomem *base = (void __iomem *)ap->ioaddr.bmdma_addr;
> -	int is_slave = adev->devno;
> -	const u8 xferspeed = adev->dma_mode;
> -
> -	if (xferspeed >= XFER_UDMA_0)
> -		pata_bk3710_setudmamode(base, is_slave,
> -					xferspeed - XFER_UDMA_0);
> -	else
> -		pata_bk3710_setmwdmamode(base, is_slave,
> -					 adev->id[ATA_ID_EIDE_DMA_MIN],
> -					 xferspeed);
> -}
> -
> -static void pata_bk3710_setpiomode(void __iomem *base, struct ata_device *pair,
> -				   unsigned int dev, unsigned int cycletime,
> -				   unsigned int mode)
> -{
> -	const struct ata_timing *t;
> -	u32 val32;
> -	u8 t2, t2i, t0;
> -
> -	t = ata_timing_find_mode(XFER_PIO_0 + mode);
> -
> -	/* PIO Data Setup */
> -	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
> -	t2 = DIV_ROUND_UP(t->active, ideclk_period);
> -
> -	t2i = t0 - t2 - 1;
> -	t2--;
> -
> -	val32 = ioread32(base + BK3710_DATSTB) & (0xFF << (dev ? 0 : 8));
> -	val32 |= t2 << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_DATSTB);
> -
> -	val32 = ioread32(base + BK3710_DATRCVR) & (0xFF << (dev ? 0 : 8));
> -	val32 |= t2i << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_DATRCVR);
> -
> -	/* FIXME: this is broken also in the old driver */
> -	if (pair) {
> -		u8 mode2 = pair->pio_mode - XFER_PIO_0;
> -
> -		if (mode2 < mode)
> -			mode = mode2;
> -	}
> -
> -	/* TASKFILE Setup */
> -	t0 = DIV_ROUND_UP(t->cyc8b, ideclk_period);
> -	t2 = DIV_ROUND_UP(t->act8b, ideclk_period);
> -
> -	t2i = t0 - t2 - 1;
> -	t2--;
> -
> -	val32 = ioread32(base + BK3710_REGSTB) & (0xFF << (dev ? 0 : 8));
> -	val32 |= t2 << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_REGSTB);
> -
> -	val32 = ioread32(base + BK3710_REGRCVR) & (0xFF << (dev ? 0 : 8));
> -	val32 |= t2i << (dev ? 8 : 0);
> -	iowrite32(val32, base + BK3710_REGRCVR);
> -}
> -
> -static void pata_bk3710_set_piomode(struct ata_port *ap,
> -				    struct ata_device *adev)
> -{
> -	void __iomem *base = (void __iomem *)ap->ioaddr.bmdma_addr;
> -	struct ata_device *pair = ata_dev_pair(adev);
> -	const struct ata_timing *t = ata_timing_find_mode(adev->pio_mode);
> -	const u16 *id = adev->id;
> -	unsigned int cycle_time = 0;
> -	int is_slave = adev->devno;
> -	const u8 pio = adev->pio_mode - XFER_PIO_0;
> -
> -	if (id[ATA_ID_FIELD_VALID] & 2) {
> -		if (ata_id_has_iordy(id))
> -			cycle_time = id[ATA_ID_EIDE_PIO_IORDY];
> -		else
> -			cycle_time = id[ATA_ID_EIDE_PIO];
> -
> -		/* conservative "downgrade" for all pre-ATA2 drives */
> -		if (pio < 3 && cycle_time < t->cycle)
> -			cycle_time = 0; /* use standard timing */
> -	}
> -
> -	if (!cycle_time)
> -		cycle_time = t->cycle;
> -
> -	pata_bk3710_setpiomode(base, pair, is_slave, cycle_time, pio);
> -}
> -
> -static void pata_bk3710_chipinit(void __iomem *base)
> -{
> -	/*
> -	 * REVISIT:  the ATA reset signal needs to be managed through a
> -	 * GPIO, which means it should come from platform_data.  Until
> -	 * we get and use such information, we have to trust that things
> -	 * have been reset before we get here.
> -	 */
> -
> -	/*
> -	 * Program the IDETIMP Register Value based on the following assumptions
> -	 *
> -	 * (ATA_IDETIMP_IDEEN		, ENABLE ) |
> -	 * (ATA_IDETIMP_PREPOST1	, DISABLE) |
> -	 * (ATA_IDETIMP_PREPOST0	, DISABLE) |
> -	 *
> -	 * DM6446 silicon rev 2.1 and earlier have no observed net benefit
> -	 * from enabling prefetch/postwrite.
> -	 */
> -	iowrite16(BIT(15), base + BK3710_IDETIMP);
> -
> -	/*
> -	 * UDMACTL Ultra-ATA DMA Control
> -	 * (ATA_UDMACTL_UDMAP1	, 0 ) |
> -	 * (ATA_UDMACTL_UDMAP0	, 0 )
> -	 *
> -	 */
> -	iowrite16(0, base + BK3710_UDMACTL);
> -
> -	/*
> -	 * MISCCTL Miscellaneous Conrol Register
> -	 * (ATA_MISCCTL_HWNHLD1P	, 1 cycle)
> -	 * (ATA_MISCCTL_HWNHLD0P	, 1 cycle)
> -	 * (ATA_MISCCTL_TIMORIDE	, 1)
> -	 */
> -	iowrite32(0x001, base + BK3710_MISCCTL);
> -
> -	/*
> -	 * IORDYTMP IORDY Timer for Primary Register
> -	 * (ATA_IORDYTMP_IORDYTMP	, DISABLE)
> -	 */
> -	iowrite32(0, base + BK3710_IORDYTMP);
> -
> -	/*
> -	 * Configure BMISP Register
> -	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
> -	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
> -	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
> -	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
> -	 * (ATA_BMISP_DMAERROR	, CLEAR)
> -	 */
> -	iowrite16(0xE, base + BK3710_BMISP);
> -
> -	pata_bk3710_setpiomode(base, NULL, 0, 600, 0);
> -	pata_bk3710_setpiomode(base, NULL, 1, 600, 0);
> -}
> -
> -static struct ata_port_operations pata_bk3710_ports_ops = {
> -	.inherits		= &ata_bmdma_port_ops,
> -	.cable_detect		= ata_cable_80wire,
> -
> -	.set_piomode		= pata_bk3710_set_piomode,
> -	.set_dmamode		= pata_bk3710_set_dmamode,
> -};
> -
> -static int __init pata_bk3710_probe(struct platform_device *pdev)
> -{
> -	struct clk *clk;
> -	struct resource *mem;
> -	struct ata_host *host;
> -	struct ata_port *ap;
> -	void __iomem *base;
> -	unsigned long rate;
> -	int irq;
> -
> -	clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk))
> -		return -ENODEV;
> -
> -	clk_enable(clk);
> -	rate = clk_get_rate(clk);
> -	if (!rate)
> -		return -EINVAL;
> -
> -	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
> -	ideclk_period = 1000000000UL / rate;
> -
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		pr_err(DRV_NAME ": failed to get IRQ resource\n");
> -		return irq;
> -	}
> -
> -	base = devm_ioremap_resource(&pdev->dev, mem);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> -
> -	/* configure the Palmchip controller */
> -	pata_bk3710_chipinit(base);
> -
> -	/* allocate host */
> -	host = ata_host_alloc(&pdev->dev, 1);
> -	if (!host)
> -		return -ENOMEM;
> -	ap = host->ports[0];
> -
> -	ap->ops = &pata_bk3710_ports_ops;
> -	ap->pio_mask = ATA_PIO4;
> -	ap->mwdma_mask = ATA_MWDMA2;
> -	ap->udma_mask = rate < 100000000 ? ATA_UDMA4 : ATA_UDMA5;
> -	ap->flags |= ATA_FLAG_SLAVE_POSS;
> -
> -	ap->ioaddr.data_addr		= base + BK3710_TF_OFFSET;
> -	ap->ioaddr.error_addr		= base + BK3710_TF_OFFSET + 1;
> -	ap->ioaddr.feature_addr		= base + BK3710_TF_OFFSET + 1;
> -	ap->ioaddr.nsect_addr		= base + BK3710_TF_OFFSET + 2;
> -	ap->ioaddr.lbal_addr		= base + BK3710_TF_OFFSET + 3;
> -	ap->ioaddr.lbam_addr		= base + BK3710_TF_OFFSET + 4;
> -	ap->ioaddr.lbah_addr		= base + BK3710_TF_OFFSET + 5;
> -	ap->ioaddr.device_addr		= base + BK3710_TF_OFFSET + 6;
> -	ap->ioaddr.status_addr		= base + BK3710_TF_OFFSET + 7;
> -	ap->ioaddr.command_addr		= base + BK3710_TF_OFFSET + 7;
> -
> -	ap->ioaddr.altstatus_addr	= base + BK3710_CTL_OFFSET;
> -	ap->ioaddr.ctl_addr		= base + BK3710_CTL_OFFSET;
> -
> -	ap->ioaddr.bmdma_addr		= base;
> -
> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -		      (unsigned long)base + BK3710_TF_OFFSET,
> -		      (unsigned long)base + BK3710_CTL_OFFSET);
> -
> -	/* activate */
> -	return ata_host_activate(host, irq, ata_sff_interrupt, 0,
> -				 &pata_bk3710_sht);
> -}
> -
> -/* work with hotplug and coldplug */
> -MODULE_ALIAS("platform:palm_bk3710");
> -
> -static struct platform_driver pata_bk3710_driver = {
> -	.driver = {
> -		.name = "palm_bk3710",
> -	},
> -};
> -
> -static int __init pata_bk3710_init(void)
> -{
> -	return platform_driver_probe(&pata_bk3710_driver, pata_bk3710_probe);
> -}
> -
> -module_init(pata_bk3710_init);
> -MODULE_LICENSE("GPL v2");

-- 
Damien Le Moal
Western Digital Research

