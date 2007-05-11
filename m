From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 7/7] libata: ack unexpected INTRQ when polling
Date: Fri, 11 May 2007 15:41:59 +0800
Message-ID: <46441E47.3020809@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:37975 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760307AbXEKHmT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:42:19 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4B7ci8x031857
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:38:44 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7g51Z168980
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:42:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7g4Ym016046
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:42:05 -0600
In-Reply-To: <4644192A.8090809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

patch 7/7:
 ack unexpected INTRQ when polling.
(Some device asserts INTRQ even if polling and nIEN = 1.
http://bugzilla.kernel.org/show_bug.cgi?id=8441)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 06_irq_wq/drivers/ata/libata-core.c 07_ack_random_irq/drivers/ata/libata-core.c
--- 06_irq_wq/drivers/ata/libata-core.c	2007-05-11 11:54:56.000000000 +0800
+++ 07_ack_random_irq/drivers/ata/libata-core.c	2007-05-11 15:40:37.000000000 +0800
@@ -5211,9 +5211,12 @@ inline unsigned int ata_host_intr (struc
 	if (ap->pflags & ATA_PFLAG_HSM_WQ)
 		goto idle_irq;
 
-	/* polling */
-	if (qc->tf.flags & ATA_TFLAG_POLLING)
+	/* polling, while HSM not yet active in wq */
+	if (qc->tf.flags & ATA_TFLAG_POLLING) {
+		/* ack random irq */
+		ata_chk_status(ap);
 		goto idle_irq;
+	}
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {


