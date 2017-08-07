From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ata: make ata_port_operations const
Date: Mon,  7 Aug 2017 16:02:02 +0530
Message-ID: <1502101922-13313-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35388 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbdHGKcy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Aug 2017 06:32:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make ata_port_operations structures const as it is only stored in the
inherits field of an ata_port_operations structure. Therefore make it
const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/ata/pata_sis.c | 2 +-
 drivers/ata/sata_via.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 626f989..24614d2 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -549,7 +549,7 @@ static unsigned long sis_133_mode_filter(struct ata_device *adev, unsigned long
 	.cable_detect		= sis_133_cable_detect,
 };
 
-static struct ata_port_operations sis_base_ops = {
+static const struct ata_port_operations sis_base_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 	.prereset		= sis_pre_reset,
 };
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 93b8d78..83ba848 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -129,7 +129,7 @@ struct svia_priv {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static struct ata_port_operations svia_base_ops = {
+static const  struct ata_port_operations svia_base_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 	.sff_tf_load		= svia_tf_load,
 };
-- 
1.9.1

