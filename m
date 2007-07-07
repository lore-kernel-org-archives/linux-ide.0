From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 7/7] libata: remove ap->last_ctl
Date: Sat, 07 Jul 2007 15:23:55 +0800
Message-ID: <468F3F8B.5010200@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:39640 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbXGGHYG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 03:24:06 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l677O4eH011334
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 03:24:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l677O4j7225312
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:24:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l677O31g017335
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:24:04 -0600
In-Reply-To: <468F3949.5050800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

With the previous changes made to tf_load(), ap->last_ctl is now unused. Remove it.

(The purpose of ap->last_ctl is to cache the last status of nIEN bit
and hopefully avoid writing the Control register unnecessarily.
However, the libata polling code always call irq_on() in ata_hsm_qc_complete()
and such mechanism isn't much utilized.)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 06_tf_load_cleanup/drivers/ata/libata-core.c 07_last_ctl_cleanup/drivers/ata/libata-core.c
--- 06_tf_load_cleanup/drivers/ata/libata-core.c	2007-07-07 10:49:04.000000000 +0800
+++ 07_last_ctl_cleanup/drivers/ata/libata-core.c	2007-07-07 10:50:36.000000000 +0800
@@ -5987,7 +5987,6 @@ struct ata_port *ata_port_alloc(struct a
 
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
-	ap->last_ctl = 0xFF;
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
diff -Nrup 06_tf_load_cleanup/drivers/ata/libata-sff.c 07_last_ctl_cleanup/drivers/ata/libata-sff.c
--- 06_tf_load_cleanup/drivers/ata/libata-sff.c	2007-07-07 10:50:10.000000000 +0800
+++ 07_last_ctl_cleanup/drivers/ata/libata-sff.c	2007-07-07 10:50:36.000000000 +0800
@@ -53,7 +53,6 @@ void ata_irq_on(struct ata_port *ap)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
 
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 	ata_wait_idle(ap);
@@ -76,7 +75,6 @@ void ata_irq_off(struct ata_port *ap)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
 
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
diff -Nrup 06_tf_load_cleanup/drivers/ata/pata_scc.c 07_last_ctl_cleanup/drivers/ata/pata_scc.c
--- 06_tf_load_cleanup/drivers/ata/pata_scc.c	2007-07-07 10:50:10.000000000 +0800
+++ 07_last_ctl_cleanup/drivers/ata/pata_scc.c	2007-07-07 10:50:36.000000000 +0800
@@ -794,7 +794,6 @@ static void scc_irq_on (struct ata_port 
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
 
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 	ata_wait_idle(ap);
@@ -814,7 +813,6 @@ static void scc_irq_off (struct ata_port
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
 
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 
diff -Nrup 06_tf_load_cleanup/include/linux/libata.h 07_last_ctl_cleanup/include/linux/libata.h
--- 06_tf_load_cleanup/include/linux/libata.h	2007-07-07 10:49:04.000000000 +0800
+++ 07_last_ctl_cleanup/include/linux/libata.h	2007-07-07 10:50:36.000000000 +0800
@@ -507,7 +507,6 @@ struct ata_port {
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 
 	u8			ctl;	/* cache of ATA control register */
-	u8			last_ctl;	/* Cache last written value */
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;


