From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: don't check n_sectors during revalidation if zero
Date: Fri, 17 Aug 2007 18:46:51 +0900
Message-ID: <20070817094651.GJ21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:13178 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764285AbXHQJq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2007 05:46:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so430913rvb
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2007 02:46:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

If the initial configuration fails early, n_sectors is left at zero.
Checking against it during revalidation makes retried configuration
fail due to n_sectors mismatch.  Ignore zero n_sectors during
revalidation.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3700,7 +3700,8 @@ int ata_dev_revalidate(struct ata_device
 		goto fail;
 
 	/* verify n_sectors hasn't changed */
-	if (dev->class == ATA_DEV_ATA && dev->n_sectors != n_sectors) {
+	if (dev->class == ATA_DEV_ATA && n_sectors &&
+	    dev->n_sectors != n_sectors) {
 		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
 			       "%llu != %llu\n",
 			       (unsigned long long)n_sectors,
