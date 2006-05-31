From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/02] libata: shift host flag constants
Date: Wed, 31 May 2006 19:19:32 +0900
Message-ID: <20060531101932.GA8106@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:14579 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751577AbWEaKTi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 06:19:38 -0400
Received: by py-out-1112.google.com with SMTP id e30so1020779pya
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 03:19:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Nudge host flag constants to make a room after ATA_FLAG_EH_PENDING.
New EH flag will be added.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

7395acb2c840fd4d0cacc91d6fb71440057141ab
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b0ee1c1..3f9c65f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -149,14 +149,14 @@ enum {
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
-	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
-					      * doesn't handle PIO interrupts */
-	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
+	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
+					     * doesn't handle PIO interrupts */
+	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
 
-	ATA_FLAG_DEBUGMSG	= (1 << 14),
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
+	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
 
-	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
+	ATA_FLAG_EH_PENDING	= (1 << 15), /* EH pending */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
 	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
 
-- 
1.3.2
