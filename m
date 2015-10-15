From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] pata_it821x: use "const char *" for string literals
Date: Thu, 15 Oct 2015 11:10:23 -0400
Message-ID: <20151015151023.GA27717@mtj.duckdns.org>
References: <1444850312-18158-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35472 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbbJOPK0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Oct 2015 11:10:26 -0400
Content-Disposition: inline
In-Reply-To: <1444850312-18158-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

Applied with updates to title and description.

Thanks.
----- 8< -----
>From 3a53b3bcc7af2f7ddfb682cb8efb26e40fe50fb1 Mon Sep 17 00:00:00 2001
From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Wed, 14 Oct 2015 21:18:31 +0200

Some string literals are pointed to by "char *".  This patch fixes
that.

tj: Updated patch title and description.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
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
2.4.3

