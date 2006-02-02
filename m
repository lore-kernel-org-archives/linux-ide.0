From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/11] libata: separate out sata_phy_resume() from sata_std_hardreset()
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720002502-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.200]:8438 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423402AbWBBJUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:05 -0500
Received: by xproxy.gmail.com with SMTP id i30so251266wxd
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:04 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch separates out sata_phy_resume() from sata_std_hardreset().
The function will later be used by probeinit callback.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

11494a4da9ba499fd04996d85322ddc462fe47dc
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1d106b4..e302545 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2277,6 +2277,24 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
+static int sata_phy_resume(struct ata_port *ap)
+{
+	unsigned long timeout = jiffies + (HZ * 5);
+	u32 sstatus;
+
+	scr_write_flush(ap, SCR_CONTROL, 0x300);
+
+	/* Wait for phy to become ready, if necessary. */
+	do {
+		msleep(200);
+		sstatus = scr_read(ap, SCR_STATUS);
+		if ((sstatus & 0xf) != 1)
+			return 0;
+	} while (time_before(jiffies, timeout));
+
+	return -1;
+}
+
 /**
  *	ata_std_softreset - reset host port via ATA SRST
  *	@ap: port to reset
@@ -2357,8 +2375,7 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
 {
-	u32 sstatus, serror;
-	unsigned long timeout = jiffies + (HZ * 5);
+	u32 serror;
 
 	DPRINTK("ENTER\n");
 
@@ -2371,15 +2388,8 @@ int sata_std_hardreset(struct ata_port *
 	 */
 	msleep(1);
 
-	scr_write_flush(ap, SCR_CONTROL, 0x300);
-
-	/* Wait for phy to become ready, if necessary. */
-	do {
-		msleep(200);
-		sstatus = scr_read(ap, SCR_STATUS);
-		if ((sstatus & 0xf) != 1)
-			break;
-	} while (time_before(jiffies, timeout));
+	/* Bring phy back */
+	sata_phy_resume(ap);
 
 	/* Clear SError */
 	serror = scr_read(ap, SCR_ERROR);
-- 
1.1.3


