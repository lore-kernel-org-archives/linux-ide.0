Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C7C433ED
	for <linux-ide@archiver.kernel.org>; Tue, 11 May 2021 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85326157F
	for <linux-ide@archiver.kernel.org>; Tue, 11 May 2021 09:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhEKJP4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 11 May 2021 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhEKJPz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 May 2021 05:15:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46EC061574
        for <linux-ide@vger.kernel.org>; Tue, 11 May 2021 02:14:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z13so27637930lft.1
        for <linux-ide@vger.kernel.org>; Tue, 11 May 2021 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PIPohEPvzF9ZT29Rw7ywQ+WMPHGOLCcNbluLGrI60U=;
        b=qXASl6tPH2/2f+kluTDR6V6ZeY0I+nH0l4SNaNnDrVQQPar0G8ugDGH5BS9WGlj6xH
         pG9xLuUTOBmeFEsbVCbYSSm4qpEGHZSXmnmGGOFEd+oH6wQpzmTDkiKhRFq3raX6gjlM
         Ryd+4HtoCxruHR3X+Od4xKrZ6cZNTkilRmv2p84y99W7G6F9BAb2ujIEO4c6BTAYytha
         yQlv1ryrVbbjTolqGavPW6Ef005QnOWgiDztezoxtlkamn+g2iPvof/1VaP1/Jfv/1U1
         xp2PWa8Izg6eTUIuqveBA5dRdQq5R2DXIIOJW4hw5jMu0/5GMbvwvzVQC7LZlUzgkq1q
         JI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PIPohEPvzF9ZT29Rw7ywQ+WMPHGOLCcNbluLGrI60U=;
        b=fOl8SdCt43k71SbG8aroQtPkwnU+0xMuPZb0lJJ+/C/AuDywnXO02p2SDua6ouI7fy
         5AeMVBD+GaSMXYKHxizI14m5fHg/9plj0x/8GbeTnhUSP0uYVG5W8yQjMz5S7ZrIiaZT
         JLKTf6Bv3VFAvBC3IdIfQwd102a+Tlce/uWwuLiEXjJCY8TW6Qz4L/JKp7KNs1G6tL3m
         3xfm8xnu9YFT0uH1RfZg9Cp30NtN84tlZQXtYVTaT6zvCAvEkjW5Tt8hso7xhTQZHwKW
         GQ+2zcVBfy3rhCHN/wFoZwjWyHV/im4En2gplljTN9tc1jzzI59RKVuc0Nq3PDuSy0g7
         iVzQ==
X-Gm-Message-State: AOAM530yGN5H9HSC1mkjJmHifa5wpMssMoyPIISeHPQ0dXlrGSo2W0ZK
        jpiTDtJezxmymsSMQKI6/8bwCAJyYTWceQ==
X-Google-Smtp-Source: ABdhPJxxwVsAeYnHsWy2u0C929pQFeHSkDZ9fBExV0aDJT/9IZKENHUxc3tFsJ3jlbwH7wMCKUqdRQ==
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr19757225lfo.19.1620724488213;
        Tue, 11 May 2021 02:14:48 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g28sm1276985ljn.134.2021.05.11.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 02:14:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] pata: ixp4xx: split platform data to its own header
Date:   Tue, 11 May 2021 11:14:44 +0200
Message-Id: <20210511091444.691815-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Portable drivers cannot use mach/platform.h, so move the
structure into its own header. With this, compile testing
can be enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi PATA maintainers: we intend to merge this through
ARM SoC along with other IXP4xx refactorings unless you
have a specific problem with the patch.
---
 arch/arm/mach-ixp4xx/avila-setup.c           |  1 +
 arch/arm/mach-ixp4xx/include/mach/platform.h | 14 -------------
 drivers/ata/Kconfig                          |  2 +-
 drivers/ata/pata_ixp4xx_cf.c                 |  1 +
 include/linux/platform_data/pata_ixp4xx_cf.h | 21 ++++++++++++++++++++
 5 files changed, 24 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/platform_data/pata_ixp4xx_cf.h

diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 1981b33109cb..ec1d3029f80c 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -19,6 +19,7 @@
 #include <linux/tty.h>
 #include <linux/serial_8250.h>
 #include <linux/gpio/machine.h>
+#include <linux/platform_data/pata_ixp4xx_cf.h>
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index 6d403fe0bf52..d8b4df96db08 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -79,20 +79,6 @@ extern unsigned long ixp4xx_exp_bus_size;
 #define IXP4XX_PERIPHERAL_BUS_CLOCK 	(66) /* 66MHzi APB BUS   */ 
 #define IXP4XX_UART_XTAL        	14745600
 
-/*
- * This structure provide a means for the board setup code
- * to give information to th pata_ixp4xx driver. It is
- * passed as platform_data.
- */
-struct ixp4xx_pata_data {
-	volatile u32	*cs0_cfg;
-	volatile u32	*cs1_cfg;
-	unsigned long	cs0_bits;
-	unsigned long	cs1_bits;
-	void __iomem	*cs0;
-	void __iomem	*cs1;
-};
-
 /*
  * Frequency of clock used for primary clocksource
  */
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 030cb32da980..d17c83319e70 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1058,7 +1058,7 @@ config PATA_ISAPNP
 
 config PATA_IXP4XX_CF
 	tristate "IXP4XX Compact Flash support"
-	depends on ARCH_IXP4XX
+	depends on ARCH_IXP4XX || COMPILE_TEST
 	help
 	  This option enables support for a Compact Flash connected on
 	  the ixp4xx expansion bus. This driver had been written for
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 43215a4c1e54..5881d64af943 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -17,6 +17,7 @@
 #include <linux/libata.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/pata_ixp4xx_cf.h>
 #include <scsi/scsi_host.h>
 
 #define DRV_NAME	"pata_ixp4xx_cf"
diff --git a/include/linux/platform_data/pata_ixp4xx_cf.h b/include/linux/platform_data/pata_ixp4xx_cf.h
new file mode 100644
index 000000000000..601ba97fef57
--- /dev/null
+++ b/include/linux/platform_data/pata_ixp4xx_cf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PLATFORM_DATA_PATA_IXP4XX_H
+#define __PLATFORM_DATA_PATA_IXP4XX_H
+
+#include <linux/types.h>
+
+/*
+ * This structure provide a means for the board setup code
+ * to give information to th pata_ixp4xx driver. It is
+ * passed as platform_data.
+ */
+struct ixp4xx_pata_data {
+	volatile u32	*cs0_cfg;
+	volatile u32	*cs1_cfg;
+	unsigned long	cs0_bits;
+	unsigned long	cs1_bits;
+	void __iomem	*cs0;
+	void __iomem	*cs1;
+};
+
+#endif
-- 
2.30.2

