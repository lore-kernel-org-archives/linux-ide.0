Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D62DCCA47F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 08:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiFJITC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbiFJISm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 04:18:42 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A011B24B617;
        Fri, 10 Jun 2022 01:18:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 2DE9F16A6;
        Fri, 10 Jun 2022 11:19:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 2DE9F16A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849150;
        bh=Zs+DSEKY2IttBFqufTGwQAL3Q0cOXZPxf2nj/K3Sq/s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=PxmFGZU5FzCcwVJf/nb6amCx7GL7b9RTwYrXfd2oXmm4OZRuDcHfbh/a5lxwpDEI9
         EKDJPVd5reLR8AoI9w7dY+zPso9+4zpbaVV6acaaXLDYW9n4kOdPWcTa17m02+Ncpp
         mTOwj/XPR0HChB8bYKVzvVB/qRq7CS+PxPRQKJ9g=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 18/23] ata: libahci_platform: Add function returning a clock-handle by id
Date:   Fri, 10 Jun 2022 11:17:56 +0300
Message-ID: <20220610081801.11854-19-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Since all the clocks are retrieved by the method
ahci_platform_get_resources() there is no need for the LLD (glue) drivers
to be looking for some particular of them in the kernel clocks table
again. Instead we suggest to add a simple method returning a
device-specific clock with passed connection ID if it is managed to be
found. Otherwise the function will return NULL. Thus the glue-drivers
won't need to either manually touching the hpriv->clks array or calling
clk_get()-friends. The AHCI platform drivers will be able to use the new
function right after the ahci_platform_get_resources() method invocation
and up to the device removal.

Note the method is left unused here, but will be utilized in the framework
of the DWC AHCI SATA driver being added in the next commit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Fix some grammar mistakes in the method description.

Changelog v4:
- Add a note regarding the new method usage.
---
 drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
 include/linux/ahci_platform.h  |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 8b542a8bc487..418961f954af 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -95,6 +95,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
 
+/**
+ * ahci_platform_find_clk - Find platform clock
+ * @hpriv: host private area to store config values
+ * @con_id: clock connection ID
+ *
+ * This function returns a pointer to the clock descriptor of the clock with
+ * the passed ID.
+ *
+ * RETURNS:
+ * Pointer to the clock descriptor on success otherwise NULL
+ */
+struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
+{
+	struct clk *clk = NULL;
+	int i;
+
+	for (i = 0; i < hpriv->n_clks; i++) {
+		if (!strcmp(hpriv->clks[i].id, con_id)) {
+			clk = hpriv->clks[i].clk;
+			break;
+		}
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
+
 /**
  * ahci_platform_enable_clks - Enable platform clocks
  * @hpriv: host private area to store config values
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 6d7dd472d370..3418980b0341 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -13,6 +13,7 @@
 
 #include <linux/compiler.h>
 
+struct clk;
 struct device;
 struct ata_port_info;
 struct ahci_host_priv;
@@ -21,6 +22,8 @@ struct scsi_host_template;
 
 int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
+struct clk *
+ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
 int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);
-- 
2.35.1

