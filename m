From: Tejun Heo <htejun@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Thu, 07 Dec 2006 13:28:02 +0900
Message-ID: <45779852.1030909@gmail.com>
References: <20060924221020.GB2080@artsapartment.org> <4562C65C.2010802@gmail.com> <20061206181652.GA3107@artsapartment.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050404000709000702030808"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:1550 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968738AbWLGE2J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 23:28:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so766694nfa
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2006 20:28:08 -0800 (PST)
In-Reply-To: <20061206181652.GA3107@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050404000709000702030808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Please test the attached patch.

Thanks.

-- 
tejun

--------------050404000709000702030808
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f8ec389..6d0f0ee 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3396,6 +3396,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
 	struct ata_port *ap = dev->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3413,11 +3414,27 @@ static void ata_dev_xfermask(struct ata_device *dev)
         if (ata_drive_40wire(dev->id) && (ap->cbl == ATA_CBL_PATA_UNK || ap->cbl == ATA_CBL_PATA80))
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
-
+	/* apply xfermask limits of this device */
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
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

--------------050404000709000702030808--
