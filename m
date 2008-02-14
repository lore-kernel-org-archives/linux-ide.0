From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 3/3] ata: simplify clock divisor logic in pata_amd.c
Date: Thu, 14 Feb 2008 10:45:25 -0800
Message-ID: <1203014725.2748.65.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:15625 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043AbYBNSp3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:45:29 -0500
Received: by rv-out-0910.google.com with SMTP id k20so287556rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:45:27 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>

Current code is essentially choosing between dividing by 1 or
dividing by two, make the conditions a little more obvious.

As a bonus, removes a sparse error:
drivers/ata/pata_amd.c:59:11: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_amd.c:59:11: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/pata_amd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 4b8d9b5..eaadb78 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -56,7 +56,10 @@ static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offse
 	u8 t;
 
 	T = 1000000000 / amd_clock;
-	UT = T / min_t(int, max_t(int, clock, 1), 2);
+	if (clock >= 2)
+		UT = T / 2;
+	else
+		UT = t;
 
 	if (ata_timing_compute(adev, speed, &at, T, UT) < 0) {
 		dev_printk(KERN_ERR, &pdev->dev, "unknown mode %d.\n", speed);
-- 
1.5.4.1.1278.gc75be

