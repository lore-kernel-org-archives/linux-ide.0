From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: give up hardreset on nf2
Date: Thu, 12 Feb 2009 10:34:32 +0900
Message-ID: <49937CA8.60005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50041 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828AbZBLBec (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 20:34:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>, saro_v@hotmail.it
Cc: stable@kernel.org

Kernel bz#12176 reports that nf2 hardreset simply doesn't work.  Give
up.  Argh...

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>
Reported-by: Saro <saro_v@hotmail.it>
---
 drivers/ata/sata_nv.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 444af04..55a8eed 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -421,19 +421,21 @@ static struct ata_port_operations nv_generic_ops = {
 	.hardreset		= ATA_OP_NULL,
 };
 
-/* OSDL bz3352 reports that nf2/3 controllers can't determine device
- * signature reliably.  Also, the following thread reports detection
- * failure on cold boot with the standard debouncing timing.
+/* nf2 is ripe with hardreset related problems.
+ *
+ * kernel bz#3352 reports nf2/3 controllers can't determine device
+ * signature reliably.  The following thread reports detection failure
+ * on cold boot with the standard debouncing timing.
  *
  * http://thread.gmane.org/gmane.linux.ide/34098
  *
- * Debounce with hotplug timing and request follow-up SRST.
+ * And bz#12176 reports that hardreset simply doesn't work on nf2.
+ * Give up on it and just don't do hardreset.
  */
 static struct ata_port_operations nv_nf2_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_generic_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
-	.hardreset		= nv_noclassify_hardreset,
 };
 
 /* For initial probing after boot and hot plugging, hardreset mostly
