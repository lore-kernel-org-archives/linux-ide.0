From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: improve HPA error handling
Date: Sun, 23 Mar 2008 21:05:15 +0900
Message-ID: <47E6477B.1020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:23346 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbYCWMFZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 08:05:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2805957wah.23
        for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 05:05:25 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

There's no point in retrying and eventually failing device detection
when the device rejects READ_NATIVE_MAX[_EXT].  Disable HPA unlocking
if READ_NATIVE_MAX[_EXT] is rejected as done when SET_MAX[_EXT] is
rejected.

This allows some old drives to work even if they aren't blacklisted.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4bbe31f..db1c65c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1416,12 +1416,12 @@ static int ata_hpa_resize(struct ata_device *dev)
 	/* read native max address */
 	rc = ata_read_native_max_address(dev, &native_sectors);
 	if (rc) {
-		/* If HPA isn't going to be unlocked, skip HPA
-		 * resizing from the next try.
+		/* If device aborted the command or HPA isn't going to
+		 * be unlocked, skip HPA resizing.
 		 */
-		if (!ata_ignore_hpa) {
+		if (rc == -EACCES || !ata_ignore_hpa) {
 			ata_dev_printk(dev, KERN_WARNING, "HPA support seems "
-				       "broken, will skip HPA handling\n");
+				       "broken, skipping HPA handling\n");
 			dev->horkage |= ATA_HORKAGE_BROKEN_HPA;
 
 			/* we can continue if device aborted the command */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c

