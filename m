Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F18C2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F9620737
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b6mESidW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgCZQAP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58854 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgCZP6m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155840euoutp018b69ee58138cf66c228b3d3dad80f9c5~-5dp89Tvt2877928779euoutp010
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155840euoutp018b69ee58138cf66c228b3d3dad80f9c5~-5dp89Tvt2877928779euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238320;
        bh=V+ZJD0LCQIesQzBNA0tu8oIKd9rrUfru8x17gyJ2a3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6mESidWdraLzz+7svWsI4B664MNX8gBGozbhflfehybfn0HwY5kNwSBb7f3fWYJi
         /40Jjwrd4ZS9mb+0AS3paxlyPsamDHkZgo3ReVUoTSAJZL+rBCK64a2PEr87RkC6R1
         gMPGgakXakCpmEOA23NxqlR5ApYUWNuSsK+Bwbgc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155840eucas1p17a12bf970e837414ca71eac8a25a4d4c~-5dpruoUq2821828218eucas1p1q;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 02.E9.60679.F21DC7E5; Thu, 26
        Mar 2020 15:58:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155839eucas1p226e80fe61b5df9c08ec23c7d93c843db~-5dpMzv5l2255222552eucas1p2F;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155839eusmtrp15b3bc435bb2ceda14a34b1a274c04422~-5dpMNxk12090020900eusmtrp1V;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-bd-5e7cd12f55fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.CA.07950.F21DC7E5; Thu, 26
        Mar 2020 15:58:39 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155839eusmtip1cc1a4819117cb9d41daea44a9938de27~-5dor2rx81330613306eusmtip1Q;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v5 03/27] ata: make SATA_PMP option selectable only if any
 SATA host driver is enabled
Date:   Thu, 26 Mar 2020 16:57:58 +0100
Message-Id: <20200326155822.19400-4-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djP87oGF2viDLpuMVqsvtvPZrFxxnpW
        i2e39jJZrFx9lMli0Y1tTBbHdjxisri8aw6bxfIna5ktlh//x2Qxt3U6uwOXx85Zd9k9Lp8t
        9Th0uIPRY8KiA4weJ1u/sXjsvtnA5vHx6S0Wj74tqxg9Pm+SC+CM4rJJSc3JLEst0rdL4Mpo
        bL3GXrAitGL1/KgGxotOXYycHBICJhJ3thxm7WLk4hASWMEoceHkahYI5wujxIpbu5khnM+M
        EvNm3GKCaXnw4CIjRGI5o8S/A7OZ4VoWPFvOCFLFJmAlMbF9FZgtIqAg0fN7JRtIEbPAFSaJ
        VW8WsIIkhAUyJGY2LGMHsVkEVCV+T+hjAbF5BWwlXi7dzgixTl5i67dPYPWcAnYSy9fNZ4ao
        EZQ4OfMJWD0zUE3zVogrJAQOsUss6HnACtHsItG4bz7U3cISr45vYYewZSROT+5hgWhYxyjx
        t+MFVPd2Ronlk/+xQVRZS9w59wvI5gBaoSmxfpc+RNhRYu+KDlaQsIQAn8SNt4IQR/BJTNo2
        nRkizCvR0SYEUa0msWHZBjaYtV07VzJD2B4SS18eY53AqDgLyTuzkLwzC2HvAkbmVYziqaXF
        uempxUZ5qeV6xYm5xaV56XrJ+bmbGIEp6/S/4192MO76k3SIUYCDUYmHV6OlJk6INbGsuDL3
        EKMEB7OSCO/TSKAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwc
        nFINjLJW/TukD65f32ywo/Jo+dltq1Q7ljUqtb2Yfz6rXHXaC+HuAJYLAQeWzxZ6UGBaOXP6
        R235CbrafmcSV3GLc4SKPY5/qMj3Rmvvxqr/rD1fPmbwbL3BeWPCtJ7CEqG6JJHeb3Z7+a9z
        Hnp21aucQ6E6vK5ekSUoIv/lTPaSS2Wda0/st3PnVWIpzkg01GIuKk4EALjJSwZVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7r6F2viDHYdlbNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFohvbmCyO7XjEZHF51xw2i+VP1jJbLD/+j8libut0dgcuj52z7rJ7XD5b
        6nHocAejx4RFBxg9TrZ+Y/HYfbOBzePj01ssHn1bVjF6fN4kF8AZpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfR2HqNvWBFaMXq+VENjBeduhg5
        OSQETCQePLjI2MXIxSEksJRR4uu6B+xdjBxACRmJ4+vLIGqEJf5c62IDsYUEPjFKbHtvDGKz
        CVhJTGxfxQhiiwgoSPT8XskGModZ4BaTxMsD3WAJYYE0iZudT8GaWQRUJX5P6GMBsXkFbCVe
        Lt3OCLFAXmLrt0+sIDangJ3E8nXzmSGW2Uos/vKBCaJeUOLkzCdgvcxA9c1bZzNPYBSYhSQ1
        C0lqASPTKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCo2nbs55YdjF3vgg8xCnAwKvHwarTU
        xAmxJpYVV+YeYpTgYFYS4X0aCRTiTUmsrEotyo8vKs1JLT7EaAr0xERmKdHkfGDE55XEG5oa
        mltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYIwOSy0R5PrJckrO53deEyvH
        H0nP7VtOexeVLJosKizELssb84/n7W0Z7Qedl6b6W723e81wuZn1v4bTOpnILz+CTSulNnx7
        szDz1RUV9rpEdwOj88ofQ5uPfhF7+ujmlbJ1tucroyZoWaWm3I2sjptcobPxgd/bU5KVX6K1
        5aqXxxtXf8rYpMRSnJFoqMVcVJwIAA9L6rfAAgAA
X-CMS-MailID: 20200326155839eucas1p226e80fe61b5df9c08ec23c7d93c843db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155839eucas1p226e80fe61b5df9c08ec23c7d93c843db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155839eucas1p226e80fe61b5df9c08ec23c7d93c843db
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155839eucas1p226e80fe61b5df9c08ec23c7d93c843db@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no reason to expose SATA_PMP config option when no SATA
host drivers are enabled. To fix it add SATA_HOST config option,
make all SATA host drivers select it and finally make SATA_PMP
config options depend on it.

This also serves as preparation for the future changes which
optimize libata core code size on PATA only setups.

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # for SCSI bits
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig         | 40 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/Kconfig        |  1 +
 drivers/scsi/libsas/Kconfig |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c5a692..ad7760656f71 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -34,6 +34,9 @@ if ATA
 config ATA_NONSTANDARD
        bool
 
+config SATA_HOST
+	bool
+
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
 	default y
@@ -73,6 +76,7 @@ config SATA_ZPODD
 
 config SATA_PMP
 	bool "SATA Port Multiplier support"
+	depends on SATA_HOST
 	default y
 	help
 	  This option adds support for SATA Port Multipliers
@@ -85,6 +89,7 @@ comment "Controllers with non-SFF native interface"
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for AHCI Serial ATA.
 
@@ -111,6 +116,7 @@ config SATA_MOBILE_LPM_POLICY
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
+	select SATA_HOST
 	help
 	  This option enables support for Platform AHCI Serial ATA
 	  controllers.
@@ -121,6 +127,7 @@ config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
 		   ARCH_BCM_63XX
+	select SATA_HOST
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  Broadcom SoC's.
@@ -130,6 +137,7 @@ config AHCI_BRCM
 config AHCI_DA850
 	tristate "DaVinci DA850 AHCI SATA support"
 	depends on ARCH_DAVINCI_DA850
+	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DA850 SoC's
 	  onboard AHCI SATA.
@@ -139,6 +147,7 @@ config AHCI_DA850
 config AHCI_DM816
 	tristate "DaVinci DM816 AHCI SATA support"
 	depends on ARCH_OMAP2PLUS
+	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DM816 SoC's
 	  onboard AHCI SATA controller.
@@ -148,6 +157,7 @@ config AHCI_DM816
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on ARCH_STI
+	select SATA_HOST
 	help
 	  This option enables support for ST AHCI SATA controller.
 
@@ -157,6 +167,7 @@ config AHCI_IMX
 	tristate "Freescale i.MX AHCI SATA support"
 	depends on MFD_SYSCON && (ARCH_MXC || COMPILE_TEST)
 	depends on (HWMON && (THERMAL || !THERMAL_OF)) || !HWMON
+	select SATA_HOST
 	help
 	  This option enables support for the Freescale i.MX SoC's
 	  onboard AHCI SATA.
@@ -166,6 +177,7 @@ config AHCI_IMX
 config AHCI_CEVA
 	tristate "CEVA AHCI SATA support"
 	depends on OF
+	select SATA_HOST
 	help
 	  This option enables support for the CEVA AHCI SATA.
 	  It can be found on the Xilinx Zynq UltraScale+ MPSoC.
@@ -176,6 +188,7 @@ config AHCI_MTK
 	tristate "MediaTek AHCI SATA support"
 	depends on ARCH_MEDIATEK
 	select MFD_SYSCON
+	select SATA_HOST
 	help
 	  This option enables support for the MediaTek SoC's
 	  onboard AHCI SATA controller.
@@ -185,6 +198,7 @@ config AHCI_MTK
 config AHCI_MVEBU
 	tristate "Marvell EBU AHCI SATA support"
 	depends on ARCH_MVEBU
+	select SATA_HOST
 	help
 	  This option enables support for the Marvebu EBU SoC's
 	  onboard AHCI SATA.
@@ -203,6 +217,7 @@ config AHCI_OCTEON
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
 	depends on ARCH_SUNXI
+	select SATA_HOST
 	help
 	  This option enables support for the Allwinner sunxi SoC's
 	  onboard AHCI SATA.
@@ -212,6 +227,7 @@ config AHCI_SUNXI
 config AHCI_TEGRA
 	tristate "NVIDIA Tegra AHCI SATA support"
 	depends on ARCH_TEGRA
+	select SATA_HOST
 	help
 	  This option enables support for the NVIDIA Tegra SoC's
 	  onboard AHCI SATA.
@@ -221,12 +237,14 @@ config AHCI_TEGRA
 config AHCI_XGENE
 	tristate "APM X-Gene 6.0Gbps AHCI SATA host controller support"
 	depends on PHY_XGENE
+	select SATA_HOST
 	help
 	 This option enables support for APM X-Gene SoC SATA host controller.
 
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
 	depends on OF
+	select SATA_HOST
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
 	  onboard AHCI SATA.
@@ -236,6 +254,7 @@ config AHCI_QORIQ
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
+	select SATA_HOST
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
 	  It can be found on MPC837x and MPC8315.
@@ -245,6 +264,7 @@ config SATA_FSL
 config SATA_GEMINI
 	tristate "Gemini SATA bridge support"
 	depends on ARCH_GEMINI || COMPILE_TEST
+	select SATA_HOST
 	default ARCH_GEMINI
 	help
 	  This enabled support for the FTIDE010 to SATA bridge
@@ -255,6 +275,7 @@ config SATA_GEMINI
 config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
 	depends on ARCH_SEATTLE
+	select SATA_HOST
 	help
 	 This option enables support for AMD Seattle SATA host controller.
 
@@ -263,12 +284,14 @@ config SATA_AHCI_SEATTLE
 config SATA_INIC162X
 	tristate "Initio 162x SATA support (Very Experimental)"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Initio 162x Serial ATA.
 
 config SATA_ACARD_AHCI
 	tristate "ACard AHCI variant (ATP 8620)"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Acard.
 
@@ -277,6 +300,7 @@ config SATA_ACARD_AHCI
 config SATA_SIL24
 	tristate "Silicon Image 3124/3132 SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Silicon Image 3124/3132 Serial ATA.
 
@@ -326,6 +350,7 @@ config PATA_OCTEON_CF
 config SATA_QSTOR
 	tristate "Pacific Digital SATA QStor support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Pacific Digital Serial ATA QStor.
 
@@ -334,6 +359,7 @@ config SATA_QSTOR
 config SATA_SX4
 	tristate "Promise SATA SX4 support (Experimental)"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
@@ -357,6 +383,7 @@ comment "SATA SFF controllers with BMDMA"
 config ATA_PIIX
 	tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for ICH5/6/7/8 Serial ATA
 	  and support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series
@@ -368,6 +395,7 @@ config SATA_DWC
 	tristate "DesignWare Cores SATA support"
 	depends on DMADEVICES
 	select GENERIC_PHY
+	select SATA_HOST
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
@@ -398,6 +426,7 @@ config SATA_DWC_VDEBUG
 config SATA_HIGHBANK
 	tristate "Calxeda Highbank SATA support"
 	depends on ARCH_HIGHBANK || COMPILE_TEST
+	select SATA_HOST
 	help
 	  This option enables support for the Calxeda Highbank SoC's
 	  onboard SATA.
@@ -409,6 +438,7 @@ config SATA_MV
 	depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
 		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	select GENERIC_PHY
+	select SATA_HOST
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
@@ -419,6 +449,7 @@ config SATA_MV
 config SATA_NV
 	tristate "NVIDIA SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for NVIDIA Serial ATA.
 
@@ -427,6 +458,7 @@ config SATA_NV
 config SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Promise Serial ATA TX2/TX4.
 
@@ -435,6 +467,7 @@ config SATA_PROMISE
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	select SATA_HOST
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 
@@ -443,6 +476,7 @@ config SATA_RCAR
 config SATA_SIL
 	tristate "Silicon Image SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
@@ -452,6 +486,7 @@ config SATA_SIS
 	tristate "SiS 964/965/966/180 SATA support"
 	depends on PCI
 	select PATA_SIS
+	select SATA_HOST
 	help
 	  This option enables support for SiS Serial ATA on
 	  SiS 964/965/966/180 and Parallel ATA on SiS 180.
@@ -462,6 +497,7 @@ config SATA_SIS
 config SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Broadcom/Serverworks/Apple K2
 	  SATA support.
@@ -471,6 +507,7 @@ config SATA_SVW
 config SATA_ULI
 	tristate "ULi Electronics SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for ULi Electronics SATA.
 
@@ -479,6 +516,7 @@ config SATA_ULI
 config SATA_VIA
 	tristate "VIA SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for VIA Serial ATA.
 
@@ -487,6 +525,7 @@ config SATA_VIA
 config SATA_VITESSE
 	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
@@ -1113,6 +1152,7 @@ config PATA_ACPI
 config ATA_GENERIC
 	tristate "Generic ATA support"
 	depends on PCI && ATA_BMDMA
+	select SATA_HOST
 	help
 	  This option enables support for generic BIOS configured
 	  ATA controllers via the new ATA layer
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index b5be6f43ec3f..17feff174f57 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -980,6 +980,7 @@ config SCSI_SYM53C8XX_MMIO
 config SCSI_IPR
 	tristate "IBM Power Linux RAID adapter support"
 	depends on PCI && SCSI && ATA
+	select SATA_HOST
 	select FW_LOADER
 	select IRQ_POLL
 	select SGL_ALLOC
diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
index 5c6a5eff2f8e..052ee3a26f6e 100644
--- a/drivers/scsi/libsas/Kconfig
+++ b/drivers/scsi/libsas/Kconfig
@@ -19,6 +19,7 @@ config SCSI_SAS_ATA
 	bool "ATA support for libsas (requires libata)"
 	depends on SCSI_SAS_LIBSAS
 	depends on ATA = y || ATA = SCSI_SAS_LIBSAS
+	select SATA_HOST
 	help
 		Builds in ATA support into libsas.  Will necessitate
 		the loading of libata along with libsas.
-- 
2.24.1

