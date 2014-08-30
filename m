From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] libahci_platform: Staticize ahci_platform_<en/dis>able_phys()
Date: Sat, 30 Aug 2014 16:39:09 -0300
Message-ID: <1409427549-1846-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:55762 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaH3Tj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Aug 2014 15:39:26 -0400
Received: by mail-yh0-f45.google.com with SMTP id i57so2383040yha.4
        for <linux-ide@vger.kernel.org>; Sat, 30 Aug 2014 12:39:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

ahci_platform_enable_phys() and ahci_platform_disable_phys() are currently
exported, but they are not used anywhere else other than libahci_platform.c.

So make them static and do not export them to fix the following sparse
warnings:

drivers/ata/libahci_platform.c:52:5: warning: symbol 'ahci_platform_enable_phys' was not declared. Should it be static?
drivers/ata/libahci_platform.c:88:6: warning: symbol 'ahci_platform_disable_phys' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/libahci_platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index c0510de..c7f787e 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -49,7 +49,7 @@ static struct scsi_host_template ahci_platform_sht = {
  * RETURNS:
  * 0 on success otherwise a negative error code
  */
-int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
+static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
@@ -77,7 +77,6 @@ disable_phys:
 	}
 	return rc;
 }
-EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
 
 /**
  * ahci_platform_disable_phys - Disable PHYs
@@ -85,7 +84,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
  *
  * This function disables all PHYs found in hpriv->phys.
  */
-void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
+static void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 {
 	int i;
 
@@ -97,7 +96,6 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 		phy_exit(hpriv->phys[i]);
 	}
 }
-EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
 
 /**
  * ahci_platform_enable_clks - Enable platform clocks
-- 
1.9.1

