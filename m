From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ata: sata_rcar: Remove obsolete sata-r8a779* platform_device_id entries
Date: Tue, 23 Jun 2015 14:55:13 +0200
Message-ID: <1435064113-10742-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:54032 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520AbbFWMzP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2015 08:55:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
board support"), R-Car Gen2 SoCs are only supported in generic DT-only
ARM multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/sata_rcar.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index d49a5193b7de9e94..8804127b108c0f8e 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -861,10 +861,6 @@ MODULE_DEVICE_TABLE(of, sata_rcar_match);
 static const struct platform_device_id sata_rcar_id_table[] = {
 	{ "sata_rcar", RCAR_GEN1_SATA }, /* Deprecated by "sata-r8a7779" */
 	{ "sata-r8a7779", RCAR_GEN1_SATA },
-	{ "sata-r8a7790", RCAR_GEN2_SATA },
-	{ "sata-r8a7790-es1", RCAR_R8A7790_ES1_SATA },
-	{ "sata-r8a7791", RCAR_GEN2_SATA },
-	{ "sata-r8a7793", RCAR_GEN2_SATA },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
-- 
1.9.1

