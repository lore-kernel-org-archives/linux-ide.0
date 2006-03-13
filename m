From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/3] libata-dev: Remove trailing whitespaces
Date: Mon, 13 Mar 2006 15:25:39 +0800
Message-ID: <44151E73.20002@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com> <44136B04.4090203@pobox.com> <44151D53.3040606@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58768 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751554AbWCMHZp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:25:45 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7Pjtl014766
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:25:45 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7Scfw188688
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:28:38 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7Pikm001556
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:25:45 -0700
In-Reply-To: <44151D53.3040606@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Remove trailing whitespaces.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Remove trailing whitespaces per Tejun's advice.

--- irq-pio0/drivers/scsi/libata-core.c	2006-03-13 10:02:51.000000000 +0800
+++ 001_whitespace/drivers/scsi/libata-core.c	2006-03-13 12:38:03.000000000 +0800
@@ -4594,7 +4594,7 @@ inline unsigned int ata_host_intr (struc
 fsm_start:
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
-		/* Some pre-ATAPI-4 devices assert INTRQ 
+		/* Some pre-ATAPI-4 devices assert INTRQ
 		 * at this state when ready to receive CDB.
 		 */
 
@@ -4619,7 +4619,7 @@ fsm_start:
 				ap->hsm_task_state = HSM_ST_LAST;
 				goto fsm_start;
 			}
-			
+
 			atapi_pio_bytes(qc);
 
 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
@@ -4673,7 +4673,7 @@ fsm_start:
 			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
 			       ap->id, status, host_stat);
 
-		/* make sure qc->err_mask is available to 
+		/* make sure qc->err_mask is available to
 		 * know what's wrong and recover
 		 */
 		WARN_ON(qc->err_mask == 0);


