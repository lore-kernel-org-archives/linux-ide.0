From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] libata: consider errors not associated with commands for speed down
Date: Wed, 31 Oct 2007 10:17:05 +0900
Message-ID: <1193793427209-git-send-email-htejun@gmail.com>
References: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:1273 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbXJaBdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:33:46 -0400
In-Reply-To: <11937934273607-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata EH used to ignore errors not associated with commands when
determining whether speed down is necessary or not.  This leads to the
following problems.

* Errors not associated with commands can occur indefinitely without
  libata EH taking corrective actions.

* Upstream link errors don't trigger speed down when PMP is attached
  to it and commands issued to downstream device trigger errors on the
  upstream link.

This patch makes ata_eh_link_autopsy() consider errors not associated
with command for speed down.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 10af1a8..ded44bd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1747,6 +1747,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev;
 	unsigned int all_err_mask = 0;
 	int tag, is_io = 0;
 	u32 serror;
@@ -1819,18 +1820,24 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	else if (all_err_mask)
 		ehc->i.action |= ATA_EH_REVALIDATE;
 
-	/* if we have offending qcs and the associated failed device */
+	/* If we have offending qcs and the associated failed device,
+	 * perform per-dev EH action only on the offending device.
+	 */
 	if (ehc->i.dev) {
-		/* speed down */
-		ehc->i.action |= ata_eh_speed_down(ehc->i.dev, is_io,
-						   all_err_mask);
-
-		/* perform per-dev EH action only on the offending device */
 		ehc->i.dev_action[ehc->i.dev->devno] |=
 			ehc->i.action & ATA_EH_PERDEV_MASK;
 		ehc->i.action &= ~ATA_EH_PERDEV_MASK;
 	}
 
+	/* consider speeding down */
+	dev = ehc->i.dev;
+	if (!dev && ata_link_max_devices(link) == 1 &&
+	    ata_dev_enabled(link->device))
+		dev = link->device;
+
+	if (dev)
+		ehc->i.action |= ata_eh_speed_down(dev, is_io, all_err_mask);
+
 	DPRINTK("EXIT\n");
 }
 
-- 
1.5.2.4

