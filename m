Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4CC7EE29
	for <linux-ide@archiver.kernel.org>; Tue, 13 Jun 2023 06:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjFMGeo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFMGen (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2023 02:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60D1AD
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 23:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48FA660F78
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2023 06:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1073C433EF
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2023 06:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686638080;
        bh=RF9Yoo/7HRh2jnkwAdLMUURw1jF3CkoBUcske8vUqCU=;
        h=From:To:Subject:Date:From;
        b=RAtgeUGUI7pAtBW9bqmRs6HcvxV24H5AJxt3AfcdZc/xm8Kg29IrOGlp+aNn6bp/p
         mVRTx02azUZ4puV4oI7tOHyyIblrefUSsWIXMthl+s+1d6XJg0LSepPk29KHDHpPtD
         whp3ATweOwUirzyD/pJOs+W4ONprs8k+pcoXwQGC1p3v9Dyp8wiCESuBYZ2aGdAky4
         ogRpD7mRtcqm8KPkfCddsVCe4zvruSxUrdhrT5kGIfXI4hlW5fyUK5KxHd93JYm/PH
         10CPKjijrGPmqBSlgYdTClebUgn6YWac7BFZQww10cqZHDUu0PnC+VgekShXNZYhMM
         6sX5mBceMLqKw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Cleanup ahci_reset_controller()
Date:   Tue, 13 Jun 2023 15:34:36 +0900
Message-Id: <20230613063436.370406-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix multi-line comment style in ahci_reset_controller() and change the
code to return early if ahci_skip_host_reset is true, reducing
indentation by one level for the bulk of the function code.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libahci.c | 61 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 9c2cb6cbea76..bd38ff72e543 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -975,44 +975,43 @@ int ahci_reset_controller(struct ata_host *host)
 	void __iomem *mmio = hpriv->mmio;
 	u32 tmp;
 
-	/* we must be in AHCI mode, before using anything
-	 * AHCI-specific, such as HOST_RESET.
+	/*
+	 * We must be in AHCI mode, before using anything AHCI-specific, such
+	 * as HOST_RESET.
 	 */
 	ahci_enable_ahci(mmio);
 
-	/* global controller reset */
-	if (!ahci_skip_host_reset) {
-		tmp = readl(mmio + HOST_CTL);
-		if ((tmp & HOST_RESET) == 0) {
-			writel(tmp | HOST_RESET, mmio + HOST_CTL);
-			readl(mmio + HOST_CTL); /* flush */
-		}
+	/* Global controller reset */
+	if (ahci_skip_host_reset) {
+		dev_info(host->dev, "Skipping global host reset\n");
+		return 0;
+	}
 
-		/*
-		 * to perform host reset, OS should set HOST_RESET
-		 * and poll until this bit is read to be "0".
-		 * reset must complete within 1 second, or
-		 * the hardware should be considered fried.
-		 */
-		tmp = ata_wait_register(NULL, mmio + HOST_CTL, HOST_RESET,
-					HOST_RESET, 10, 1000);
+	tmp = readl(mmio + HOST_CTL);
+	if ((tmp & HOST_RESET) == 0) {
+		writel(tmp | HOST_RESET, mmio + HOST_CTL);
+		readl(mmio + HOST_CTL); /* flush */
+	}
 
-		if (tmp & HOST_RESET) {
-			dev_err(host->dev, "controller reset failed (0x%x)\n",
-				tmp);
-			return -EIO;
-		}
+	/*
+	 * To perform host reset, OS should set HOST_RESET and poll until this
+	 * bit is read to be "0". Reset must complete within 1 second, or the
+	 * hardware should be considered fried.
+	 */
+	tmp = ata_wait_register(NULL, mmio + HOST_CTL, HOST_RESET,
+				HOST_RESET, 10, 1000);
+	if (tmp & HOST_RESET) {
+		dev_err(host->dev, "Controller reset failed (0x%x)\n",
+			tmp);
+		return -EIO;
+	}
 
-		/* turn on AHCI mode */
-		ahci_enable_ahci(mmio);
+	/* Turn on AHCI mode */
+	ahci_enable_ahci(mmio);
 
-		/* Some registers might be cleared on reset.  Restore
-		 * initial values.
-		 */
-		if (!(hpriv->flags & AHCI_HFLAG_NO_WRITE_TO_RO))
-			ahci_restore_initial_config(host);
-	} else
-		dev_info(host->dev, "skipping global host reset\n");
+	/* Some registers might be cleared on reset. Restore initial values. */
+	if (!(hpriv->flags & AHCI_HFLAG_NO_WRITE_TO_RO))
+		ahci_restore_initial_config(host);
 
 	return 0;
 }
-- 
2.40.1

