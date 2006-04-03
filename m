From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata-dev: irq-pio minor fix
Date: Mon, 03 Apr 2006 17:43:24 +0800
Message-ID: <4430EE3C.9050608@tw.ibm.com>
References: <11439680863256-git-send-email-htejun@gmail.com> <442FE142.7030304@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:40090 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751693AbWDCJnh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 05:43:37 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k339hV9Z010398
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 05:43:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k339kfnD174928
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 03:46:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k339hUiw010446
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 03:43:30 -0600
In-Reply-To: <442FE142.7030304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

irq-pio minor fix:
- remove the redundant hsm_task_state = HSM_ST_IDLE
- add devno to printk() as done in upstream 

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

--- irq-pio0/drivers/scsi/libata-eh.c	2006-04-03 13:50:15.000000000 +0800
+++ irq-pio1/drivers/scsi/libata-eh.c	2006-04-03 16:28:52.000000000 +0800
@@ -137,7 +137,6 @@ int ata_scsi_error(struct Scsi_Host *hos
  *	LOCKING:
  *	Inherited from SCSI layer (none, can sleep)
  */
-
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -172,8 +171,6 @@ static void ata_qc_timeout(struct ata_qu
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
-		ap->hsm_task_state = HSM_ST_IDLE;
-
 		/* complete taskfile transaction */
 		qc->err_mask |= AC_ERR_TIMEOUT;
 		break;
--- irq-pio0/drivers/scsi/libata-core.c	2006-04-03 13:50:15.000000000 +0800
+++ irq-pio1/drivers/scsi/libata-core.c	2006-04-03 15:36:10.000000000 +0800
@@ -4043,8 +4043,8 @@ fsm_start:
 		}
 
 		/* no more data to transfer */
-		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
-			ap->id, status);
+		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
+			ap->id, qc->dev->devno, status);
 
 		WARN_ON(qc->err_mask);
 
@@ -4061,8 +4061,8 @@ fsm_start:
 
 	case HSM_ST_ERR:
 		if (qc->tf.command != ATA_CMD_PACKET)
-			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x\n",
-			       ap->id, status);
+			printk(KERN_ERR "ata%u: dev %u command error, drv_stat 0x%x\n",
+			       ap->id, qc->dev->devno, status);
 
 		/* make sure qc->err_mask is available to
 		 * know what's wrong and recover


