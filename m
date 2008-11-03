From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: mask off DET when restoring SControl
 for detach
Date: Mon, 03 Nov 2008 19:27:07 +0900
Message-ID: <490ED1FB.9080505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbYKCK1S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:27:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

libata restores SControl on detach; however, trying to restore
non-zero DET can cause undeterministic behavior including PMP device
going offline till power cycling.  Mask off DET when restoring
SControl.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5936,7 +5936,7 @@ static void ata_port_detach(struct ata_p
 	 * to us.  Restore SControl and disable all existing devices.
 	 */
 	__ata_port_for_each_link(link, ap) {
-		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol);
+		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol & 0xff0);
 		ata_link_for_each_dev(dev, link)
 			ata_dev_disable(dev);
 	}
