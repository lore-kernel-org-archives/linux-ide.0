Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4FDC5517A
	for <linux-ide@archiver.kernel.org>; Tue, 10 Nov 2020 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4581620674
	for <linux-ide@archiver.kernel.org>; Tue, 10 Nov 2020 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgKJPqY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJPqW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2020 10:46:22 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A6C0613CF
        for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2020 07:46:21 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id qfmH2300b4C55Sk01fmHkR; Tue, 10 Nov 2020 16:46:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcVqb-001DMN-DH; Tue, 10 Nov 2020 16:46:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcVqa-00DmdO-Qo; Tue, 10 Nov 2020 16:46:16 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2] ahci: qoriq: Add platform dependencies
Date:   Tue, 10 Nov 2020 16:46:15 +0100
Message-Id: <20201110154615.3285171-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The Freescale QorIQ AHCI SATA controller is only present on Freescale
Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
symbol, to avoid asking the user about it when configuring a kernel
without Layerscape support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
v2:
  - Add Acked-by.
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 030cb32da980fc47..9ec6bce27c91511b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -264,6 +264,7 @@ config AHCI_XGENE
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
 	depends on OF
+	depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
-- 
2.25.1

