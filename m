From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: share PIO limits among devices sharing a channel
Date: Thu, 25 Jan 2007 20:29:47 +0900
Message-ID: <20070125112947.GC8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:27622 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbXAYL3z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 06:29:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so428060uga
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 03:29:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

PIO xfermask limits should be shared by all devices on the same
channel to avoid violating device selection timing.  libata used to
guarantee this at core level but I mistakenly dropped the code during
conversion to new EH.  This patch revives that guarantee.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, IMHO, this is a regression and should go into #upstream-fixes.
Thanks.

 drivers/ata/libata-core.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3390,6 +3390,7 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_port *ap = dev->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3412,6 +3413,22 @@ static void ata_dev_xfermask(struct ata_
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	/* PIO xfermask limits are shared by all devices on the same
+	 * channel to avoid violating device selection timing.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		unsigned int pio_mask;
+
+		if (ata_dev_absent(d))
+			continue;
+
+		ata_unpack_xfermask(ata_id_xfermask(d->id),
+				    &pio_mask, NULL, NULL);
+		pio_mask &= d->pio_mask;
+		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
+	}
+
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable
