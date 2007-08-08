From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ST340823A, HPA and libata
Date: Wed, 8 Aug 2007 14:25:05 +0100
Message-ID: <20070808142505.3213a1a6@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708030034.13193.bzolnier@gmail.com>
	<20070802231100.GA1861@nalle>
	<200708030135.16910.bzolnier@gmail.com>
	<20070805190616.GA1932@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53502 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759332AbXHHNRx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 09:17:53 -0400
In-Reply-To: <20070805190616.GA1932@nalle>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, jeff@garzik.org, akpm@osdl.org

Ok this is a different approach to handling it - knowing it is an off by
one so we can handle the drive if clipped

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c linux-2.6.23rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-26 15:02:57.000000000 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-08-08 13:38:39.257549616 +0100
@@ -988,6 +992,10 @@
 	else
 		hpa_sectors = ata_read_native_max_address(dev);
 
+	/* Reports one sector too many */
+	if (hpa_sectors && (dev->horkage & ATA_HORKAGE_HPA_SIZE))
+		hpa_sectors--;
+
 	if (hpa_sectors > sectors) {
 		ata_dev_printk(dev, KERN_INFO,
 			"Host Protected Area detected:\n"
@@ -3858,6 +3926,9 @@
 
 	/* Devices with NCQ limits */
 
+	/* Devices which report 1 sector over size HPA */
+	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
+
 	/* End Marker */
 	{ }
 };
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/include/linux/libata.h linux-2.6.23rc1-mm1/include/linux/libata.h
--- linux.vanilla-2.6.23rc1-mm1/include/linux/libata.h	2007-07-26 15:02:58.000000000 +0100
+++ linux-2.6.23rc1-mm1/include/linux/libata.h	2007-08-08 13:38:09.000000000 +0100
@@ -314,6 +314,7 @@
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
 	ATA_HORKAGE_ALPM	= (1 << 4), 	/* ALPM problems */
+	ATA_HORKAGE_HPA_SIZE	= (1 << 5), 	/* Reports native size off by one */
 };
 
 enum hsm_task_states {
