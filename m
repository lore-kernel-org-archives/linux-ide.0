From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/13] sata_sil24: reimplement hardreset
Date: Fri, 7 Apr 2006 17:16:54 +0900
Message-ID: <11443978142543-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbWDGIRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:04 -0400
Received: by wproxy.gmail.com with SMTP id i11so294609wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:04 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Reimplement hardreset according to the datasheet.  The old hardreset
didn't reset controller status and the controller might not be ready
after reset.  Also, as SStatus is a bit flakey after hardreset,
sata_std_hardrset() didn't use to wait long enough before proceeding.

Note that as we're not depending on SStatus, DET==1 condition cannot
be used to wait for link, so use shorter timeout for no device case.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

241bde5ce7088b4beea4ebf8020a90247a3f4f9f
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 55f51e1..fb260e7 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -522,10 +522,47 @@ static int sil24_softreset(struct ata_po
 
 static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
 {
-	unsigned int dummy_class;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	const char *reason;
+	int tout_msec;
+	u32 tmp;
+
+	/* sil24 does the right thing(tm) without any protection */
+	ata_set_sata_spd(ap);
+
+	tout_msec = 100;
+	if (sata_dev_present(ap))
+		tout_msec = 5000;
+
+	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
+	tmp = ata_wait_register(port + PORT_CTRL_STAT,
+				PORT_CS_DEV_RST, PORT_CS_DEV_RST, 10, tout_msec);
+
+	/* SStatus oscillates between zero and valid status for short
+	 * duration after DEV_RST, give it time to settle.
+	 */
+	msleep(100);
+
+	if (tmp & PORT_CS_DEV_RST) {
+		if (!sata_dev_present(ap))
+			return 0;
+		reason = "link not ready";
+		goto err;
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		reason = "device not ready";
+		goto err;
+	}
+
+	/* sil24 doesn't report device class code after hardreset,
+	 * leave *class alone.
+	 */
+	return 0;
 
-	/* sil24 doesn't report device signature after hard reset */
-	return sata_std_hardreset(ap, &dummy_class);
+ err:
+	printk(KERN_ERR "ata%u: hardreset failed (%s)\n", ap->id, reason);
+	return -EIO;
 }
 
 static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
-- 
1.2.4


