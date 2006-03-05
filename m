From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: revalidate after transfer mode configuration
Date: Sun, 5 Mar 2006 17:55:58 +0900
Message-ID: <11415489581651-git-send-email-htejun@gmail.com>
References: <11415489584127-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:42333 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752151AbWCEI4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 03:56:04 -0500
Received: by zproxy.gmail.com with SMTP id 13so1017524nzn
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 00:56:03 -0800 (PST)
In-Reply-To: <11415489584127-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Revalidate device after transfer mode configuration.  This also makes
dev->id up-to-date.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

09956f0e1eb537c8324f402dc1588c3405c10b42
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5d0adfa..5dbcf0c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1625,6 +1625,12 @@ static void ata_dev_set_mode(struct ata_
 	idx = ofs + dev->xfer_shift;
 	WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
 
+	if (ata_dev_revalidate(ap, dev, 0)) {
+		printk(KERN_ERR "ata%u: failed to revalidate after set "
+		       "xfermode, disabled\n", ap->id);
+		ata_port_disable(ap);
+	}
+
 	DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
 		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
 
-- 
1.2.1


