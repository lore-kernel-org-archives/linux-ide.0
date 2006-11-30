From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: blacklist for early irq problem
Date: Thu, 30 Nov 2006 17:43:51 +0800
Message-ID: <456EA7D6.2050101@tw.ibm.com>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com> <456C4514.9090107@tw.ibm.com> <456C4ACC.1050806@rtr.ca> <456C8A51.3000605@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:53691 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S933639AbWK3JoM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 04:44:12 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAU9i8q6019787
	for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 04:44:08 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAU9i80r553748
	for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 02:44:08 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAU9i7Sm028277
	for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 02:44:08 -0700
In-Reply-To: <456C8A51.3000605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Some devices raise irq early before clearing the BSY.
This patch adds blacklist and waits up to 10 microseconds to workaround the early irq problem.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Ok, we should not affect the good devices.
Patch revised for your review.
(against the libata-dev tree 6b78c0d20ffbc89acc3c2790f8d7eded05606813).

diff -Nrup 000_libata_dev/drivers/ata/libata-core.c 001_early_irq/drivers/ata/libata-core.c
--- 000_libata_dev/drivers/ata/libata-core.c	2006-11-30 15:53:08.000000000 +0800
+++ 001_early_irq/drivers/ata/libata-core.c	2006-11-30 16:41:23.000000000 +0800
@@ -1610,6 +1610,9 @@ int ata_dev_configure(struct ata_device 
 	if (dev->flags & ATA_DFLAG_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
+	if (ata_device_blacklisted(dev) & ATA_HORKAGE_EARLY_IRQ)
+		dev->horkage |= ATA_HORKAGE_EARLY_IRQ;
+
 	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
 		/* Let the user know. We don't want to disallow opens for
 		   rescue purposes, or in case the vendor is just a blithering
@@ -3184,6 +3187,9 @@ static const struct ata_blacklist_entry 
 
 	/* Devices with NCQ limits */
 
+	/* Devices with early IRQ */
+	{ "CD-ROM 36X/AKW",   NULL,		ATA_HORKAGE_EARLY_IRQ },
+
 	/* End Marker */
 	{ }
 };
@@ -4989,6 +4995,11 @@ inline unsigned int ata_host_intr (struc
 		goto idle_irq;
 	}
 
+	/* some drives raise INTRQ early before clearing BSY */
+	if (unlikely(qc->dev->horkage & ATA_HORKAGE_EARLY_IRQ))
+		/* wait up to 10 microseconds for BSY to clear */
+		ata_busy_wait_alt(ap, ATA_BUSY, ATA_EARLY_IRQ_WAIT);
+
 	/* check altstatus */
 	status = ata_altstatus(ap);
 	if (status & ATA_BUSY)
diff -Nrup 000_libata_dev/include/linux/libata.h 001_early_irq/include/linux/libata.h
--- 000_libata_dev/include/linux/libata.h	2006-11-30 15:53:26.000000000 +0800
+++ 001_early_irq/include/linux/libata.h	2006-11-30 17:04:37.000000000 +0800
@@ -309,6 +309,9 @@ enum {
 	 * most devices.
 	 */
 	ATA_SPINUP_WAIT		= 8000,
+
+	/*  early irq max wait time (for BSY to clear) in usecs */
+	ATA_EARLY_IRQ_WAIT	= 10,
 	
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependant */
@@ -316,6 +319,7 @@ enum {
 	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
+	ATA_HORKAGE_EARLY_IRQ	= (1 << 3),	/* Early IRQ */
 };
 
 enum hsm_task_states {
@@ -1056,6 +1060,30 @@ static inline void ata_pause(struct ata_
 	ndelay(400);
 }
 
+/**
+ *	ata_busy_wait_alt - Wait for a port alt status register
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to max microseconds for the selected bits in the port's
+ *	alt status register to be cleared.
+ *	Returns final value of alt status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static inline u8 ata_busy_wait_alt(struct ata_port *ap, unsigned int bits,
+				   unsigned int max)
+{
+	u8 status = ata_altstatus(ap);
+
+	while ((status & bits) && (max > 0)) {
+		udelay(1);
+		status = ata_altstatus(ap);
+		max--;
+	};
+
+	return status;
+}
 
 /**
  *	ata_busy_wait - Wait for a port status register

