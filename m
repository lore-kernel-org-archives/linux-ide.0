From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] libata: use xfer_mask helpers in ata_dev_set_mode()
Date: Mon, 6 Mar 2006 04:31:57 +0900
Message-ID: <11415871172650-git-send-email-htejun@gmail.com>
References: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:11875 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751743AbWCETcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:01 -0500
Received: by pproxy.gmail.com with SMTP id i75so637256pye
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:00 -0800 (PST)
In-Reply-To: <11415871161709-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Rewrite hardcoded xfer_mode string determination in ata_dev_set_mode()
using xfer_mask helpers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

6c1926e74a4b5266dbcbb4156dee075a05bcc36f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 84a8550..8849512 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1752,9 +1752,6 @@ static u8 base_from_shift(unsigned int s
 
 static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
 {
-	int ofs, idx;
-	u8 base;
-
 	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
 		return;
 
@@ -1763,22 +1760,18 @@ static void ata_dev_set_mode(struct ata_
 
 	ata_dev_set_xfermode(ap, dev);
 
-	base = base_from_shift(dev->xfer_shift);
-	ofs = dev->xfer_mode - base;
-	idx = ofs + dev->xfer_shift;
-	WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
-
 	if (ata_dev_revalidate(ap, dev, 0)) {
 		printk(KERN_ERR "ata%u: failed to revalidate after set "
 		       "xfermode, disabled\n", ap->id);
 		ata_port_disable(ap);
 	}
 
-	DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
-		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
+	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
+		dev->xfer_shift, (int)dev->xfer_mode);
 
 	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
-		ap->id, dev->devno, xfer_mode_str[idx]);
+	       ap->id, dev->devno,
+	       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
 }
 
 static int ata_host_set_pio(struct ata_port *ap)
-- 
1.2.4


