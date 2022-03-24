Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBCC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 15:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiC1Pp5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiC1Ppx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2022 11:45:53 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 08:44:12 PDT
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC19F4A3DA;
        Mon, 28 Mar 2022 08:44:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3AED81E28CE;
        Thu, 24 Mar 2022 03:16:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 3AED81E28CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648080993;
        bh=2mpUwqvt6jhlU4kITXFYLbEPNQX4H7H63PF3OhAFvwY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=F98vbiCtXo6l3wibvJtbTxJaphXbQJCdCFuXr6KFLkJsVVRRjWWSBMqgCvtEBqYrY
         s2TX5/6BfIOdMQDe/BiGQRxb6+wTMaf6SY8raI63WIMHVaI32cy3VJMCjvNVUFi+py
         IcxDYs5GJSjTX90dzfS6ClJg88Q3wSCi6imxEOfM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:33 +0300
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
Subject: [PATCH 03/21] ata: libahci_platform: Explicitly set rc on devres_alloc failure
Date:   Thu, 24 Mar 2022 03:16:10 +0300
Message-ID: <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

It's better for readability and maintainability to explicitly assign an
error number to the variable used then as a return value from the method
on the cleanup-on-error path. So adding new code in the method we won't
have to think whether the overridden rc-variable is set afterward in case
of an error. Saving one line of code doesn't worth it especially seeing
the rest of the ahci_platform_get_resources() function errors handling
blocks do explicitly write errno to rc.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/ata/libahci_platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 18296443ccba..1bd2f1686239 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
 	struct device_node *child;
-	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
+	int i, enabled_ports = 0, rc = 0, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
 			     GFP_KERNEL);
-	if (!hpriv)
+	if (!hpriv) {
+		rc = -ENOMEM;
 		goto err_out;
+	}
 
 	devres_add(dev, hpriv);
 
-- 
2.35.1

