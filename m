From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Wed, 6 Feb 2008 02:35:54 +0100
Message-ID: <200802060235.54530.bzolnier@gmail.com>
References: <200802051904.42668.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:24351 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757888AbYBFCAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 21:00:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so318789ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 05 Feb 2008 18:00:53 -0800 (PST)
In-Reply-To: <200802051904.42668.asalnikov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 05 February 2008, Anton Salnikov wrote:
> I've tested the driver on 2.6.24.
> 
> I've made the changes you asked for. But when I tested them on arm/mach-davinci 

Thanks!

> architecture on the current Linus' git there was link error undefined reference 
> to symbol ide_hwif_setup_dma().
> However on x86_64 architecture it compiles well without any warnings with 
> respect to link error of undefined clk_get() clk_enable() clk_get_rate(), which 
> are not present in this architecture.

ide_hwif_setup_dma() comes from setup-pci.c which depends on BLK_DEV_IDEPCI.
palm_bk3710 host driver selects BLK_DEV_IDEDMA_PCI which should also select
BLK_DEV_IDEPCI but PCI doesn't even seem to be supported by this ARM platform.

I (hopefully) workarounded the issue by adding an additional #ifdef to
<linux/ide.h> but it is a unmaintanable and ugly hack:

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1014,7 +1014,8 @@ extern int __ide_pci_register_driver(str
 void ide_pci_setup_ports(struct pci_dev *, const struct ide_port_info *, int, u8 *);
 void ide_setup_pci_noise(struct pci_dev *, const struct ide_port_info *);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+/* FIXME: palm_bk3710 uses BLK_DEV_IDEDMA_PCI without BLK_DEV_IDEPCI! */
+#if defined(CONFIG_BLK_DEV_IDEPCI) && defined(CONFIG_BLK_DEV_IDEDMA_PCI)
 void ide_hwif_setup_dma(ide_hwif_t *, const struct ide_port_info *);
 #else
 static inline void ide_hwif_setup_dma(ide_hwif_t *hwif,


Anton/Sergei: please look into fixing it properly - we probably just need to
to have a new config option (CONFIG_IDE_SFF_DMA sounds neat) to be selected by
both BLK_DEV_{IDEDMA_PCI,PALMCHIP_BK3710} and to replace BLK_DEV_IDEDMA_PCI
#ifdefs in ide-dma.c.

> > I've just noticed that there is no cable detection for UDMA modes > UDMA2?
> For the present controller in documentation: Cable Select (CSEL) - unsupported 
> IDE controller signal. This signal is not necessary because an 80-conductor 
> cable must be used with the DM644x.
> 
> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>

Minor issue: the original patch description got lost somehow so I just used
the one from the previous version.

> ---
> 
>  drivers/ide/Kconfig           |    9 
>  drivers/ide/arm/Makefile      |    1 
>  drivers/ide/arm/palm_bk3710.c |  420 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/ide/ide-proc.c        |    1 
>  include/linux/ide.h           |    2 
>  5 files changed, 432 insertions(+), 1 deletion(-)
> 
> Index: 2.6.25.ide/drivers/ide/Kconfig
> ===================================================================
> --- 2.6.25.ide.orig/drivers/ide/Kconfig
> +++ 2.6.25.ide/drivers/ide/Kconfig
> @@ -1009,6 +1009,15 @@ config BLK_DEV_Q40IDE
>  	  normally be on; disable it only if you are running a custom hard
>  	  drive subsystem through an expansion card.
>  
> +config BLK_DEV_PALMCHIP_BK3710
> +	tristate "Palmchip bk3710 IDE controller support"
> +	depends on ARCH_DAVINCI
> +	select BLK_DEV_IDEDMA_PCI
> +	help
> +	  Say Y here if you want to support the onchip IDE controller on the
> +	  TI DaVinci SoC
> +
> +
>  config BLK_DEV_MPC8xx_IDE
>  	tristate "MPC8xx IDE support"
>  	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=y && 
> BLK_DEV_IDE=y && !PPC_MERGE
> Index: 2.6.25.ide/drivers/ide/arm/Makefile
> ===================================================================
> --- 2.6.25.ide.orig/drivers/ide/arm/Makefile
> +++ 2.6.25.ide/drivers/ide/arm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
>  obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
>  obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
> +obj-$(CONFIG_BLK_DEV_PALMCHIP_BK3710)	+= palm_bk3710.o
>  
>  ifeq ($(CONFIG_IDE_ARM), m)
>  	obj-m += ide_arm.o
> Index: 2.6.25.ide/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- /dev/null
> +++ 2.6.25.ide/drivers/ide/arm/palm_bk3710.c

[...]

> +/*static inline u8 hwif_read8(u32 base, u32 reg)
> +{
> +	return readb(base + reg);
> +}
> +
> +static inline u16 hwif_read16(u32 base, u32 reg)
> +{
> +	return readw(base + reg);
> +}
> +
> +static inline void hwif_write16(u32 base, u16 val, u32 reg)
> +{
> +	writew(val, base + reg);
> +}
> +
> +static inline u32 hwif_read32(u32 base, u32 reg)
> +{
> +	return readl(base + reg);
> +}
> +
> +static inline void hwif_write32(u32 base, u32 val, u32 reg)
> +{
> +	writel(val, base + reg);
> +}*/

I removed this chunk while merging the patch (no need for a dead code)

also added "Reviewed-by:" tags crediting Alan & Sergei
