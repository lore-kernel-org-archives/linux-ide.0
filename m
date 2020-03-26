Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EAC2D0E5
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496FA2078E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DDqPs6ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgCZP6p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:58:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58869 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgCZP6p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155844euoutp01a7c3bfc94c1f37025006ac5d32bba5ab~-5dtamDb-3025530255euoutp01I
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155844euoutp01a7c3bfc94c1f37025006ac5d32bba5ab~-5dtamDb-3025530255euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238324;
        bh=fmEdpGHirS8bdtOHdmsQtbkD44wwdehT3akoK9pFF0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDqPs6igdVZNVse72o3Xw8SLMue5V6CmFnaU7YcwAZb7qq6Yqr/MoC9anpfNXXI/I
         mUxieJHqA4ypVzTEMlBvLsEYXdD+iZuzXZsXRuKzWKvuEseD4JZw9edn69+VfUEr8E
         U5Gu+8rqFjt5xt0EuR1jFLEkvNEU44ZE+SVUiT7A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155843eucas1p171abb2688b040ee515f13bb93e620ad7~-5dtC160-2422724227eucas1p13;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F3.F7.60698.331DC7E5; Thu, 26
        Mar 2020 15:58:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155843eucas1p19fd3210ca004306942c7c12ca98e04c2~-5dsvfgSY2821928219eucas1p1u;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155843eusmtrp1a8c5ae3da6b8d72ba3abaed7cf94ba94~-5dsu3ic72090020900eusmtrp1k;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-95-5e7cd13347a2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.CA.07950.331DC7E5; Thu, 26
        Mar 2020 15:58:43 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155842eusmtip13318e23e6cf8e39d2676d37f59307cfe~-5dsRjvvl1572315723eusmtip1r;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 12/27] ata: separate PATA timings code from libata-core.c
Date:   Thu, 26 Mar 2020 16:58:07 +0100
Message-Id: <20200326155822.19400-13-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87rGF2viDCYc1bRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk9uy+wFXxcyVhxcMly5gbG3Y2MXYyc
        HBICJhJLe1YwdzFycQgJrGCU+NN3lBXC+cIosfviRRYI5zOjROvuXywwLe83P2KESCxnlOhY
        +5gJrmXGnY3sIFVsAlYSE9tXgS0REVCQ6Pm9kg2kiFngPaPEikl7wUYJC/hIrPt7HsxmEVCV
        WHhoE1ADBwevgJ3E1DtWENvkJbZ++8QKYnMChZevm88MYvMKCEqcnPkErJUZqKZ562ywJyQE
        VrFL/J/ZywzR7CKxfPdpNghbWOLV8S3sELaMxOnJPSwQDesYJf52vIDq3s4osXzyP6gOa4k7
        536xgVzELKApsX6XPkTYUWL3zE4WkLCEAJ/EjbeCEEfwSUzaNp0ZIswr0dEmBFGtJrFh2QY2
        mLVdO1dCneYhcfrwI6YJjIqzkLwzC8k7sxD2LmBkXsUonlpanJueWmycl1quV5yYW1yal66X
        nJ+7iRGYjk7/O/51B+O+P0mHGAU4GJV4eBvaauKEWBPLiitzDzFKcDArifA+jQQK8aYkVlal
        FuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwKifHRvKE2NtFZ2usMR/
        oSh70tpv4rIFDPxaLxgbDud8YX8m+vubaHKjlsX/O9v//407qqqfv/9Eu9kHfbHezuVPN8l9
        f3Mtk/fxGRGx7t6rO/31PsouKWs3tNDZXj/xcelZPeHyb5c/RUbINDq7rP9xKsnv5+T4Z9mL
        euq1ky0kuCP2beC5ocRSnJFoqMVcVJwIAB67NVxDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7rGF2viDI4/ELRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk9uy+wFXxcyVhxcMly5gbG3Y2MXYycHBICJhLvNz8Csrk4hASWMkpc
        ObGYtYuRAyghI3F8fRlEjbDEn2tdbBA1nxgl7pzYBNbMJmAlMbF9FZgtIqAg0fN7JVgRs8BX
        Romlk7qZQRLCAj4S6/6eZwGxWQRUJRYeAmnm4OAVsJOYescKYoG8xNZvn1hBbE6g8PJ188Fa
        hQRsJRZ/+cAEYvMKCEqcnPkEbAwzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgx
        t7g0L10vOT93EyMwZrYd+7llB2PXu+BDjAIcjEo8vBotNXFCrIllxZW5hxglOJiVRHifRgKF
        eFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0OR8Yz3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhjDX3qEp/CsDH717tisVWz3tlgw3lzszSfle2sZl90cZs76Y0Fz
        Tz2MX3t+2SG9BH+RP9vqzq+PXDqRa+8uLn7H9/0flzw9MZPz2YQbrM/PnU9TEJERSXy3TGh7
        7JrfR80Yz+1ZpFkYGzlv5XSrLUxdbfeubVAPZN3F/Kt0g6zk+b267+xlVBWjlFiKMxINtZiL
        ihMBpfj/K68CAAA=
X-CMS-MailID: 20200326155843eucas1p19fd3210ca004306942c7c12ca98e04c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155843eucas1p19fd3210ca004306942c7c12ca98e04c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155843eucas1p19fd3210ca004306942c7c12ca98e04c2
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155843eucas1p19fd3210ca004306942c7c12ca98e04c2@eucas1p1.samsung.com>
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

* group above functions together in <linux/libata.h>

* include libata-pata-timings.c in the build when PATA_TIMINGS
  config option is enabled

* cover ata_timing_cycle2mode() with CONFIG_ATA_ACPI ifdef (it
  depends on code from libata-core.c and libata-pata-timings.c
  while its only user is ATA ACPI)

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  39688     573      40   40301    9d6d drivers/ata/libata-core.o
after:
  37820     572      40   38432    9620 drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig               |  21 ++++
 drivers/ata/Makefile              |   1 +
 drivers/ata/libata-core.c         | 183 +---------------------------
 drivers/ata/libata-pata-timings.c | 192 ++++++++++++++++++++++++++++++
 include/linux/libata.h            |  16 ++-
 5 files changed, 226 insertions(+), 187 deletions(-)
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
index acdcedcb3d10..0a56968e2e98 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3204,187 +3204,7 @@ int sata_set_spd(struct ata_link *link)
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
-static void ata_timing_quantize(const struct ata_timing *t,
-				struct ata_timing *q, int T, int UT)
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
-	if (what & ATA_TIMING_SETUP)
-		m->setup = max(a->setup, b->setup);
-	if (what & ATA_TIMING_ACT8B)
-		m->act8b = max(a->act8b, b->act8b);
-	if (what & ATA_TIMING_REC8B)
-		m->rec8b = max(a->rec8b, b->rec8b);
-	if (what & ATA_TIMING_CYC8B)
-		m->cyc8b = max(a->cyc8b, b->cyc8b);
-	if (what & ATA_TIMING_ACTIVE)
-		m->active = max(a->active, b->active);
-	if (what & ATA_TIMING_RECOVER)
-		m->recover = max(a->recover, b->recover);
-	if (what & ATA_TIMING_DMACK_HOLD)
-		m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
-	if (what & ATA_TIMING_CYCLE)
-		m->cycle = max(a->cycle, b->cycle);
-	if (what & ATA_TIMING_UDMA)
-		m->udma = max(a->udma, b->udma);
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
-	s = ata_timing_find_mode(speed);
-	if (!s)
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
-	/*
-	 * In a few cases quantisation may produce enough errors to
-	 * leave t->cycle too low for the sum of active and recovery
-	 * if so we must correct this.
-	 */
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
@@ -3435,6 +3255,7 @@ u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
 
 	return last_mode;
 }
+#endif
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
diff --git a/drivers/ata/libata-pata-timings.c b/drivers/ata/libata-pata-timings.c
new file mode 100644
index 000000000000..af341226cc64
--- /dev/null
+++ b/drivers/ata/libata-pata-timings.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Helper library for PATA timings
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
+static void ata_timing_quantize(const struct ata_timing *t,
+				struct ata_timing *q, int T, int UT)
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
+	if (what & ATA_TIMING_SETUP)
+		m->setup = max(a->setup, b->setup);
+	if (what & ATA_TIMING_ACT8B)
+		m->act8b = max(a->act8b, b->act8b);
+	if (what & ATA_TIMING_REC8B)
+		m->rec8b = max(a->rec8b, b->rec8b);
+	if (what & ATA_TIMING_CYC8B)
+		m->cyc8b = max(a->cyc8b, b->cyc8b);
+	if (what & ATA_TIMING_ACTIVE)
+		m->active = max(a->active, b->active);
+	if (what & ATA_TIMING_RECOVER)
+		m->recover = max(a->recover, b->recover);
+	if (what & ATA_TIMING_DMACK_HOLD)
+		m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
+	if (what & ATA_TIMING_CYCLE)
+		m->cycle = max(a->cycle, b->cycle);
+	if (what & ATA_TIMING_UDMA)
+		m->udma = max(a->udma, b->udma);
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
+	s = ata_timing_find_mode(speed);
+	if (!s)
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
+	/*
+	 * In a few cases quantisation may produce enough errors to
+	 * leave t->cycle too low for the sum of active and recovery
+	 * if so we must correct this.
+	 */
+	if (t->active + t->recover > t->cycle)
+		t->cycle = t->active + t->recover;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_timing_compute);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 236e4c55be48..500b709ed3de 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1205,12 +1205,6 @@ extern int ata_cable_unknown(struct ata_port *ap);
 
 /* Timing helpers */
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
-extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
-extern int ata_timing_compute(struct ata_device *, unsigned short,
-			      struct ata_timing *, int, int);
-extern void ata_timing_merge(const struct ata_timing *,
-			     const struct ata_timing *, struct ata_timing *,
-			     unsigned int);
 extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
 
 /* PCI */
@@ -1807,6 +1801,16 @@ static inline int ata_dma_enabled(struct ata_device *adev)
 	return (adev->dma_mode == 0xFF ? 0 : 1);
 }
 
+/**************************************************************************
+ * PATA timings - drivers/ata/libata-pata-timings.c
+ */
+extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
+extern int ata_timing_compute(struct ata_device *, unsigned short,
+			      struct ata_timing *, int, int);
+extern void ata_timing_merge(const struct ata_timing *,
+			     const struct ata_timing *, struct ata_timing *,
+			     unsigned int);
+
 /**************************************************************************
  * PMP - drivers/ata/libata-pmp.c
  */
-- 
2.24.1

