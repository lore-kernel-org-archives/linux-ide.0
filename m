From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata: move ata_altstatus() to pio data xfer functions
Date: Tue, 05 Jun 2007 11:50:12 +0800
Message-ID: <4664DD74.1030009@tw.ibm.com>
References: <4664DB99.8010202@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:38923 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757523AbXFEDuP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 23:50:15 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l553oEJl024059
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 23:50:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l553oEn6259192
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:50:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l553oEEu014210
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:50:14 -0600
In-Reply-To: <4664DB99.8010202@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Patch 2/3:
 Move ata_altstatus() out from ata_hsm_move() to the pio data xfer functions
such as ata_pio_sectors() and atapi_pio_bytes() where it makes more sense.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
atapi_send_cdb() already calls ata_altstatus() inside.
This patch makes ata_pio_sectors() and atapi_pio_bytes() do the same for consistency.

diff -Nrup 01_remove_bad_flush/drivers/ata/libata-core.c 02_move_altstatus/drivers/ata/libata-core.c
--- 01_remove_bad_flush/drivers/ata/libata-core.c	2007-06-04 18:10:43.000000000 +0800
+++ 02_move_altstatus/drivers/ata/libata-core.c	2007-06-04 18:16:24.000000000 +0800
@@ -4524,6 +4524,8 @@ static void ata_pio_sectors(struct ata_q
 			ata_pio_sector(qc);
 	} else
 		ata_pio_sector(qc);
+
+	ata_altstatus(ap); /* flush */
 }
 
 /**
@@ -4698,6 +4700,7 @@ static void atapi_pio_bytes(struct ata_q
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
 	__atapi_pio_bytes(qc, bytes);
+	ata_altstatus(ap); /* flush */
 
 	return;
 
@@ -4869,7 +4872,6 @@ fsm_start:
 			 */
 			ap->hsm_task_state = HSM_ST;
 			ata_pio_sectors(qc);
-			ata_altstatus(ap); /* flush */
 		} else
 			/* send CDB */
 			atapi_send_cdb(ap, qc);
@@ -4950,7 +4952,6 @@ fsm_start:
 
 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
 					ata_pio_sectors(qc);
-					ata_altstatus(ap);
 					status = ata_wait_idle(ap);
 				}
 
@@ -4970,13 +4971,11 @@ fsm_start:
 			if (ap->hsm_task_state == HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 				/* all data read */
-				ata_altstatus(ap);
 				status = ata_wait_idle(ap);
 				goto fsm_start;
 			}
 		}
 
-		ata_altstatus(ap); /* flush */
 		poll_next = 1;
 		break;
 


