Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0CE94125
	for <linux-ide@archiver.kernel.org>; Fri,  6 Oct 2023 21:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjJFVoq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 6 Oct 2023 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjJFVop (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Oct 2023 17:44:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC922DB;
        Fri,  6 Oct 2023 14:44:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7580C433C7;
        Fri,  6 Oct 2023 21:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628684;
        bh=j6jeoiDnXWM/5Q7Gi01zs2uZBy0XxUNcurOM7FdoVAM=;
        h=From:To:Cc:Subject:Date:From;
        b=jYq+VfS3/DMO5bC4IGgNvqt8KM6g4g4McZgm98bSioUxP8aXXud0ST4iisuQQtTea
         OjLjgylHOsST1R8uPPdtGWOA3MbZDnnyrUmANNDM7Kfyw7gylfsbBVBUeNEe12q+Yz
         Z/g7x7LBrIktqtN9WM6zZviJJQ/ZmgkTaR3VNgLX01rVrX/cjFxQ3dpuCg7hHNw2pf
         1aEv05NZrCFdM00PGGS4pzTVhPeMJgs/kE16RZloU0Ee/YavGN1Vg/oB1+z6neovCc
         OgwE11i+jVm6PgittK3pbvaVW1XvzRfNTMA6yD7XFiRVTwBNpjHqrpIRl7/E72cUKG
         5vpBHC1Y/TRBQ==
Received: (nullmailer pid 339820 invoked by uid 1000);
        Fri, 06 Oct 2023 21:44:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: xgene: Use of_device_get_match_data()
Date:   Fri,  6 Oct 2023 16:44:33 -0500
Message-Id: <20231006214433.339688-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use preferred of_device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Perhaps device_get_match_data() could be used here and all the ACPI
specific code dropped, but not sure if all the ACPI code is really
necessary.
---
 drivers/ata/ahci_xgene.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index ccef5e63bdf9..81a1d838c0fc 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -13,9 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/ahci_platform.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include "ahci.h"
 
@@ -735,7 +733,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct xgene_ahci_context *ctx;
 	struct resource *res;
-	const struct of_device_id *of_devid;
 	enum xgene_ahci_version version = XGENE_AHCI_V1;
 	const struct ata_port_info *ppi[] = { &xgene_ahci_v1_port_info,
 					      &xgene_ahci_v2_port_info };
@@ -778,10 +775,8 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 		ctx->csr_mux = csr;
 	}
 
-	of_devid = of_match_device(xgene_ahci_of_match, dev);
-	if (of_devid) {
-		if (of_devid->data)
-			version = (unsigned long) of_devid->data;
+	if (dev->of_node) {
+		version = (enum xgene_ahci_version)of_device_get_match_data(dev);
 	}
 #ifdef CONFIG_ACPI
 	else {
-- 
2.40.1

