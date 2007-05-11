From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/7] libata: move the ata_altstatus() in ata_hsm_qc_complete()
Date: Fri, 11 May 2007 15:28:51 +0800
Message-ID: <46441B33.40508@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:48364 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbXEKH3B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:29:01 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4B7T1vI003854
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:29:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7SvW0169808
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:29:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7SuXx030176
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:28:56 -0600
In-Reply-To: <4644192A.8090809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

patch 2/7:
 Calling ata_altstatus() after the qc completed looks incorrect.
Move it to before the qc is completed.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 01_last_idle/drivers/ata/libata-core.c 02_flush_fix/drivers/ata/libata-core.c
--- 01_last_idle/drivers/ata/libata-core.c	2007-05-11 10:24:16.000000000 +0800
+++ 02_flush_fix/drivers/ata/libata-core.c	2007-05-11 11:14:04.000000000 +0800
@@ -4329,6 +4329,8 @@ static void ata_hsm_qc_complete(struct a
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
 
+	ata_altstatus(ap); /* flush */
+
 	if (ap->ops->error_handler) {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
@@ -4361,8 +4363,6 @@ static void ata_hsm_qc_complete(struct a
 		} else
 			ata_qc_complete(qc);
 	}
-
-	ata_altstatus(ap); /* flush */
 }
 
 /**


