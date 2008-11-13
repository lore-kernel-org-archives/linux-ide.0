From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: improve phantom device detection
Date: Thu, 13 Nov 2008 10:04:46 +0900
Message-ID: <491B7D2E.5040004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54475 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbYKMBFb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 20:05:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>
Cc: stable@kernel.org

Currently libata uses four methods to detect device presence.

1. PHY status if available.
2. TF register R/W test (only promotes presence, never demotes)
3. device signature after reset
4. IDENTIFY failure detection in SFF state machine

Combination of the above works well in most cases but recently there
have been a few reports where a phantom device causes unnecessary
delay during probe.  In both cases, PHY status wasn't available.  In
one case, it passed #2 and #3 and failed IDENTIFY with ATA_ERR which
didn't qualify as #4.  The other failed #2 but as it passed #3 and #4,
it still caused failure.

In both cases, phantom device reported diagnostic failure, so these
cases can be safely worked around by considering any !ATA_DRQ IDENTIFY
failure as NODEV_HINT if diagnostic failure is set.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4b47394..9033d16 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1227,10 +1227,19 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
-				if (likely(status & (ATA_ERR | ATA_DF)))
+				if (likely(status & (ATA_ERR | ATA_DF))) {
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
-				else {
+
+					/* If diagnostic failed and this is
+					 * IDENTIFY, it's likely a phantom
+					 * device.  Mark hint.
+					 */
+					if (qc->dev->horkage &
+					    ATA_HORKAGE_DIAGNOSTIC)
+						qc->err_mask |=
+							AC_ERR_NODEV_HINT;
+				} else {
 					/* HSM violation. Let EH handle this.
 					 * Phantom devices also trigger this
 					 * condition.  Mark hint.
