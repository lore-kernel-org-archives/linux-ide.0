Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E578FC6FD20
	for <linux-ide@archiver.kernel.org>; Wed,  8 Mar 2023 13:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCHNU0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Mar 2023 08:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjCHNSr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Mar 2023 08:18:47 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29716EA2
        for <linux-ide@vger.kernel.org>; Wed,  8 Mar 2023 05:15:38 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:614d:21b0:703:d0f9])
        by baptiste.telenet-ops.be with bizsmtp
        id VpFL2900G3mNwr401pFLC5; Wed, 08 Mar 2023 14:15:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZtd0-00BF17-DA;
        Wed, 08 Mar 2023 14:15:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZtEe-00FVSN-9A;
        Wed, 08 Mar 2023 13:49:36 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 resend 3] ahci: qoriq: Add platform dependencies
Date:   Wed,  8 Mar 2023 13:49:34 +0100
Message-Id: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
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
index b56fba76b43f48f7..42b51c9812a0ebab 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -276,6 +276,7 @@ config AHCI_XGENE
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
 	depends on OF
+	depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
-- 
2.34.1

