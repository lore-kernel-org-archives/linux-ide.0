From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 3/4] libata: when restoring SControl during
 detach do the PMP links first
Date: Sun, 26 Oct 2008 15:51:58 +0900
Message-ID: <4904138E.7010905@kernel.org>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52804 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbYJZGwG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Oct 2008 02:52:06 -0400
In-Reply-To: <4904135B.4040901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

When restoring SControl during detach, PMP links should be handled
first as changing SControl of the host link can affect SCR access of
PMP links.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -6035,7 +6035,7 @@ static void ata_port_detach(struct ata_p
 	/* EH is now guaranteed to see UNLOADING - EH context belongs
 	 * to us.  Restore SControl and disable all existing devices.
 	 */
-	ata_for_each_link(link, ap, HOST_FIRST) {
+	ata_for_each_link(link, ap, PMP_FIRST) {
 		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol);
 		ata_for_each_dev(dev, link, ALL)
 			ata_dev_disable(dev);
