From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 2/2] sata_fsl: set the correct queue depth for the host controller
Date: Sun,  6 Jul 2014 14:28:41 +0800
Message-ID: <1404628121-8158-3-git-send-email-haokexin@gmail.com>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34597 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbaGFG3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2014 02:29:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so3781112pab.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2014 23:29:45 -0700 (PDT)
In-Reply-To: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

The fsl sata controller only implement a queue depth of 16. So use
the ata_host_set_queue_depth() to set the correct queue depth for
host controller. Also add a WARN_ON_ONCE() if a tag above 16 is
used.

Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Add a WARN_ON_ONCE().

 drivers/ata/sata_fsl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 07bc7e4dbd04..ae55440af86d 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -402,6 +402,7 @@ static inline unsigned int sata_fsl_tag(unsigned int tag,
 
 	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
 		DPRINTK("tag %d invalid : out of range\n", tag);
+		WARN_ON_ONCE(1);
 		return 0;
 	}
 
@@ -1506,6 +1507,8 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 		goto error_exit_with_cleanup;
 	}
 
+	ata_host_set_queue_depth(host, SATA_FSL_QUEUE_DEPTH);
+
 	/* host->iomap is not used currently */
 	host->private_data = host_priv;
 
-- 
1.9.3

