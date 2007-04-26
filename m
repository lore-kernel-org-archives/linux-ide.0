From: akpm@linux-foundation.org
Subject: [patch 01/10] ata: printk warning fixes
Date: Thu, 26 Apr 2007 00:19:21 -0700
Message-ID: <200704260719.l3Q7JLr7023679@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933247AbXDZHTd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2007 03:19:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, htejun@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

drivers/ata/libata-core.c: In function 'ata_hpa_resize':
drivers/ata/libata-core.c:986: warning: format '%lld' expects type 'long long int', but argument 5 has type 'u64'
drivers/ata/libata-core.c:986: warning: format '%lld' expects type 'long long int', but argument 6 has type 'u64'
drivers/ata/libata-core.c:990: warning: format '%lld' expects type 'long long int', but argument 4 has type 'u64'
drivers/ata/libata-core.c:990: warning: format '%lld' expects type 'long long int', but argument 5 has type 'u64'
drivers/ata/libata-core.c:1003: warning: format '%lld' expects type 'long long int', but argument 4 has type 'u64'

Also fix various 80-col bustage.

Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff -puN drivers/ata/libata-core.c~ata-printk-warning-fixes drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~ata-printk-warning-fixes
+++ a/drivers/ata/libata-core.c
@@ -982,25 +982,28 @@ static u64 ata_hpa_resize(struct ata_dev
 		hpa_sectors = ata_read_native_max_address(dev);
 
 	/* if no hpa, both should be equal */
-	ata_dev_printk(dev, KERN_INFO, "%s 1: sectors = %lld, hpa_sectors = %lld\n",
-		__FUNCTION__, sectors, hpa_sectors);
+	ata_dev_printk(dev, KERN_INFO, "%s 1: sectors = %lld, "
+				"hpa_sectors = %lld\n",
+		__FUNCTION__, (long long)sectors, (long long)hpa_sectors);
 
 	if (hpa_sectors > sectors) {
 		ata_dev_printk(dev, KERN_INFO,
 			"Host Protected Area detected:\n"
 			"\tcurrent size: %lld sectors\n"
 			"\tnative size: %lld sectors\n",
-			sectors, hpa_sectors);
+			(long long)sectors, (long long)hpa_sectors);
 
 		if (ata_ignore_hpa) {
 			if (ata_id_has_lba48(dev->id))
 				hpa_sectors = ata_set_native_max_address_ext(dev, hpa_sectors);
 			else
-				hpa_sectors = ata_set_native_max_address(dev, hpa_sectors);
+				hpa_sectors = ata_set_native_max_address(dev,
+								hpa_sectors);
 
 			if (hpa_sectors) {
-				ata_dev_printk(dev, KERN_INFO,
-					"native size increased to %lld sectors\n", hpa_sectors);
+				ata_dev_printk(dev, KERN_INFO, "native size "
+					"increased to %lld sectors\n",
+					(long long)hpa_sectors);
 				return hpa_sectors;
 			}
 		}
_
