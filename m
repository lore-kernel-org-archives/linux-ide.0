From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] sata_fsl: Return non-zero on error in probe()
Date: Wed, 14 Jan 2009 14:02:38 +0100
Message-ID: <200901141402.38174.sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:38571 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822AbZANNLk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 08:11:40 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ashish Kalra <ashish.kalra@freescale.com>
Cc: Li Yang <leoli@freescale.com>, linux-ide@vger.kernel.org

Hi,

while I was looking over kernel sources I've found this small bug.

>From 898778bad600f107f45be3cf959033efdcdd13c2 Mon Sep 17 00:00:00 2001
From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Wed, 14 Jan 2009 13:20:36 +0100
Subject: [PATCH] sata_fsl: Return non-zero on error in probe()

Formerly, zero was returned even if an error happened.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 drivers/ata/sata_fsl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 1a56db9..55bc88c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1288,7 +1288,7 @@ static const struct ata_port_info sata_fsl_port_info[] = {
 static int sata_fsl_probe(struct of_device *ofdev,
 			const struct of_device_id *match)
 {
-	int retval = 0;
+	int retval = -ENXIO;
 	void __iomem *hcr_base = NULL;
 	void __iomem *ssr_base = NULL;
 	void __iomem *csr_base = NULL;
-- 
1.5.6.5

