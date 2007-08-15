From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: fix n_sectors failure handling during revalidation
Date: Thu, 16 Aug 2007 03:02:22 +0900
Message-ID: <20070815180222.GC21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:21738 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbXHOSCe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:02:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so3068rvb
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 11:02:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

If revalidation fails because device has different n_sectors after
configuration the original n_sectors should be restored before failing
revalidation.  Without this fix, n_sectors difference will incorrectly
and silently pass revalidation when revalidation is retried.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3705,6 +3705,10 @@ int ata_dev_revalidate(struct ata_device
 			       "%llu != %llu\n",
 			       (unsigned long long)n_sectors,
 			       (unsigned long long)dev->n_sectors);
+
+		/* restore original n_sectors */
+		dev->n_sectors = n_sectors;
+
 		rc = -ENODEV;
 		goto fail;
 	}
