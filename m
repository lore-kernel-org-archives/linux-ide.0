Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB56C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F7522522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B8Ot9Ehl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgA1NeQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58896 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgA1NeP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133412euoutp01298e68f92b9fc8ae88b8c8fa48a6624e~uEE9oQU-20325703257euoutp01F
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133412euoutp01298e68f92b9fc8ae88b8c8fa48a6624e~uEE9oQU-20325703257euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218452;
        bh=RLgi3xyOZziUdWyXtNMjMVsiVYVnGbMcgDPO7LvqSCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8Ot9EhlHE9lNHBQm5Hu8knSmfv66dwjI3/znCy/Z/j98wsqSxZJ5Eue/aaYzFDQL
         MDixy7ThEh81In2ONh68JaqccDnnTA4EvmmABFT6r9tI2vu/qJvua66vTer2mKXqAl
         HpOaSJV1Ogd6XobnsWBuIjcv+ADvHEZQcGZeFTeM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eucas1p16bb8d8118a38e262142c0f84e9a39985~uEE9Wkm5v0713407134eucas1p1m;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8B.CA.61286.458303E5; Tue, 28
        Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133411eucas1p1671c280eb6f5d2ca2d10743eea6c96e5~uEE827OfJ0680006800eucas1p1m;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133411eusmtrp21fea6dacd033589ada9357901e954c37~uEE82Uhv_0330103301eusmtrp2n;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-75-5e303854d09f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.72.07950.358303E5; Tue, 28
        Jan 2020 13:34:11 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133411eusmtip20abd6e2f6735eb7b31e252fa758dff9e~uEE8bflkm0685506855eusmtip2T;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 03/28] ata: make SATA_PMP option selectable only if any SATA
 host driver is enabled
Date:   Tue, 28 Jan 2020 14:33:18 +0100
Message-Id: <20200128133343.29905-4-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87ohFgZxBu87uCxW3+1ns9g4Yz2r
        xbNbe5ksFt3YxmRxbMcjJovLu+awWSw//o/JYm7rdHYHDo+ds+6ye1w+W+px6HAHo8eERQcY
        PT4+vcXi0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnNV3YyFzwLqfg+9xpjA+N0py5GTg4J
        AROJGROvM3YxcnEICaxglDi8bgUrhPOFUeLJyk4o5zOjxJUjS5i6GDnAWqZtEIeIL2eUmHah
        GaGj59NudpC5bAJWEhPbVzGC2CICChI9v1eygRQxC0xgkviyfgULSEJYIFVia08bM4jNIqAq
        cWX/QiYQm1fAVmLt/EZWiAPlJbZ++8QKsplTwE6iZ685RImgxMmZT8DGMAOVNG+dzQwyX0Jg
        GbvE/dsL2SF6XSSWzp/MBGELS7w6vgUqLiPxf+d8JoiGdYwSfzteQHVvZ5RYPvkfG0SVtcSd
        c7/YQDYzC2hKrN+lDxF2lFi+cxorJCj4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJDcs2sMGs
        7dq5khnC9pDYvGgF0wRGxVlI3pmF5J1ZCHsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vO
        z93ECExEp/8d/7SD8eulpEOMAhyMSjy8M1QM4oRYE8uKK3MPMUpwMCuJ8HYyAYV4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpg3Nj8+sIeY409k56t2Ce4
        TJhbhzNyVeX3iqRGo4xFuSU2njt8DObeW/r30r/MDQoHs/5z2JyYWOoZwcUk+UxbPft0xqHq
        lfryyz6WsZ2J3HhtfbFmVJ29UM/qd+nigTquFoaph8Qflr40X6EyRfPRfZ4y4WIR9iXabeW7
        /KNzDC7GiixTsz6pxFKckWioxVxUnAgAyvjPYkADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7rBFgZxBgevK1usvtvPZrFxxnpW
        i2e39jJZLLqxjcni2I5HTBaXd81hs1h+/B+TxdzW6ewOHB47Z91l97h8ttTj0OEORo8Jiw4w
        enx8eovFo2/LKkaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DKar+xkLngWUvF97jXGBsbpTl2MHBwSAiYS0zaIdzFycggJLGWUOPcq
        AiIsI3F8fRlIWEJAWOLPtS62LkYuoJJPjBJ39p1nA0mwCVhJTGxfxQhiiwgoSPT8XglWxCww
        hUli4vtrYEXCAskSk9onsoPYLAKqElf2L2QCsXkFbCXWzm9khdggL7H12ydWkMWcAnYSPXvN
        Ie6xlVh/5ikrRLmgxMmZT1hAbGag8uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJu
        cWleul5yfu4mRmCsbDv2c8sOxq53wYcYBTgYlXh4HZQM4oRYE8uKK3MPMUpwMCuJ8HYyAYV4
        UxIrq1KL8uOLSnNSiw8xmgL9MJFZSjQ5HxjHeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGONvCk/4lsAgKW74fOldGeV8yysbVk+5ftZQULj6cOjX7DqrRL2y
        eXeCzqs+kH2ao8CytGupSrHuq+K68/snvHxskKiRVKu3f9avzriPy6S29p1s6JF87TTvvJWI
        ZtyXOYcjFOWWPX6il3FSz7rWTdzxgNyET7ZlD77YbtLKkxG27PJj/BxTpMRSnJFoqMVcVJwI
        AHvSQlqrAgAA
X-CMS-MailID: 20200128133411eucas1p1671c280eb6f5d2ca2d10743eea6c96e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133411eucas1p1671c280eb6f5d2ca2d10743eea6c96e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133411eucas1p1671c280eb6f5d2ca2d10743eea6c96e5
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133411eucas1p1671c280eb6f5d2ca2d10743eea6c96e5@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no reason to expose SATA_PMP config option when no SATA
host drivers are enabled. To fix it add SATA_HOST config option,
make all SATA host drivers select it and finally make SATA_PMP
config options depend on it.

This also serves as a preparation for the future changes which
optimize libata core code size on PATA only setups.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
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
index a7881f8eb05e..1b6eaf8da5fa 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -989,6 +989,7 @@ config SCSI_SYM53C8XX_MMIO
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

