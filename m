From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Wed, 13 Feb 2008 10:09:10 -1100
Message-ID: <12029369532977-git-send-email-saeed@marvell.com>
References: <12029369502995-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:39080 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752573AbYBMS4i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 13:56:38 -0500
In-Reply-To: <12029369502995-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mlord@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, nico@cam.org, byron.bbradley@gmail.com, Saeed Bishara <saeed@marvell.com>

this will fix crash bug when doing rmmod to the driver, this is because the
port_stop function get called later and it could access the device's registers.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9c9a5b0..c61e666 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2983,11 +2983,8 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
-	struct mv_host_priv *hpriv = host->private_data;
-	void __iomem *base = hpriv->base;
 
 	ata_host_detach(host);
-	iounmap(base);
 	return 0;
 }
 
-- 
1.5.2.5

