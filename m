From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: revalidate after transfer mode configuration
Date: Wed, 15 Feb 2006 19:02:45 +0900
Message-ID: <11399977652003-git-send-email-htejun@gmail.com>
References: <11399977652752-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:2059 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbWBOKCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 05:02:50 -0500
Received: by pproxy.gmail.com with SMTP id f25so1437083pyf
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 02:02:50 -0800 (PST)
In-Reply-To: <11399977652752-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Revalidate device after transfer mode configuration.  This also makes
dev->id up-to-date.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

4580280ce48d62d2d801cd427e6194f9ab56e84b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 54ed8fd..c971c15 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1620,6 +1620,12 @@ static void ata_dev_set_mode(struct ata_
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
1.1.5


