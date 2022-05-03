Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F67AC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  3 May 2022 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiECUTr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 May 2022 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiECUTE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2022 16:19:04 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5B4428992
        for <linux-ide@vger.kernel.org>; Tue,  3 May 2022 13:15:30 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8F2A916DC;
        Tue,  3 May 2022 23:10:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8F2A916DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651608638;
        bh=ghQlSwR0k/fSp9BKKIsDgiCPjiVeG/HGpUtiHAxSYNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=meW5KMaUHdkH6n4Q5WaAJPSKTyJTtY1DhwNuCc42mQ/Z1UyLkp9+TR31Dwi4PVgzU
         4af7/zxv3af+2xGg9Z7N5ZkDfSFJfgAw3fa/MwMXqbKQCqA9RM3q0RrofOnDshZCJY
         MJCoyziFowwKTbERXUB6f+pRte0daUZLy4EOoP0c=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:10:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 06/23] ata: libahci_platform: Convert to using platform devm-ioremap methods
Date:   Tue, 3 May 2022 23:09:21 +0300
Message-ID: <20220503200938.18027-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Currently the IOMEM AHCI registers space is mapped by means of the
two functions invocation: platform_get_resource() is used to get the very
first memory resource and devm_ioremap_resource() is called to remap that
resource. Device-managed kernel API provides a handy wrapper to perform
the same in single function call: devm_platform_ioremap_resource().

While at it seeing many AHCI platform drivers rely on having the AHCI CSR
space marked with "ahci" name let's first try to find and remap the CSR
IO-mem with that name and only if it fails fallback to getting the very
first registers space platform resource.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Check whether there is "ahhi" reg resource before using the
  devm_platform_ioremap_resource_byname() method in order to prevent a
  false error message printed in the log (@Damien)
- Slightly update the patch title due to the change above and to be more
  specific that the platform device managed methods are utilized.
---
 drivers/ata/libahci_platform.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index f7f9bfcfc164..8c9fbcc3043b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -404,8 +404,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	devres_add(dev, hpriv);
 
-	hpriv->mmio = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	/*
+	 * If the DT provided an "ahci" named resource, use it. Otherwise,
+	 * fallback to using the default first resource for the device node.
+	 */
+	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
+		hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
+	else
+		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hpriv->mmio)) {
 		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
-- 
2.35.1

