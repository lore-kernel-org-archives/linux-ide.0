From: akpm@linux-foundation.org
Subject: [patch 2/3] pata_amd: fix sparse warning
Date: Tue, 04 Mar 2008 15:16:17 -0800
Message-ID: <200803042316.m24NGHhP002484@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56741 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934974AbYCDXQ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 18:16:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, harvey.harrison@gmail.com, alan@lxorguk.ukuu.org.uk

From: Harvey Harrison <harvey.harrison@gmail.com>

Current code is essentially choosing between dividing by 1 or
dividing by two, make the conditions a little more obvious.

As a bonus, removes a sparse error:
drivers/ata/pata_amd.c:59:11: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_amd.c:59:11: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_amd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/ata/pata_amd.c~pata_amd-fix-sparse-warning drivers/ata/pata_amd.c
--- a/drivers/ata/pata_amd.c~pata_amd-fix-sparse-warning
+++ a/drivers/ata/pata_amd.c
@@ -56,7 +56,9 @@ static void timing_setup(struct ata_port
 	u8 t;
 
 	T = 1000000000 / amd_clock;
-	UT = T / min_t(int, max_t(int, clock, 1), 2);
+	UT = T;
+	if (clock >= 2)
+		UT = T / 2;
 
 	if (ata_timing_compute(adev, speed, &at, T, UT) < 0) {
 		dev_printk(KERN_ERR, &pdev->dev, "unknown mode %d.\n", speed);
_
