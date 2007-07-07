From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/7] libata: remove irq_on from ata_bus_reset() and ata_std_postreset()
Date: Sat, 07 Jul 2007 15:00:37 +0800
Message-ID: <468F3A15.5060404@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:51788 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbXGGHAz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 03:00:55 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l676tYc9026660
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 02:55:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l6770sJb216432
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:00:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6770rEk030496
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:00:54 -0600
In-Reply-To: <468F3949.5050800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

  It seems irq_on() in ata_bus_reset() and ata_std_postreset()
are leftover of the EDD reset. Remove them.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 01_remove_leftover_irqon/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-07-07 09:58:55.000000000 +0800
+++ 01_remove_leftover_irqon/drivers/ata/libata-core.c	2007-07-07 10:38:55.000000000 +0800
@@ -3194,9 +3194,6 @@ void ata_bus_reset(struct ata_port *ap)
 	if ((slave_possible) && (err != 0x81))
 		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
-	/* re-enable interrupts */
-	ap->ops->irq_on(ap);
-
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
 		ap->ops->dev_select(ap, 1);
@@ -3581,10 +3578,6 @@ void ata_std_postreset(struct ata_port *
 	if (sata_scr_read(ap, SCR_ERROR, &serror) == 0)
 		sata_scr_write(ap, SCR_ERROR, serror);
 
-	/* re-enable interrupts */
-	if (!ap->ops->error_handler)
-		ap->ops->irq_on(ap);
-
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
 		ap->ops->dev_select(ap, 1);
diff -Nrup 00_libata-dev/drivers/ata/pata_scc.c 01_remove_leftover_irqon/drivers/ata/pata_scc.c
--- 00_libata-dev/drivers/ata/pata_scc.c	2007-07-07 09:58:55.000000000 +0800
+++ 01_remove_leftover_irqon/drivers/ata/pata_scc.c	2007-07-07 10:38:55.000000000 +0800
@@ -892,10 +892,6 @@ static void scc_std_postreset (struct at
 {
 	DPRINTK("ENTER\n");
 
-	/* re-enable interrupts */
-	if (!ap->ops->error_handler)
-		ap->ops->irq_on(ap);
-
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
 		ap->ops->dev_select(ap, 1);


