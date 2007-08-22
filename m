From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Spot bridge chips
Date: Wed, 22 Aug 2007 23:22:45 +0100
Message-ID: <20070822232245.043267d3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43960 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933379AbXHVWOl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 18:14:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

If we have a PATA cable with a SATA drive on it then we've found a
bridge and we can flip the cable type. This fixes some cable detect
problems with SATA bridges on chipsets and misdetected cable types.

In theory cable detection and mode limiting is needed if you put a
SATA/PATA bridge on a 40 wire cable, but I see no way to deal with
that other than to point out its not a good idea anyway.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/libata-core.c linux-2.6.23rc3-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/libata-core.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/libata-core.c	2007-08-22 18:17:31.321738376 +0100
@@ -2186,6 +2190,17 @@
 	if (ap->ops->cable_detect)
 		ap->cbl = ap->ops->cable_detect(ap);
 
+	/* We may have SATA bridge glue hiding here irrespective of the
+	   reported cable types and sensed types */
+	ata_link_for_each_dev(dev, &ap->link) {
+		if (!ata_dev_enabled(dev))
+			continue;
+		/* SATA drives indicate we have a bridge. We don't know which
+		   end of the link the bridge is which is a problem */
+		if (ata_id_is_sata(dev->id))
+			ap->cbl = ATA_CBL_SATA;
+	}
+
 	/* After the identify sequence we can now set up the devices. We do
 	   this in the normal order so that the user doesn't get confused */
 
