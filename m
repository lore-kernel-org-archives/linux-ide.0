From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: ahci_sunxi: make ahci_sunxi_resume() static
Date: Mon, 17 Mar 2014 14:06:57 +0100
Message-ID: <1725454.bVvdm9zQru@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58737 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932562AbaCQNHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2014 09:07:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci_sunxi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/ahci_sunxi.c
===================================================================
--- a/drivers/ata/ahci_sunxi.c	2014-03-17 13:59:05.556474489 +0100
+++ b/drivers/ata/ahci_sunxi.c	2014-03-17 13:59:06.220474478 +0100
@@ -209,7 +209,7 @@ disable_resources:
 }
 
 #ifdef CONFIG_PM_SLEEP
-int ahci_sunxi_resume(struct device *dev)
+static int ahci_sunxi_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;

