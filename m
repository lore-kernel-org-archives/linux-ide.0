From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ata: declare ata_port_info structures as const
Date: Fri,  9 Jun 2017 17:15:08 +0530
Message-ID: <1497008708-9026-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33411 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFILqz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jun 2017 07:46:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

ata_port_info structures are either copied to other objects or their
references are stored in objects of type const. So, ata_port_info
structures having similar usage pattern can be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/ata/pata_rdc.c      | 2 +-
 drivers/ata/pata_sch.c      | 2 +-
 drivers/ata/sata_inic162x.c | 2 +-
 drivers/ata/sata_via.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 9ce5952..959bb54 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -292,7 +292,7 @@ static struct ata_port_operations rdc_pata_ops = {
 	.prereset		= rdc_pata_prereset,
 };
 
-static struct ata_port_info rdc_port_info = {
+static const struct ata_port_info rdc_port_info = {
 
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= ATA_PIO4,
diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index b920c34..1b80a66 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -81,7 +81,7 @@ static struct ata_port_operations sch_pata_ops = {
 	.set_dmamode		= sch_set_dmamode,
 };
 
-static struct ata_port_info sch_port_info = {
+static const struct ata_port_info sch_port_info = {
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index e81a821..9b6d793 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -737,7 +737,7 @@ static struct ata_port_operations inic_port_ops = {
 	.port_start		= inic_port_start,
 };
 
-static struct ata_port_info inic_port_info = {
+static const struct ata_port_info inic_port_info = {
 	.flags			= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
 	.pio_mask		= ATA_PIO4,
 	.mwdma_mask		= ATA_MWDMA2,
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f3f538e..31a2768 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -166,7 +166,7 @@ static const struct ata_port_info vt6420_port_info = {
 	.port_ops	= &vt6420_sata_ops,
 };
 
-static struct ata_port_info vt6421_sport_info = {
+static const struct ata_port_info vt6421_sport_info = {
 	.flags		= ATA_FLAG_SATA,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
@@ -174,7 +174,7 @@ static struct ata_port_info vt6421_sport_info = {
 	.port_ops	= &vt6421_sata_ops,
 };
 
-static struct ata_port_info vt6421_pport_info = {
+static const struct ata_port_info vt6421_pport_info = {
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= ATA_PIO4,
 	/* No MWDMA */
@@ -182,7 +182,7 @@ static struct ata_port_info vt6421_pport_info = {
 	.port_ops	= &vt6421_pata_ops,
 };
 
-static struct ata_port_info vt8251_port_info = {
+static const struct ata_port_info vt8251_port_info = {
 	.flags		= ATA_FLAG_SATA | ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
-- 
2.7.4

