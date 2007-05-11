From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/7] libata: set the state after "PIO data-in" to HSM_ST_IDLE
 instead of HSM_ST_LAST
Date: Fri, 11 May 2007 15:24:48 +0800
Message-ID: <46441A40.4020403@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:47656 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbXEKHY4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:24:56 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4B7OtAH002229
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:24:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7OtwI167556
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:24:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7OsND024658
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:24:55 -0600
In-Reply-To: <4644192A.8090809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

patch 1/7:
  Set the state after "PIO data-in" to HSM_ST_IDLE instead of HSM_ST_LAST.
To prevent the irq handler from thinking "HSM is waiting for the last irq".
Needed later when part of the irq driven pio pushed out to workqueue.

---

diff -Nrup 00_linux-2.6.21.1/drivers/ata/libata-core.c 01_last_idle/drivers/ata/libata-core.c
--- 00_linux-2.6.21.1/drivers/ata/libata-core.c	2007-05-04 11:22:23.000000000 +0800
+++ 01_last_idle/drivers/ata/libata-core.c	2007-05-11 10:24:16.000000000 +0800
@@ -4041,7 +4041,7 @@ static void ata_pio_sector(struct ata_qu
 	unsigned char *buf;
 
 	if (qc->curbytes == qc->nbytes - ATA_SECT_SIZE)
-		ap->hsm_task_state = HSM_ST_LAST;
+		ap->hsm_task_state = do_write ? HSM_ST_LAST : HSM_ST_IDLE;
 
 	page = sg[qc->cursg].page;
 	offset = sg[qc->cursg].offset + qc->cursg_ofs;
@@ -4389,6 +4389,8 @@ int ata_hsm_move(struct ata_port *ap, st
 	 */
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
+
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
@@ -4548,8 +4550,7 @@ fsm_start:
 
 			ata_pio_sectors(qc);
 
-			if (ap->hsm_task_state == HSM_ST_LAST &&
-			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
 				ata_altstatus(ap);
 				status = ata_wait_idle(ap);
@@ -4562,6 +4563,7 @@ fsm_start:
 		break;
 
 	case HSM_ST_LAST:
+	case HSM_ST_IDLE:
 		if (unlikely(!ata_ok(status))) {
 			qc->err_mask |= __ac_err_mask(status);
 			ap->hsm_task_state = HSM_ST_ERR;


