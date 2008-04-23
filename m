From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: make WARN_ON conditions in ata_sff_hsm_move() more
 strict
Date: Wed, 23 Apr 2008 20:48:36 +0900
Message-ID: <480F2214.1070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.224]:47674 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbYDWLsn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 07:48:43 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2566637qbe.15
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 04:48:42 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

WARN_ON()'s in ata_hsm_move() was too liberal and got triggerred when
it shouldn't (e.g. hotplug events at the right moment).  As the HSM
only deals with device errors and state machine violations, make it
check only against them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
Cc: Albert Lee <albertcc@tw.ibm.com>
---
 drivers/ata/libata-sff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 1549952..2ec65a8 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1208,7 +1208,7 @@ fsm_start:
 		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
 			ap->print_id, qc->dev->devno, status);
 
-		WARN_ON(qc->err_mask);
+		WARN_ON(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
 
 		ap->hsm_task_state = HSM_ST_IDLE;
 
@@ -1222,7 +1222,7 @@ fsm_start:
 		/* make sure qc->err_mask is available to
 		 * know what's wrong and recover
 		 */
-		WARN_ON(qc->err_mask == 0);
+		WARN_ON(!(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM)));
 
 		ap->hsm_task_state = HSM_ST_IDLE;
 
