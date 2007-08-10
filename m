From: akpm@linux-foundation.org
Subject: [patch 23/25] ST340823A, HPA and libata
Date: Fri, 10 Aug 2007 13:59:48 -0700
Message-ID: <200708102059.l7AKxnaT008636@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37051 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028AbXHJVQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Ok this is a different approach to handling it - knowing it is an off by one
so we can handle the drive if clipped

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    7 +++++++
 include/linux/libata.h    |    1 +
 2 files changed, 8 insertions(+)

diff -puN drivers/ata/libata-core.c~st340823a-hpa-and-libata drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~st340823a-hpa-and-libata
+++ a/drivers/ata/libata-core.c
@@ -988,6 +988,10 @@ static u64 ata_hpa_resize(struct ata_dev
 	else
 		hpa_sectors = ata_read_native_max_address(dev);
 
+	/* Reports one sector too many */
+	if (hpa_sectors && (dev->horkage & ATA_HORKAGE_HPA_SIZE))
+		hpa_sectors--;
+
 	if (hpa_sectors > sectors) {
 		ata_dev_printk(dev, KERN_INFO,
 			"Host Protected Area detected:\n"
@@ -3863,6 +3867,9 @@ static const struct ata_blacklist_entry 
 
 	/* Devices with NCQ limits */
 
+	/* Devices which report 1 sector over size HPA */
+	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
+
 	/* End Marker */
 	{ }
 };
diff -puN include/linux/libata.h~st340823a-hpa-and-libata include/linux/libata.h
--- a/include/linux/libata.h~st340823a-hpa-and-libata
+++ a/include/linux/libata.h
@@ -315,6 +315,7 @@ enum {
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
 	ATA_HORKAGE_IPM		= (1 << 4), 	/* LPM problems */
+	ATA_HORKAGE_HPA_SIZE	= (1 << 6), 	/* Reports native size off by one */
 };
 
 enum hsm_task_states {
_
