From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend SSD
Date: Wed, 4 Nov 2009 20:25:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <200910221144.04471.bzolnier@gmail.com> <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
 <200910231644.29919.bzolnier@gmail.com> <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
 <20091023175157.3a898525@lxorguk.ukuu.org.uk> <4AE1E78A.2090801@ru.mvista.com>
 <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
 <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758417AbZKEBZY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Nov 2009 20:25:24 -0500
In-Reply-To: <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi

Here is another patch for SSD for VIA UDMA33. Alan, please backport it 
into libata.

Mikulas

---

Don't use UDMA on VIA UDMA33 controller with Transcend SSD

The computer locks up if Transcend SSD runs in any of UDMA modes.
It doesn't lockup with different brand SSD, so this is specific to Transcend.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/ide/via82cxxx.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6.31.5-fast/drivers/ide/via82cxxx.c
===================================================================
--- linux-2.6.31.5-fast.orig/drivers/ide/via82cxxx.c	2009-05-29 22:36:58.000000000 +0200
+++ linux-2.6.31.5-fast/drivers/ide/via82cxxx.c	2009-11-04 22:32:55.000000000 +0100
@@ -195,6 +195,21 @@ static void via_set_pio_mode(ide_drive_t
 	via_set_drive(drive, XFER_PIO_0 + pio);
 }
 
+static u8 via_udma_filter(ide_drive_t *drive)
+{
+	char *m = (char *)&drive->id[ATA_ID_PROD];
+
+	/*
+	 * Restrict UDMA for Transcend flash cards.
+	 * On VIA 33, UDMA locks up. On VIA 133, it works. I can't test other
+	 * controllers.
+	 */
+	if (!memcmp(m, "TS", 2) && drive->hwif->ultra_mask == ATA_UDMA2)
+		return 0;
+
+	return drive->hwif->ultra_mask;
+}
+
 static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
 {
 	struct via_isa_bridge *via_config;
@@ -372,6 +387,7 @@ static const struct ide_port_ops via_por
 	.set_pio_mode		= via_set_pio_mode,
 	.set_dma_mode		= via_set_drive,
 	.cable_detect		= via82cxxx_cable_detect,
+	.udma_filter		= via_udma_filter,
 };
 
 static const struct ide_port_info via82cxxx_chipset __devinitdata = {
