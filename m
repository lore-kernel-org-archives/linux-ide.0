From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] libata: don't set IORDY for reset
Date: Thu, 11 Jun 2009 11:04:45 +0900
Message-ID: <4A30663D.9050008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49180 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbZFKCF5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 22:05:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, gnoutchd@union.edu, constantine.gavrilov@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Before issuing reset, libata configures xfermode to PIO0 which makes
some drivers turn on IORDY which may cause the controller to lock up
if the port is not occupied.  IORDY isn't necessary at this point
anyway.  Make ata_pio_need_iordy() return zero if it's being called
for reset.

This fixes bko#11703.  Reported and tracked down by Daniel Gnoutcheff
and Constantine Gavrilov.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Daniel Gnoutcheff <gnoutchd@union.edu>
Cc: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-core.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ca4d208..41d5593 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1993,11 +1993,17 @@ unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
  *	Check if the current speed of the device requires IORDY. Used
  *	by various controllers for chip configuration.
  */
-
 unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 {
-	/* Controller doesn't support  IORDY. Probably a pointless check
-	   as the caller should know this */
+	/* Don't set IORDY if we're preparing for reset.  IORDY may
+	 * lead to controller lock up on certain controllers if the
+	 * port is not occupied.  See bko#11703 for details.
+	 */
+	if (adev->link->ap->pflags & ATA_PFLAG_RESETTING)
+		return 0;
+	/* Controller doesn't support IORDY.  Probably a pointless
+	 * check as the caller should know this.
+	 */
 	if (adev->link->ap->flags & ATA_FLAG_NO_IORDY)
 		return 0;
 	/* CF spec. r4.1 Table 22 says no iordy on PIO5 and PIO6.  */
@@ -2020,7 +2026,6 @@ unsigned int ata_pio_need_iordy(const struct ata_device *adev)
  *	Compute the highest mode possible if we are not using iordy. Return
  *	-1 if no iordy mode is available.
  */
-
 static u32 ata_pio_mask_no_iordy(const struct ata_device *adev)
 {
 	/* If we have no drive specific rule, then PIO 2 is non IORDY */
