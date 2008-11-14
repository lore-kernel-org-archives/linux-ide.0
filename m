From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata fix
Date: Fri, 14 Nov 2008 18:56:40 -0500
Message-ID: <20081114235640.GA3624@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:55801 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbYKNX4m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Nov 2008 18:56:42 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/libata-sff.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

Tejun Heo (1):
      libata: improve phantom device detection

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
