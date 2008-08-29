From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-sff: kill spurious WARN_ON() in ata_hsm_move()
Date: Fri, 29 Aug 2008 16:27:43 +0200
Message-ID: <48B8075F.9040805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756783AbYH2O3c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 10:29:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On HSM_ST_ERR, ata_hsm_move() triggers WARN_ON() if AC_ERR_DEV or
AC_ERR_HSM is not set.  PHY events may trigger HSM_ST_ERR with other
error codes and, with or without it, there just isn't much reason to
do WARN_ON() on it.  Even if error code is not set there, core EH
logic won't have any problem dealing with the error condition.

OSDL bz#11065 reports this problem.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 304fdc6..2a4c516 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1315,11 +1315,6 @@ fsm_start:
 		break;
 
 	case HSM_ST_ERR:
-		/* make sure qc->err_mask is available to
-		 * know what's wrong and recover
-		 */
-		WARN_ON(!(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM)));
-
 		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
