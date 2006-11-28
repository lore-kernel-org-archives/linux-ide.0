From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 14:52:28 +0800
Message-ID: <456BDCAC.4060609@tw.ibm.com>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:15297 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S935681AbWK1Gwu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 01:52:50 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAS6qnMb002740
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 01:52:49 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAS6qnjX536952
	for <linux-ide@vger.kernel.org>; Mon, 27 Nov 2006 23:52:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAS6qmsQ004545
	for <linux-ide@vger.kernel.org>; Mon, 27 Nov 2006 23:52:49 -0700
In-Reply-To: <455F790C.2030509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Some devices raise irq early before clearing the BSY.
This patch waits up to 10 microseconds to workaround the early irq problem.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
In additional to the pata_via SET FEATURES XFER problem reported by Matthieu,
we also see the early irq problem with ICH4 + AOpen CD-936E on READ under PIO mode 4.

The following is a port of the pata_via_fix to the libata core.
Patch against 2.6.19-rc6. For your review, thanks.


--- linux-2.6.19-rc6/include/linux/libata.h	2006-11-28 11:14:52.000000000 +0800
+++ linux-2.6.19-rc6-early_irq/include/linux/libata.h	2006-11-28 13:31:07.565194648 +0800
@@ -1039,6 +1039,30 @@ static inline void ata_pause(struct ata_
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
--- linux-2.6.19-rc6/drivers/ata/libata-core.c	2006-11-28 11:14:38.000000000 +0800
+++ linux-2.6.19-rc6-early_irq/drivers/ata/libata-core.c	2006-11-28 13:31:31.275590120 +0800
@@ -4828,8 +4828,10 @@ inline unsigned int ata_host_intr (struc
 		goto idle_irq;
 	}
 
-	/* check altstatus */
-	status = ata_altstatus(ap);
+	/* check altstatus.
+	 * Waits up to 10 microseconds for early irq.
+	 */
+	status = ata_busy_wait_alt(ap, ATA_BUSY, 10);
 	if (status & ATA_BUSY)
 		goto idle_irq;
 


