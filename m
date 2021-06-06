Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62166C4743F
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F9D61408
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 21:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFFVMi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 17:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFFVMh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 17:12:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C145C061766;
        Sun,  6 Jun 2021 14:10:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so9150700pja.2;
        Sun, 06 Jun 2021 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=U5YCqPSM8EZuZ77KqdjQ6N49rIinfL8il+ZtV1WOMfc=;
        b=SWY8/edoGC9srPEEppddK+1VQ/OKoJzBSIRy/2ZM1mvSHatcNJx7gCNycBjTNINAwD
         qGyrcSabORb/ejYGL61s1UToq371FROxsXZaMABz5RWD8kcx73wxWVXIjjrzXKxX442U
         7fjWxr5cjAvfqalTncVDb0gQGRW/d+z8PY1t0DbJnwcDNsEttecSWSCfyy9hF/ZOGcH1
         KyQ36DgHfkyIBYTS3rNJylMwzLZaYf6u/Ux8D3zicyNo6zrglFw0rddeYSZdKD48bnta
         mn5M6gJS/P44Oyv8Qd+c2xkaVc87KftN6twaKV4Rqdbps03G2vDg/BXH+7DsXv9376HA
         zdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=U5YCqPSM8EZuZ77KqdjQ6N49rIinfL8il+ZtV1WOMfc=;
        b=kN1xzzZxN0RUQPjXNobyRiIrA/zAG5y8oird4ONLQjms6xIDy2s4l6skXoQIVY+af9
         B79r944mCTCc//kK+53ghy5Nww8ia0+/yONgP+BopovYWvjnyCvDKSGTEIKwBFf3T5Dt
         vuj7CMpwqcKjHMg4mFQ2KCqbmonbF+E5zQoqlXVJMbwhs17mfnTx63Axj6Jo1Yg1QbL3
         cOV1DkcsT8Pcb4dCCqRdrcMF41ryZHUpBILv1tfFWiG9N3td50OVDX4Ij6rLb9mnTPkx
         Rrp9WE69H8qz711b+0oTh5/Whxx/QP4FnTcUlPRQyloP88l8nNogFoLBKCjOv/w41dQ7
         +ZRQ==
X-Gm-Message-State: AOAM532PgS/bhnxTxUlTvXxSDaI2oLGVfAW0aF687Cfr/Yc+LxqwbrI7
        Hzxh8qV8q+Jc99kUGLhOKmTCSeVltnakfg==
X-Google-Smtp-Source: ABdhPJx1hu0YONLpw5YUWPAeWCn46+0cxovMl8QiVF2yFDF8H5B47hest8UL1FymWapN03bUVkBfag==
X-Received: by 2002:a17:902:bd09:b029:ec:7e58:a54a with SMTP id p9-20020a170902bd09b02900ec7e58a54amr15320081pls.62.1623013832013;
        Sun, 06 Jun 2021 14:10:32 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id e6sm10678437pjl.3.2021.06.06.14.10.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jun 2021 14:10:31 -0700 (PDT)
Subject: Re: [PATCH] m68k/q40: Replace q40ide with pata_falcon and falconide
To:     Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <352239036981177050c296ca3deb84a102d9faa2.1622970906.git.fthain@linux-m68k.org>
Cc:     Richard Zidlicky <rz@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e250cffb-9edd-1b84-3826-58079758b35a@gmail.com>
Date:   Mon, 7 Jun 2021 09:10:24 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <352239036981177050c296ca3deb84a102d9faa2.1622970906.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

are there any substantial changes from what I'd tested before? Your 
patch conflicts with (I think) the Mac IDE patches now in Geert's tree, 
and I'd rather avoid hand-patching the lot if at all possible:

m68k_q40_Replace_q40ide_with_pata_falcon_and_falconide
Applying: m68k/q40: Replace q40ide with pata_falcon and falconide
error: patch failed: arch/m68k/configs/multi_defconfig:351
error: arch/m68k/configs/multi_defconfig: patch does not apply
error: patch failed: drivers/ide/Kconfig:731
error: drivers/ide/Kconfig: patch does not apply
error: patch failed: drivers/ide/Makefile:29
error: drivers/ide/Makefile: patch does not apply

What's your baseline for this patch?

(In the alternative: just add my Tested-by if nothing changed aside from 
the IO region reservation)

Cheers,

	Michael


Am 06.06.2021 um 21:15 schrieb Finn Thain:
> Replace the q40ide driver with falconide and pata_falcon platform
> drivers. This allows q40 machines to migrate from the deprecated IDE
> subsystem to libata.
>
> Enhance the byte-swapping falconide and pata_falcon platform drivers to
> accept an irq resource, for use on q40. Atari ST-DMA IRQ arrangements seem
> to co-exist with q40 IRQ arrangements without too much mess.
>
> The new IO resources were added solely for the purpose of making
> request_region() reservations identical to those made by q40ide: these
> regions aren't used for actual IO.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Richard Zidlicky <rz@linux-m68k.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Note that q40ide, falconide and pata_falcon all use the same accessors
> (raw_insw_swapw, raw_insw, raw_outsw_swapw, raw_outsw) and hence all
> three drivers are affected by the bug relating to CONFIG_ISA and
> CONFIG_ATARI_ROM_ISA which Michael has been working on recently.
> This patch doesn't make that issue any better or worse.
> ---
>  arch/m68k/atari/config.c          |  12 +--
>  arch/m68k/configs/multi_defconfig |   1 -
>  arch/m68k/configs/q40_defconfig   |   2 +-
>  arch/m68k/q40/config.c            |  37 +++++--
>  drivers/ata/Kconfig               |   6 +-
>  drivers/ata/pata_falcon.c         |  62 ++++++++---
>  drivers/ide/Kconfig               |  18 +---
>  drivers/ide/Makefile              |   1 -
>  drivers/ide/falconide.c           |  75 ++++++++-----
>  drivers/ide/q40ide.c              | 168 ------------------------------
>  10 files changed, 137 insertions(+), 245 deletions(-)
>  delete mode 100644 drivers/ide/q40ide.c
>
> diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
> index 44f9b5216ac9..261a0f57cc9a 100644
> --- a/arch/m68k/atari/config.c
> +++ b/arch/m68k/atari/config.c
> @@ -875,16 +875,8 @@ static const struct resource atari_scsi_tt_rsrc[] __initconst = {
>  #define FALCON_IDE_BASE	0xfff00000
>
>  static const struct resource atari_falconide_rsrc[] __initconst = {
> -	{
> -		.flags = IORESOURCE_MEM,
> -		.start = FALCON_IDE_BASE,
> -		.end   = FALCON_IDE_BASE + 0x39,
> -	},
> -	{
> -		.flags = IORESOURCE_IRQ,
> -		.start = IRQ_MFP_FSCSI,
> -		.end   = IRQ_MFP_FSCSI,
> -	},
> +	DEFINE_RES_MEM(FALCON_IDE_BASE, 0x38),
> +	DEFINE_RES_MEM(FALCON_IDE_BASE + 0x38, 2),
>  };
>
>  int __init atari_platform_init(void)
> diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
> index 9ee6d2b4d1f4..f4cafed671cb 100644
> --- a/arch/m68k/configs/multi_defconfig
> +++ b/arch/m68k/configs/multi_defconfig
> @@ -351,7 +351,6 @@ CONFIG_BLK_DEV_PLATFORM=y
>  CONFIG_BLK_DEV_GAYLE=y
>  CONFIG_BLK_DEV_BUDDHA=y
>  CONFIG_BLK_DEV_FALCON_IDE=y
> -CONFIG_BLK_DEV_Q40IDE=y
>  CONFIG_RAID_ATTRS=m
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
> diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
> index 3ae421cb24a4..2c25b4096397 100644
> --- a/arch/m68k/configs/q40_defconfig
> +++ b/arch/m68k/configs/q40_defconfig
> @@ -317,7 +317,7 @@ CONFIG_DUMMY_IRQ=m
>  CONFIG_IDE=y
>  CONFIG_IDE_GD_ATAPI=y
>  CONFIG_BLK_DEV_IDECD=y
> -CONFIG_BLK_DEV_Q40IDE=y
> +CONFIG_BLK_DEV_FALCON_IDE=y
>  CONFIG_RAID_ATTRS=m
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
> diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
> index d6a423875231..5caf1e5be1c2 100644
> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c
> @@ -286,14 +286,39 @@ static int q40_set_rtc_pll(struct rtc_pll_info *pll)
>  		return -EINVAL;
>  }
>
> -static __init int q40_add_kbd_device(void)
> -{
> -	struct platform_device *pdev;
> +#define PCIDE_BASE1	0x1f0
> +#define PCIDE_BASE2	0x170
> +#define PCIDE_CTL	0x206
> +
> +static const struct resource q40_pata_rsrc_0[] __initconst = {
> +	DEFINE_RES_MEM(q40_isa_io_base + PCIDE_BASE1 * 4, 0x38),
> +	DEFINE_RES_MEM(q40_isa_io_base + (PCIDE_BASE1 + PCIDE_CTL) * 4, 2),
> +	DEFINE_RES_IO(PCIDE_BASE1, 8),
> +	DEFINE_RES_IO(PCIDE_BASE1 + PCIDE_CTL, 1),
> +	DEFINE_RES_IRQ(14),
> +};
>
> +static const struct resource q40_pata_rsrc_1[] __initconst = {
> +	DEFINE_RES_MEM(q40_isa_io_base + PCIDE_BASE2 * 4, 0x38),
> +	DEFINE_RES_MEM(q40_isa_io_base + (PCIDE_BASE2 + PCIDE_CTL) * 4, 2),
> +	DEFINE_RES_IO(PCIDE_BASE2, 8),
> +	DEFINE_RES_IO(PCIDE_BASE2 + PCIDE_CTL, 1),
> +	DEFINE_RES_IRQ(15),
> +};
> +
> +static __init int q40_platform_init(void)
> +{
>  	if (!MACH_IS_Q40)
>  		return -ENODEV;
>
> -	pdev = platform_device_register_simple("q40kbd", -1, NULL, 0);
> -	return PTR_ERR_OR_ZERO(pdev);
> +	platform_device_register_simple("q40kbd", -1, NULL, 0);
> +
> +	platform_device_register_simple("atari-falcon-ide", 0, q40_pata_rsrc_0,
> +					ARRAY_SIZE(q40_pata_rsrc_0));
> +
> +	platform_device_register_simple("atari-falcon-ide", 1, q40_pata_rsrc_1,
> +					ARRAY_SIZE(q40_pata_rsrc_1));
> +
> +	return 0;
>  }
> -arch_initcall(q40_add_kbd_device);
> +arch_initcall(q40_platform_init);
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 030cb32da980..b7a5abee2147 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1015,11 +1015,11 @@ config PATA_CMD640_PCI
>  	  If unsure, say N.
>
>  config PATA_FALCON
> -	tristate "Atari Falcon PATA support"
> -	depends on M68K && ATARI
> +	tristate "Atari Falcon and Q40/Q60 PATA support"
> +	depends on M68K && (ATARI || Q40)
>  	help
>  	  This option enables support for the on-board IDE
> -	  interface on the Atari Falcon.
> +	  interface on the Atari Falcon and Q40/Q60.
>
>  	  If unsure, say N.
>
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 27b0952fde6b..9d0dd8f4c21c 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -33,8 +33,6 @@
>  #define DRV_NAME "pata_falcon"
>  #define DRV_VERSION "0.1.0"
>
> -#define ATA_HD_CONTROL	0x39
> -
>  static struct scsi_host_template pata_falcon_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
> @@ -121,23 +119,42 @@ static struct ata_port_operations pata_falcon_ops = {
>
>  static int __init pata_falcon_init_one(struct platform_device *pdev)
>  {
> -	struct resource *res;
> +	struct resource *base_mem_res, *ctl_mem_res;
> +	struct resource *base_res, *ctl_res, *irq_res;
>  	struct ata_host *host;
>  	struct ata_port *ap;
>  	void __iomem *base;
> +	int irq = 0;
>
> -	dev_info(&pdev->dev, "Atari Falcon PATA controller\n");
> +	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> +	base_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (base_res && !devm_request_region(&pdev->dev, base_res->start,
> +					   resource_size(base_res), DRV_NAME)) {
> +		dev_err(&pdev->dev, "resources busy\n");
> +		return -EBUSY;
> +	}
>
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), DRV_NAME)) {
> +	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
> +	if (ctl_res && !devm_request_region(&pdev->dev, ctl_res->start,
> +					    resource_size(ctl_res), DRV_NAME)) {
>  		dev_err(&pdev->dev, "resources busy\n");
>  		return -EBUSY;
>  	}
>
> +	base_mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!base_mem_res)
> +		return -ENODEV;
> +	if (!devm_request_mem_region(&pdev->dev, base_mem_res->start,
> +				     resource_size(base_mem_res), DRV_NAME)) {
> +		dev_err(&pdev->dev, "resources busy\n");
> +		return -EBUSY;
> +	}
> +
> +	ctl_mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!ctl_mem_res)
> +		return -ENODEV;
> +
>  	/* allocate host */
>  	host = ata_host_alloc(&pdev->dev, 1);
>  	if (!host)
> @@ -147,10 +164,10 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->ops = &pata_falcon_ops;
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
> -	ap->flags |= ATA_FLAG_PIO_POLLING;
>
> -	base = (void __iomem *)res->start;
> -	ap->ioaddr.data_addr		= base;
> +	base = (void __iomem *)base_mem_res->start;
> +	/* N.B. this assumes data_addr will be used for word-sized I/O only */
> +	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
>  	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
>  	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
>  	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
> @@ -161,14 +178,25 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
>  	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
>
> -	ap->ioaddr.altstatus_addr	= base + ATA_HD_CONTROL;
> -	ap->ioaddr.ctl_addr		= base + ATA_HD_CONTROL;
> +	base = (void __iomem *)ctl_mem_res->start;
> +	ap->ioaddr.altstatus_addr	= base + 1;
> +	ap->ioaddr.ctl_addr		= base + 1;
>
> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> -		      (unsigned long)base + ATA_HD_CONTROL);
> +	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> +		      (unsigned long)base_mem_res->start,
> +		      (unsigned long)ctl_mem_res->start);
> +
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (irq_res && irq_res->start > 0) {
> +		irq = irq_res->start;
> +	} else {
> +		ap->flags |= ATA_FLAG_PIO_POLLING;
> +		ata_port_desc(ap, "no IRQ, using PIO polling");
> +	}
>
>  	/* activate */
> -	return ata_host_activate(host, 0, NULL, 0, &pata_falcon_sht);
> +	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
> +				 IRQF_SHARED, &pata_falcon_sht);
>  }
>
>  static int __exit pata_falcon_remove_one(struct platform_device *pdev)
> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index 8ce4a5878d0c..8af1ac69e5f8 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -731,21 +731,13 @@ config BLK_DEV_BUDDHA
>  	  to one of its IDE interfaces.
>
>  config BLK_DEV_FALCON_IDE
> -	tristate "Falcon IDE interface support"
> -	depends on ATARI
> +	tristate "Falcon and Q40/Q60 IDE interface support"
> +	depends on ATARI || Q40
>  	help
>  	  This is the IDE driver for the on-board IDE interface on the Atari
> -	  Falcon. Say Y if you have a Falcon and want to use IDE devices (hard
> -	  disks, CD-ROM drives, etc.) that are connected to the on-board IDE
> -	  interface.
> -
> -config BLK_DEV_Q40IDE
> -	tristate "Q40/Q60 IDE interface support"
> -	depends on Q40
> -	help
> -	  Enable the on-board IDE controller in the Q40/Q60.  This should
> -	  normally be on; disable it only if you are running a custom hard
> -	  drive subsystem through an expansion card.
> +	  Falcon and Q40/Q60. Say Y if you have such a machine and want to use
> +	  IDE devices (hard disks, CD-ROM drives, etc.) that are connected to
> +	  the on-board IDE interface.
>
>  config BLK_DEV_PALMCHIP_BK3710
>  	tristate "Palmchip bk3710 IDE controller support"
> diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
> index 45a1c0463bed..991eb72a786b 100644
> --- a/drivers/ide/Makefile
> +++ b/drivers/ide/Makefile
> @@ -29,7 +29,6 @@ obj-$(CONFIG_BLK_DEV_4DRIVES)		+= ide-4drives.o
>
>  obj-$(CONFIG_BLK_DEV_GAYLE)		+= gayle.o
>  obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
> -obj-$(CONFIG_BLK_DEV_Q40IDE)		+= q40ide.o
>  obj-$(CONFIG_BLK_DEV_BUDDHA)		+= buddha.o
>
>  obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
> diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
> index bb86d84558d9..fce68412b3c9 100644
> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -25,12 +25,6 @@
>
>  #define DRV_NAME "falconide"
>
> -    /*
> -     *  Offsets from base address
> -     */
> -
> -#define ATA_HD_CONTROL	0x39
> -
>      /*
>       *  falconide_intr_lock is used to obtain access to the IDE interrupt,
>       *  which is shared between several drivers.
> @@ -107,7 +101,8 @@ static const struct ide_port_info falconide_port_info = {
>  	.chipset		= ide_generic,
>  };
>
> -static void __init falconide_setup_ports(struct ide_hw *hw, unsigned long base)
> +static void __init falconide_setup_ports(struct ide_hw *hw, unsigned long base,
> +					 unsigned long ctl, int irq)
>  {
>  	int i;
>
> @@ -118,9 +113,9 @@ static void __init falconide_setup_ports(struct ide_hw *hw, unsigned long base)
>  	for (i = 1; i < 8; i++)
>  		hw->io_ports_array[i] = base + 1 + i * 4;
>
> -	hw->io_ports.ctl_addr = base + ATA_HD_CONTROL;
> +	hw->io_ports.ctl_addr = ctl + 1;
>
> -	hw->irq = IRQ_MFP_IDE;
> +	hw->irq = irq;
>  }
>
>      /*
> @@ -129,37 +124,69 @@ static void __init falconide_setup_ports(struct ide_hw *hw, unsigned long base)
>
>  static int __init falconide_init(struct platform_device *pdev)
>  {
> -	struct resource *res;
> +	struct resource *base_mem_res, *ctl_mem_res;
> +	struct resource *base_res, *ctl_res, *irq_res;
>  	struct ide_host *host;
>  	struct ide_hw hw, *hws[] = { &hw };
> -	unsigned long base;
>  	int rc;
> +	int irq;
> +
> +	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 IDE controller\n");
> +
> +	base_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (base_res && !devm_request_region(&pdev->dev, base_res->start,
> +					   resource_size(base_res), DRV_NAME)) {
> +		dev_err(&pdev->dev, "resources busy\n");
> +		return -EBUSY;
> +	}
>
> -	dev_info(&pdev->dev, "Atari Falcon IDE controller\n");
> +	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (ctl_res && !devm_request_region(&pdev->dev, ctl_res->start,
> +					   resource_size(ctl_res), DRV_NAME)) {
> +		dev_err(&pdev->dev, "resources busy\n");
> +		return -EBUSY;
> +	}
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> +	base_mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!base_mem_res)
>  		return -ENODEV;
>
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), DRV_NAME)) {
> +	if (!devm_request_mem_region(&pdev->dev, base_mem_res->start,
> +				     resource_size(base_mem_res), DRV_NAME)) {
>  		dev_err(&pdev->dev, "resources busy\n");
>  		return -EBUSY;
>  	}
>
> -	base = (unsigned long)res->start;
> +	ctl_mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!ctl_mem_res)
> +		return -ENODEV;
> +
> +	if (MACH_IS_ATARI) {
> +		irq = IRQ_MFP_IDE;
> +	} else {
> +		irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +		if (irq_res && irq_res->start > 0)
> +			irq = irq_res->start;
> +		else
> +			return -ENODEV;
> +	}
>
> -	falconide_setup_ports(&hw, base);
> +	falconide_setup_ports(&hw, base_mem_res->start, ctl_mem_res->start, irq);
>
>  	host = ide_host_alloc(&falconide_port_info, hws, 1);
> -	if (host == NULL) {
> -		rc = -ENOMEM;
> -		goto err;
> +	if (!host)
> +		return -ENOMEM;
> +
> +	if (!MACH_IS_ATARI) {
> +		host->get_lock = NULL;
> +		host->release_lock = NULL;
>  	}
>
> -	falconide_get_lock(NULL, NULL);
> +	if (host->get_lock)
> +		host->get_lock(NULL, NULL);
>  	rc = ide_host_register(host, &falconide_port_info, hws);
> -	falconide_release_lock();
> +	if (host->release_lock)
> +		host->release_lock();
>
>  	if (rc)
>  		goto err_free;
> @@ -168,8 +195,6 @@ static int __init falconide_init(struct platform_device *pdev)
>  	return 0;
>  err_free:
>  	ide_host_free(host);
> -err:
> -	release_mem_region(res->start, resource_size(res));
>  	return rc;
>  }
>
> diff --git a/drivers/ide/q40ide.c b/drivers/ide/q40ide.c
> deleted file mode 100644
> index ecd0a69245f6..000000000000
> --- a/drivers/ide/q40ide.c
> +++ /dev/null
> @@ -1,168 +0,0 @@
> -/*
> - *  Q40 I/O port IDE Driver
> - *
> - *     (c) Richard Zidlicky
> - *
> - *  This file is subject to the terms and conditions of the GNU General Public
> - *  License.  See the file COPYING in the main directory of this archive for
> - *  more details.
> - *
> - *
> - */
> -
> -#include <linux/types.h>
> -#include <linux/mm.h>
> -#include <linux/interrupt.h>
> -#include <linux/blkdev.h>
> -#include <linux/ide.h>
> -#include <linux/module.h>
> -
> -#include <asm/ide.h>
> -
> -    /*
> -     *  Bases of the IDE interfaces
> -     */
> -
> -#define Q40IDE_NUM_HWIFS	2
> -
> -#define PCIDE_BASE1	0x1f0
> -#define PCIDE_BASE2	0x170
> -#define PCIDE_BASE3	0x1e8
> -#define PCIDE_BASE4	0x168
> -#define PCIDE_BASE5	0x1e0
> -#define PCIDE_BASE6	0x160
> -
> -static const unsigned long pcide_bases[Q40IDE_NUM_HWIFS] = {
> -    PCIDE_BASE1, PCIDE_BASE2, /* PCIDE_BASE3, PCIDE_BASE4  , PCIDE_BASE5,
> -    PCIDE_BASE6 */
> -};
> -
> -static int q40ide_default_irq(unsigned long base)
> -{
> -           switch (base) {
> -	            case 0x1f0: return 14;
> -		    case 0x170: return 15;
> -		    case 0x1e8: return 11;
> -		    default:
> -			return 0;
> -	   }
> -}
> -
> -
> -/*
> - * Addresses are pretranslated for Q40 ISA access.
> - */
> -static void q40_ide_setup_ports(struct ide_hw *hw, unsigned long base, int irq)
> -{
> -	memset(hw, 0, sizeof(*hw));
> -	/* BIG FAT WARNING:
> -	   assumption: only DATA port is ever used in 16 bit mode */
> -	hw->io_ports.data_addr = Q40_ISA_IO_W(base);
> -	hw->io_ports.error_addr = Q40_ISA_IO_B(base + 1);
> -	hw->io_ports.nsect_addr = Q40_ISA_IO_B(base + 2);
> -	hw->io_ports.lbal_addr = Q40_ISA_IO_B(base + 3);
> -	hw->io_ports.lbam_addr = Q40_ISA_IO_B(base + 4);
> -	hw->io_ports.lbah_addr = Q40_ISA_IO_B(base + 5);
> -	hw->io_ports.device_addr = Q40_ISA_IO_B(base + 6);
> -	hw->io_ports.status_addr = Q40_ISA_IO_B(base + 7);
> -	hw->io_ports.ctl_addr = Q40_ISA_IO_B(base + 0x206);
> -
> -	hw->irq = irq;
> -}
> -
> -static void q40ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
> -			      void *buf, unsigned int len)
> -{
> -	unsigned long data_addr = drive->hwif->io_ports.data_addr;
> -
> -	if (drive->media == ide_disk && cmd && (cmd->tf_flags & IDE_TFLAG_FS)) {
> -		__ide_mm_insw(data_addr, buf, (len + 1) / 2);
> -		return;
> -	}
> -
> -	raw_insw_swapw((u16 *)data_addr, buf, (len + 1) / 2);
> -}
> -
> -static void q40ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
> -			       void *buf, unsigned int len)
> -{
> -	unsigned long data_addr = drive->hwif->io_ports.data_addr;
> -
> -	if (drive->media == ide_disk && cmd && (cmd->tf_flags & IDE_TFLAG_FS)) {
> -		__ide_mm_outsw(data_addr, buf, (len + 1) / 2);
> -		return;
> -	}
> -
> -	raw_outsw_swapw((u16 *)data_addr, buf, (len + 1) / 2);
> -}
> -
> -/* Q40 has a byte-swapped IDE interface */
> -static const struct ide_tp_ops q40ide_tp_ops = {
> -	.exec_command		= ide_exec_command,
> -	.read_status		= ide_read_status,
> -	.read_altstatus		= ide_read_altstatus,
> -	.write_devctl		= ide_write_devctl,
> -
> -	.dev_select		= ide_dev_select,
> -	.tf_load		= ide_tf_load,
> -	.tf_read		= ide_tf_read,
> -
> -	.input_data		= q40ide_input_data,
> -	.output_data		= q40ide_output_data,
> -};
> -
> -static const struct ide_port_info q40ide_port_info = {
> -	.tp_ops			= &q40ide_tp_ops,
> -	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
> -	.irq_flags		= IRQF_SHARED,
> -	.chipset		= ide_generic,
> -};
> -
> -/*
> - * the static array is needed to have the name reported in /proc/ioports,
> - * hwif->name unfortunately isn't available yet
> - */
> -static const char *q40_ide_names[Q40IDE_NUM_HWIFS]={
> -	"ide0", "ide1"
> -};
> -
> -/*
> - *  Probe for Q40 IDE interfaces
> - */
> -
> -static int __init q40ide_init(void)
> -{
> -    int i;
> -    struct ide_hw hw[Q40IDE_NUM_HWIFS], *hws[] = { NULL, NULL };
> -
> -    if (!MACH_IS_Q40)
> -      return -ENODEV;
> -
> -    printk(KERN_INFO "ide: Q40 IDE controller\n");
> -
> -    for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
> -	const char *name = q40_ide_names[i];
> -
> -	if (!request_region(pcide_bases[i], 8, name)) {
> -		printk("could not reserve ports %lx-%lx for %s\n",
> -		       pcide_bases[i],pcide_bases[i]+8,name);
> -		continue;
> -	}
> -	if (!request_region(pcide_bases[i]+0x206, 1, name)) {
> -		printk("could not reserve port %lx for %s\n",
> -		       pcide_bases[i]+0x206,name);
> -		release_region(pcide_bases[i], 8);
> -		continue;
> -	}
> -	q40_ide_setup_ports(&hw[i], pcide_bases[i],
> -			q40ide_default_irq(pcide_bases[i]));
> -
> -	hws[i] = &hw[i];
> -    }
> -
> -    return ide_host_add(&q40ide_port_info, hws, Q40IDE_NUM_HWIFS, NULL);
> -}
> -
> -module_init(q40ide_init);
> -
> -MODULE_LICENSE("GPL");
>
