From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Handle SATA bridges better
Date: Mon, 21 May 2007 15:13:32 +0100
Message-ID: <20070521151332.4ec9ea1d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34674 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756065AbXEUOJn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:09:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

In some situations we find that SATA devices are attached via PATA/SATA
bridges. When we find this we need to change a couple of bits of behaviour

-	Error changedown behaviour for SATA is different - no point
dropping to PIO
-	40/80 wire cable detection testing cannot be done.

Thus we need to detect this case and update the cable type accordingly.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:22:53.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:40:23.000000000 +0100
@@ -2186,6 +2186,16 @@
 	if (ap->ops->cable_detect)
 		ap->cbl = ap->ops->cable_detect(ap);
 
+	/* We may have SATA bridge glue hiding here irrespective of the
+	   reported cable types and sensed types */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+		if (!ata_dev_enabled(dev))
+			continue;
+		if (ata_id_is_sata(dev->id))
+			ap->cbl = ATA_CBL_SATA;
+	}
+
 	/* After the identify sequence we can now set up the devices. We do
 	   this in the normal order so that the user doesn't get confused */
 
