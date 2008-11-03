From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream 2/3] libata: when restoring SControl during detach
 do the PMP links first
Date: Mon, 03 Nov 2008 20:03:49 +0900
Message-ID: <490EDA95.6070409@kernel.org>
References: <490EDA75.5060703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40184 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937AbYKCLEB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 06:04:01 -0500
In-Reply-To: <490EDA75.5060703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Elias Oltmanns <eo@nebensachen.de>

When restoring SControl during detach, PMP links should be handled
first as changing SControl of the host link can affect SCR access of
PMP links.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f527c30..0e03644 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5995,7 +5995,7 @@ static void ata_port_detach(struct ata_port *ap)
 	/* EH is now guaranteed to see UNLOADING - EH context belongs
 	 * to us.  Restore SControl and disable all existing devices.
 	 */
-	ata_for_each_link(link, ap, HOST_FIRST) {
+	ata_for_each_link(link, ap, PMP_FIRST) {
 		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol & 0xff0);
 		ata_for_each_dev(dev, link, ALL)
 			ata_dev_disable(dev);
-- 
1.5.4.5

