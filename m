From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: use polling pio for identify device
Date: Mon, 22 May 2006 11:51:40 +0800
Message-ID: <4471354C.5090201@tw.ibm.com>
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <446C5957.9040404@tw.ibm.com> <446C5B83.9000305@gmail.com> <446D9FCD.5050907@tw.ibm.com> <446DA604.8040207@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:9703 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751181AbWEVDvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 May 2006 23:51:39 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4M3pb0i024059
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 23:51:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4M3pbqE272828
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 21:51:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4M3pa78010030
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 21:51:36 -0600
In-Reply-To: <446DA604.8040207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Use polling pio for identify device.
This can save some time to detect the phantom device 1 during boot.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
For the phantom slave device (found with some IBM DVD-RAM drive and
Intel ICHx chip), irq-pio has to wait 30 seconds timeout to detect them.

Use polling pio can detect the phantom slave quicker. (Verified ok by Tejun.)

Patch again the current upstream branch (b74ba22f030eb7ab88f7d8954ad18ecc0ac5ce3c).
For your review, thanks.

--- upstream/drivers/scsi/libata-core.c	2006-05-22 10:04:12.000000000 +0800
+++ polling_identify/drivers/scsi/libata-core.c	2006-05-22 11:07:02.000000000 +0800
@@ -1196,6 +1196,8 @@ static int ata_dev_read_id(struct ata_de
 	}
 
 	tf.protocol = ATA_PROT_PIO;
+	/* Use polling for early detection of phantom dev 1 */
+	tf.flags |= ATA_TFLAG_POLLING;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);


