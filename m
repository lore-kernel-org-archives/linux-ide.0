From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] libata: fix EH device failure handling
Date: Thu, 29 Jan 2009 20:31:29 +0900
Message-ID: <1233228696-10562-2-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34084 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbZA2Lbw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:31:52 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

The dev->pio_mode > XFER_PIO_0 test is there to avoid unnecessary
speed down warning messages but it accidentally disabled SATA link spd
down during configuration phase after reset where PIO mode is always
zero.

This patch fixes the problem by moving the test where it belongs.
This makes libata probing sequence behave better when the connection
is flaky at higher link speeds which isn't too uncommon for eSATA
devices.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8147a83..c15572d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2979,12 +2979,13 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 		/* give it just one more chance */
 		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
 	case -EIO:
-		if (ehc->tries[dev->devno] == 1 && dev->pio_mode > XFER_PIO_0) {
+		if (ehc->tries[dev->devno] == 1) {
 			/* This is the last chance, better to slow
 			 * down than lose it.
 			 */
 			sata_down_spd_limit(ata_dev_phys_link(dev));
-			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
+			if (dev->pio_mode > XFER_PIO_0)
+				ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
 		}
 	}
 
-- 
1.6.0.2

