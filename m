Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B9C3F68F
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CC124686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HbBLNq7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgA1NeR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58923 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgA1NeR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133414euoutp0113795494ce5a09498e06c35ae4099659~uEE-6ZtOy0325703257euoutp01J
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133414euoutp0113795494ce5a09498e06c35ae4099659~uEE-6ZtOy0325703257euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218454;
        bh=T6lHnAKlpw/zz4V71yEIDoPVDXBTHjTDKfCDgnmDEbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbBLNq7LE8AcXEsRiy+v6h9h/cT/H4bowJW8RDZbcTwaywxsM5eicwlowDayF+Pe6
         CsUJkULBRnQbzx4xt0oqnLAhSlIhER3An2ETXvzK3FQtWSAB9fP5a3hT9/GxtTWU3p
         03/N+EtC/lOFMlYNDOX3Rk70tmPRA8lbvH7ZOGDc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133414eucas1p2fd6d6e560c9236c3a922169f6b1b65df~uEE-pAeXB3103131031eucas1p2o;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.5A.60679.658303E5; Tue, 28
        Jan 2020 13:34:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73~uEE-GAEbc0713407134eucas1p1q;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133414eusmtrp299a1e2d410bca940bda641faf6fad1e8~uEE-FadAh0330103301eusmtrp2t;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-48-5e3038565483
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.72.07950.558303E5; Tue, 28
        Jan 2020 13:34:13 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133413eusmtip2b1a0bc87cbd83581eacf298dd6f8aa5b~uEE_vQk0N0657106571eusmtip2f;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 10/28] ata: separate PATA timings code from libata-core.c
Date:   Tue, 28 Jan 2020 14:33:25 +0100
Message-Id: <20200128133343.29905-11-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7phFgZxBrO+KVqsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+Po1i9MBcdXMVb0dRY0MH5rZOxi5OSQEDCR2HbjNnsXIxeHkMAKRolHm9aw
        QDhfGCXOzvjDDOF8ZpS4+GsnUxcjB1jLles8EPHljBLr/t9ihuuY2HieBWQum4CVxMT2VWA7
        RAQUJHp+r2QDKWIWWMMosepwE1hCWMBTYtbF2awgNouAqsTLqzPBbF4BO4k9DbehDpSX2Prt
        EyvIZk6geM9ec4gSQYmTM5+A7WIGKmneOpsZorydXWL+YxYI20Xi4+N9TBC2sMSr41vYIWwZ
        if875zOB3CMhsI5R4m/HC2YIZzujxPLJ/9ggqqwl7pz7xQaymFlAU2L9Ln2IsKNE17aFLJCQ
        4JO48VYQ4gY+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50qoMz0k9v2dyziBUXEWkm9mIflm
        FsLeBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQITzOl/x7/sYNz1J+kQowAHoxIP
        7wwVgzgh1sSy4srcQ4wSHMxKIrydTEAh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQn
        lqRmp6YWpBbBZJk4OKUaGD0XFvjdLv2kuFWxa+HOixkSCttfvbnf/1JMf9fmDfX5Cr5BV2Wd
        StsSXYwqvbkWvfC/VfMiKiKaidPdSFeimVn6N0OAfuXSfklRm4+5k46IFkTl7v203CnhVCB7
        0IrZW73KX1d9N1Zi2ZGxYIvRg/qiiueVk/mtipobF8XeSKqvkdI2+pGuxFKckWioxVxUnAgA
        2yUM8ywDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0wC4M4gxeCFqvv9rNZbJyxntXi
        2a29TBbHdjxisri8aw6bxdzW6ewObB47Z91l97h8ttTj0OEORo++LasYPT5vkgtgjdKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOLr1C1PB8VWM
        FX2dBQ2M3xoZuxg5OCQETCSuXOfpYuTiEBJYyijxb9IMFoi4jMTx9WVdjJxAprDEn2tdbBA1
        nxgl9ky/zQ6SYBOwkpjYvooRxBYRUJDo+b0SrIhZYAOjxKubX1hAEsICnhKzLs5mBbFZBFQl
        Xl6dCWbzCthJ7Gm4zQixQV5i67dPrCCLOYHiPXvNQcJCArYS6888hSoXlDg58wnYSGag8uat
        s5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmAUbDv2c8sOxq53wYcY
        BTgYlXh4HZQM4oRYE8uKK3MPMUpwMCuJ8HYyAYV4UxIrq1KL8uOLSnNSiw8xmgL9MJFZSjQ5
        HxiheSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGG/Y/k49tSZ8
        p+zzjKPbdz37NO+uYIW/lui8thXWHZ4hM55etfpv+HrxA1UL1aKr+oKrtvE87fJectI4xMRi
        j3/du393Xt29dt2SxXVqwzS24G0PZgso7zC5Kr9mzYSanz9mG2YLGdlPmhUQ2dB7SLnwFRPH
        lJfdqedvLMn+e11bdrW1+40FFvOVWIozEg21mIuKEwHf1BJEmAIAAA==
X-CMS-MailID: 20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Separate PATA timings code from libata-core.c:

* add PATA_TIMINGS config option and make corresponding PATA
  host drivers (and ATA ACPI code) select it

* move following PATA timings code to libata-pata-timings.c:
  - ata_timing_quantize()
  - ata_timing_merge()
  - ata_timing_find_mode()
  - ata_timing_compute()

* group above functions together in <linux/libata.h> and cover
  them with CONFIG_PATA_TIMINGS ifdef

* include libata-pata-timings.c in the build when PATA_TIMINGS
  config option is enabled

* cover ata_timing_cycle2mode() with CONFIG_ATA_ACPI ifdef (it
  depends on code from libata-core.c and libata-pata-timings.c
  while its only user is ATA ACPI)

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  39688     573      40   40301    9d6d drivers/ata/libata-core.o
after:
  37820     572      40   38432    9620 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig               |  21 ++++
 drivers/ata/Makefile              |   1 +
 drivers/ata/libata-core.c         | 171 +---------------------------
 drivers/ata/libata-pata-timings.c | 180 ++++++++++++++++++++++++++++++
 include/linux/libata.h            |  20 +++-
 5 files changed, 218 insertions(+), 175 deletions(-)
 create mode 100644 drivers/ata/libata-pata-timings.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ad7760656f71..5b55ebf56b5a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -37,6 +37,9 @@ config ATA_NONSTANDARD
 config SATA_HOST
 	bool
 
+config PATA_TIMINGS
+	bool
+
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
 	default y
@@ -51,6 +54,7 @@ config ATA_VERBOSE_ERROR
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI
+	select PATA_TIMINGS
 	default y
 	help
 	  This option adds support for ATA-related ACPI objects.
@@ -341,6 +345,7 @@ config PDC_ADMA
 config PATA_OCTEON_CF
 	tristate "OCTEON Boot Bus Compact Flash support"
 	depends on CAVIUM_OCTEON_SOC
+	select PATA_TIMINGS
 	help
 	  This option enables a polled compact flash driver for use with
 	  compact flash cards attached to the OCTEON boot bus.
@@ -536,6 +541,7 @@ comment "PATA SFF controllers with BMDMA"
 config PATA_ALI
 	tristate "ALi PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the ALi ATA interfaces
 	  found on the many ALi chipsets.
@@ -545,6 +551,7 @@ config PATA_ALI
 config PATA_AMD
 	tristate "AMD/NVidia PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the AMD and NVidia PATA
 	  interfaces found on the chipsets for Athlon/Athlon64.
@@ -579,6 +586,7 @@ config PATA_ATIIXP
 config PATA_ATP867X
 	tristate "ARTOP/Acard ATP867X PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for ARTOP/Acard ATP867X PATA
 	  controllers.
@@ -588,6 +596,7 @@ config PATA_ATP867X
 config PATA_BK3710
 	tristate "Palmchip BK3710 PATA support"
 	depends on ARCH_DAVINCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the integrated IDE controller on
 	  the TI DaVinci SoC.
@@ -597,6 +606,7 @@ config PATA_BK3710
 config PATA_CMD64X
 	tristate "CMD64x PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the CMD64x series chips
 	  except for the CMD640.
@@ -642,6 +652,7 @@ config PATA_CS5536
 config PATA_CYPRESS
 	tristate "Cypress CY82C693 PATA support (Very Experimental)"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the Cypress/Contaq CY82C693
 	  chipset found in some Alpha systems
@@ -660,6 +671,7 @@ config PATA_EFAR
 config PATA_EP93XX
 	tristate "Cirrus Logic EP93xx PATA support"
 	depends on ARCH_EP93XX
+	select PATA_TIMINGS
 	help
 	  This option enables support for the PATA controller in
 	  the Cirrus Logic EP9312 and EP9315 ARM CPU.
@@ -724,6 +736,7 @@ config PATA_HPT3X3_DMA
 config PATA_ICSIDE
 	tristate "Acorn ICS PATA support"
 	depends on ARM && ARCH_ACORN
+	select PATA_TIMINGS
 	help
 	  On Acorn systems, say Y here if you wish to use the ICS PATA
 	  interface card.  This is not required for ICS partition support.
@@ -732,6 +745,7 @@ config PATA_ICSIDE
 config PATA_IMX
 	tristate "PATA support for Freescale iMX"
 	depends on ARCH_MXC
+	select PATA_TIMINGS
 	help
 	  This option enables support for the PATA host available on Freescale
           iMX SoCs.
@@ -817,6 +831,7 @@ config PATA_NINJA32
 config PATA_NS87415
 	tristate "Nat Semi NS87415 PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the National Semiconductor
 	  NS87415 PCI-IDE controller.
@@ -941,6 +956,7 @@ config PATA_TRIFLEX
 config PATA_VIA
 	tristate "VIA PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the VIA PATA interfaces
 	  found on the many VIA chipsets.
@@ -974,6 +990,7 @@ comment "PIO-only SFF controllers"
 config PATA_CMD640_PCI
 	tristate "CMD640 PCI PATA support (Experimental)"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the CMD640 PCI IDE
 	  interface chip. Only the primary channel is currently
@@ -1044,6 +1061,7 @@ config PATA_MPIIX
 config PATA_NS87410
 	tristate "Nat Semi NS87410 PATA support"
 	depends on PCI
+	select PATA_TIMINGS
 	help
 	  This option enables support for the National Semiconductor
 	  NS87410 PCI-IDE controller.
@@ -1124,6 +1142,7 @@ config PATA_RZ1000
 config PATA_SAMSUNG_CF
 	tristate "Samsung SoC PATA support"
 	depends on SAMSUNG_DEV_IDE
+	select PATA_TIMINGS
 	help
 	  This option enables basic support for Samsung's S3C/S5P board
 	  PATA controllers via the new ATA layer
@@ -1143,6 +1162,7 @@ comment "Generic fallback / legacy drivers"
 config PATA_ACPI
 	tristate "ACPI firmware driver for PATA"
 	depends on ATA_ACPI && ATA_BMDMA && PCI
+	select PATA_TIMINGS
 	help
 	  This option enables an ACPI method driver which drives
 	  motherboard PATA controller interfaces through the ACPI
@@ -1162,6 +1182,7 @@ config ATA_GENERIC
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
 	depends on (ISA || PCI)
+	select PATA_TIMINGS
 	help
 	  This option enables support for ISA/VLB/PCI bus legacy PATA
 	  ports and allows them to be accessed via the new ATA layer.
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d8cc2e04a6c7..cdaf965fed25 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -127,3 +127,4 @@ libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
 libata-$(CONFIG_SATA_ZPODD)	+= libata-zpodd.o
+libata-$(CONFIG_PATA_TIMINGS)	+= libata-pata-timings.o
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c41198bb9582..408dee580f24 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3204,175 +3204,7 @@ int sata_set_spd(struct ata_link *link)
 }
 EXPORT_SYMBOL_GPL(sata_set_spd);
 
-/*
- * This mode timing computation functionality is ported over from
- * drivers/ide/ide-timing.h and was originally written by Vojtech Pavlik
- */
-/*
- * PIO 0-4, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
- * These were taken from ATA/ATAPI-6 standard, rev 0a, except
- * for UDMA6, which is currently supported only by Maxtor drives.
- *
- * For PIO 5/6 MWDMA 3/4 see the CFA specification 3.0.
- */
-
-static const struct ata_timing ata_timing[] = {
-/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 0,  960,   0 }, */
-	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 0,  600,   0 },
-	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 0,  383,   0 },
-	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 0,  240,   0 },
-	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 0,  180,   0 },
-	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 0,  120,   0 },
-	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 0,  100,   0 },
-	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20, 0,   80,   0 },
-
-	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 50, 960,   0 },
-	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 480,   0 },
-	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 20, 240,   0 },
-
-	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 480,   0 },
-	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 5,  150,   0 },
-	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 5,  120,   0 },
-	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 5,  100,   0 },
-	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20, 5,   80,   0 },
-
-/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0, 0,    0, 150 }, */
-	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0, 0,    0, 120 },
-	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0, 0,    0,  80 },
-	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0, 0,    0,  60 },
-	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0, 0,    0,  45 },
-	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0, 0,    0,  30 },
-	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0, 0,    0,  20 },
-	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0, 0,    0,  15 },
-
-	{ 0xFF }
-};
-
-#define ENOUGH(v, unit)		(((v)-1)/(unit)+1)
-#define EZ(v, unit)		((v)?ENOUGH(((v) * 1000), unit):0)
-
-static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
-{
-	q->setup	= EZ(t->setup,       T);
-	q->act8b	= EZ(t->act8b,       T);
-	q->rec8b	= EZ(t->rec8b,       T);
-	q->cyc8b	= EZ(t->cyc8b,       T);
-	q->active	= EZ(t->active,      T);
-	q->recover	= EZ(t->recover,     T);
-	q->dmack_hold	= EZ(t->dmack_hold,  T);
-	q->cycle	= EZ(t->cycle,       T);
-	q->udma		= EZ(t->udma,       UT);
-}
-
-void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
-		      struct ata_timing *m, unsigned int what)
-{
-	if (what & ATA_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
-	if (what & ATA_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
-	if (what & ATA_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
-	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
-	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
-	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
-	if (what & ATA_TIMING_DMACK_HOLD) m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
-	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
-	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
-}
-EXPORT_SYMBOL_GPL(ata_timing_merge);
-
-const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
-{
-	const struct ata_timing *t = ata_timing;
-
-	while (xfer_mode > t->mode)
-		t++;
-
-	if (xfer_mode == t->mode)
-		return t;
-
-	WARN_ONCE(true, "%s: unable to find timing for xfer_mode 0x%x\n",
-			__func__, xfer_mode);
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(ata_timing_find_mode);
-
-int ata_timing_compute(struct ata_device *adev, unsigned short speed,
-		       struct ata_timing *t, int T, int UT)
-{
-	const u16 *id = adev->id;
-	const struct ata_timing *s;
-	struct ata_timing p;
-
-	/*
-	 * Find the mode.
-	 */
-
-	if (!(s = ata_timing_find_mode(speed)))
-		return -EINVAL;
-
-	memcpy(t, s, sizeof(*s));
-
-	/*
-	 * If the drive is an EIDE drive, it can tell us it needs extended
-	 * PIO/MW_DMA cycle timing.
-	 */
-
-	if (id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE drive */
-		memset(&p, 0, sizeof(p));
-
-		if (speed >= XFER_PIO_0 && speed < XFER_SW_DMA_0) {
-			if (speed <= XFER_PIO_2)
-				p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO];
-			else if ((speed <= XFER_PIO_4) ||
-				 (speed == XFER_PIO_5 && !ata_id_is_cfa(id)))
-				p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO_IORDY];
-		} else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
-			p.cycle = id[ATA_ID_EIDE_DMA_MIN];
-
-		ata_timing_merge(&p, t, t, ATA_TIMING_CYCLE | ATA_TIMING_CYC8B);
-	}
-
-	/*
-	 * Convert the timing to bus clock counts.
-	 */
-
-	ata_timing_quantize(t, t, T, UT);
-
-	/*
-	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
-	 * S.M.A.R.T * and some other commands. We have to ensure that the
-	 * DMA cycle timing is slower/equal than the fastest PIO timing.
-	 */
-
-	if (speed > XFER_PIO_6) {
-		ata_timing_compute(adev, adev->pio_mode, &p, T, UT);
-		ata_timing_merge(&p, t, t, ATA_TIMING_ALL);
-	}
-
-	/*
-	 * Lengthen active & recovery time so that cycle time is correct.
-	 */
-
-	if (t->act8b + t->rec8b < t->cyc8b) {
-		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
-		t->rec8b = t->cyc8b - t->act8b;
-	}
-
-	if (t->active + t->recover < t->cycle) {
-		t->active += (t->cycle - (t->active + t->recover)) / 2;
-		t->recover = t->cycle - t->active;
-	}
-
-	/* In a few cases quantisation may produce enough errors to
-	   leave t->cycle too low for the sum of active and recovery
-	   if so we must correct this */
-	if (t->active + t->recover > t->cycle)
-		t->cycle = t->active + t->recover;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_timing_compute);
-
+#ifdef CONFIG_ATA_ACPI
 /**
  *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
  *	@xfer_shift: ATA_SHIFT_* value for transfer type to examine.
@@ -3423,6 +3255,7 @@ u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
 
 	return last_mode;
 }
+#endif
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
diff --git a/drivers/ata/libata-pata-timings.c b/drivers/ata/libata-pata-timings.c
new file mode 100644
index 000000000000..bababa6f519b
--- /dev/null
+++ b/drivers/ata/libata-pata-timings.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  libata-pata-timings.c - helper library for PATA timings
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+
+/*
+ * This mode timing computation functionality is ported over from
+ * drivers/ide/ide-timing.h and was originally written by Vojtech Pavlik
+ */
+/*
+ * PIO 0-4, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
+ * These were taken from ATA/ATAPI-6 standard, rev 0a, except
+ * for UDMA6, which is currently supported only by Maxtor drives.
+ *
+ * For PIO 5/6 MWDMA 3/4 see the CFA specification 3.0.
+ */
+
+static const struct ata_timing ata_timing[] = {
+/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 0,  960,   0 }, */
+	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 0,  600,   0 },
+	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 0,  383,   0 },
+	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 0,  240,   0 },
+	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 0,  180,   0 },
+	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 0,  120,   0 },
+	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 0,  100,   0 },
+	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20, 0,   80,   0 },
+
+	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 50, 960,   0 },
+	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 480,   0 },
+	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 20, 240,   0 },
+
+	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 480,   0 },
+	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 5,  150,   0 },
+	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 5,  120,   0 },
+	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 5,  100,   0 },
+	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20, 5,   80,   0 },
+
+/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0, 0,    0, 150 }, */
+	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0, 0,    0, 120 },
+	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0, 0,    0,  80 },
+	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0, 0,    0,  60 },
+	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0, 0,    0,  45 },
+	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0, 0,    0,  30 },
+	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0, 0,    0,  20 },
+	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0, 0,    0,  15 },
+
+	{ 0xFF }
+};
+
+#define ENOUGH(v, unit)		(((v)-1)/(unit)+1)
+#define EZ(v, unit)		((v)?ENOUGH(((v) * 1000), unit):0)
+
+static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
+{
+	q->setup	= EZ(t->setup,       T);
+	q->act8b	= EZ(t->act8b,       T);
+	q->rec8b	= EZ(t->rec8b,       T);
+	q->cyc8b	= EZ(t->cyc8b,       T);
+	q->active	= EZ(t->active,      T);
+	q->recover	= EZ(t->recover,     T);
+	q->dmack_hold	= EZ(t->dmack_hold,  T);
+	q->cycle	= EZ(t->cycle,       T);
+	q->udma		= EZ(t->udma,       UT);
+}
+
+void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
+		      struct ata_timing *m, unsigned int what)
+{
+	if (what & ATA_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
+	if (what & ATA_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
+	if (what & ATA_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
+	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
+	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
+	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
+	if (what & ATA_TIMING_DMACK_HOLD) m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
+	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
+	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
+}
+EXPORT_SYMBOL_GPL(ata_timing_merge);
+
+const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
+{
+	const struct ata_timing *t = ata_timing;
+
+	while (xfer_mode > t->mode)
+		t++;
+
+	if (xfer_mode == t->mode)
+		return t;
+
+	WARN_ONCE(true, "%s: unable to find timing for xfer_mode 0x%x\n",
+			__func__, xfer_mode);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(ata_timing_find_mode);
+
+int ata_timing_compute(struct ata_device *adev, unsigned short speed,
+		       struct ata_timing *t, int T, int UT)
+{
+	const u16 *id = adev->id;
+	const struct ata_timing *s;
+	struct ata_timing p;
+
+	/*
+	 * Find the mode.
+	 */
+
+	if (!(s = ata_timing_find_mode(speed)))
+		return -EINVAL;
+
+	memcpy(t, s, sizeof(*s));
+
+	/*
+	 * If the drive is an EIDE drive, it can tell us it needs extended
+	 * PIO/MW_DMA cycle timing.
+	 */
+
+	if (id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE drive */
+		memset(&p, 0, sizeof(p));
+
+		if (speed >= XFER_PIO_0 && speed < XFER_SW_DMA_0) {
+			if (speed <= XFER_PIO_2)
+				p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO];
+			else if ((speed <= XFER_PIO_4) ||
+				 (speed == XFER_PIO_5 && !ata_id_is_cfa(id)))
+				p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO_IORDY];
+		} else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
+			p.cycle = id[ATA_ID_EIDE_DMA_MIN];
+
+		ata_timing_merge(&p, t, t, ATA_TIMING_CYCLE | ATA_TIMING_CYC8B);
+	}
+
+	/*
+	 * Convert the timing to bus clock counts.
+	 */
+
+	ata_timing_quantize(t, t, T, UT);
+
+	/*
+	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
+	 * S.M.A.R.T * and some other commands. We have to ensure that the
+	 * DMA cycle timing is slower/equal than the fastest PIO timing.
+	 */
+
+	if (speed > XFER_PIO_6) {
+		ata_timing_compute(adev, adev->pio_mode, &p, T, UT);
+		ata_timing_merge(&p, t, t, ATA_TIMING_ALL);
+	}
+
+	/*
+	 * Lengthen active & recovery time so that cycle time is correct.
+	 */
+
+	if (t->act8b + t->rec8b < t->cyc8b) {
+		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
+		t->rec8b = t->cyc8b - t->act8b;
+	}
+
+	if (t->active + t->recover < t->cycle) {
+		t->active += (t->cycle - (t->active + t->recover)) / 2;
+		t->recover = t->cycle - t->active;
+	}
+
+	/* In a few cases quantisation may produce enough errors to
+	   leave t->cycle too low for the sum of active and recovery
+	   if so we must correct this */
+	if (t->active + t->recover > t->cycle)
+		t->cycle = t->active + t->recover;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_timing_compute);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index dc162cca63a4..79953c6d769c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1207,13 +1207,9 @@ extern int ata_cable_unknown(struct ata_port *ap);
 
 /* Timing helpers */
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
-extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
-extern int ata_timing_compute(struct ata_device *, unsigned short,
-			      struct ata_timing *, int, int);
-extern void ata_timing_merge(const struct ata_timing *,
-			     const struct ata_timing *, struct ata_timing *,
-			     unsigned int);
+#ifdef CONFIG_ATA_ACPI
 extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
+#endif
 
 /* PCI */
 #ifdef CONFIG_PCI
@@ -1805,6 +1801,18 @@ static inline int ata_dma_enabled(struct ata_device *adev)
 	return (adev->dma_mode == 0xFF ? 0 : 1);
 }
 
+/**************************************************************************
+ * PATA timings - drivers/ata/libata-pata-timings.c
+ */
+#ifdef CONFIG_PATA_TIMINGS
+extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
+extern int ata_timing_compute(struct ata_device *, unsigned short,
+			      struct ata_timing *, int, int);
+extern void ata_timing_merge(const struct ata_timing *,
+			     const struct ata_timing *, struct ata_timing *,
+			     unsigned int);
+#endif
+
 /**************************************************************************
  * PMP - drivers/ata/libata-pmp.c
  */
-- 
2.24.1

