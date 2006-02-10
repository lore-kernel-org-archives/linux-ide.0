From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/9] libata: kill SError clearing in sata_std_hardreset().
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <11395835282675-git-send-email-htejun@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.199]:40607 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751274AbWBJO6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:58:53 -0500
Received: by xproxy.gmail.com with SMTP id s18so338575wxc
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:58:53 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Don't clear SError in sata_std_hardreset().  This makes hardreset act
identically to ->phy_reset register-wise.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

24bff807a5f2bed38aadb4b8aa25bc40791bf2aa
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8424bd9..38e72c1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2018,8 +2018,6 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
 {
-	u32 serror;
-
 	DPRINTK("ENTER\n");
 
 	/* Issue phy wake/reset */
@@ -2034,10 +2032,6 @@ int sata_std_hardreset(struct ata_port *
 	/* Bring phy back */
 	sata_phy_resume(ap);
 
-	/* Clear SError */
-	serror = scr_read(ap, SCR_ERROR);
-	scr_write(ap, SCR_ERROR, serror);
-
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (!sata_dev_present(ap)) {
 		*class = ATA_DEV_NONE;
-- 
1.1.5


