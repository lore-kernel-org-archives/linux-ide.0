From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] ata/pata_it821x: set array of const as const
Date: Wed, 14 Oct 2015 21:18:31 +0200
Message-ID: <1444850312-18158-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35787 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbJNTSk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2015 15:18:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Some array of const char are not set as const.
This patch fix that.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/ata/pata_it821x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index a5088ec..7a21edf 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -604,9 +604,9 @@ static void it821x_display_disk(int n, u8 *buf)
 {
 	unsigned char id[41];
 	int mode = 0;
-	char *mtype = "";
+	const char *mtype = "";
 	char mbuf[8];
-	char *cbl = "(40 wire cable)";
+	const char *cbl = "(40 wire cable)";
 
 	static const char *types[5] = {
 		"RAID0", "RAID1", "RAID 0+1", "JBOD", "DISK"
@@ -903,7 +903,7 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 
 	const struct ata_port_info *ppi[] = { NULL, NULL };
-	static char *mode[2] = { "pass through", "smart" };
+	static const char *mode[2] = { "pass through", "smart" };
 	int rc;
 
 	rc = pcim_enable_device(pdev);
-- 
2.4.9

