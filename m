From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2] ata: libahci: Silence compiler warning on 64-bit
Date: Fri,  1 Aug 2014 16:30:37 +0200
Message-ID: <1406903437-13995-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48416 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbaHAOam (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2014 10:30:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit 725c7b570fda (ata: libahci_platform: move port_map parameters
into the AHCI structure) moves flags into the struct ahci_host_priv's
.flags field, which causes compiler warnings on 64-bit builds when that
value is cast to a void * pointer. Cast to an unsigned long so that the
subsequent cast to a pointer doesn't produce a warning.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- cast unsigned int to unsigned long to avoid the compiler warning and
  keep the flags field's type as-is

 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index a60b8cd40198..5b92c290e6c6 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -426,7 +426,7 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	}
 
 	/* prepare host */
-	pi.private_data = (void *)hpriv->flags;
+	pi.private_data = (void *)(unsigned long)hpriv->flags;
 
 	ahci_save_initial_config(dev, hpriv);
 
-- 
2.0.3

