From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH] ata: sata_rcar: Add r8a7793 device support
Date: Tue, 14 Oct 2014 16:31:34 +0900
Message-ID: <1413271894-10056-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33814 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaJNHbu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2014 03:31:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against for-next branch of Tejun's libata repo.

 drivers/ata/sata_rcar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 61eb6d7..6f8ed8e 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -841,6 +841,10 @@ static struct of_device_id sata_rcar_match[] = {
 		.compatible = "renesas,sata-r8a7791",
 		.data = (void *)RCAR_GEN2_SATA
 	},
+	{
+		.compatible = "renesas,sata-r8a7793",
+		.data = (void *)RCAR_GEN2_SATA
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
@@ -850,6 +854,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
 	{ "sata-r8a7779", RCAR_GEN1_SATA },
 	{ "sata-r8a7790", RCAR_GEN2_SATA },
 	{ "sata-r8a7791", RCAR_GEN2_SATA },
+	{ "sata-r8a7793", RCAR_GEN2_SATA },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
-- 
1.9.1

