From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/16] libata: revalidate after transfer mode configuration
Date: Fri, 27 Jan 2006 00:39:12 +0900
Message-ID: <11382899521109-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:21074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964781AbWAZPjb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:31 -0500
Received: by zproxy.gmail.com with SMTP id 34so372383nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:31 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Revalidate device after transfer mode configuration.  This also makes
dev->id up-to-date.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

35fcb729b1ff75eff6bd088b0ac1444255238e9e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 68ee230..613c317 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1996,6 +1996,12 @@ static void ata_dev_set_mode(struct ata_
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
1.1.3


