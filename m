From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: do not fail softreset if PHY reports no device
Date: Mon, 3 Apr 2006 01:58:06 +0900
Message-ID: <20060402165806.GO13172@htj.dyndns.org>
References: <442FF8C2.40201@garzik.org> <20060402164936.GA20570@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.237]:31612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932344AbWDBQ6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 12:58:11 -0400
Received: by wproxy.gmail.com with SMTP id i22so1168360wra
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 09:58:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060402164936.GA20570@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

All softreset methods are responsible for detecting device presence
and succeed softreset in such cases.  AHCI didn't use to check for
device presence before proceeding with softreset and this caused
unnecessary reset retrials during probing.  This patch adds presence
detection to AHCI softreset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This makes AHCI act like all other softresets and new EH already
handles false successes properly.  So, I think this should do the
trick.

 ahci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1bd82c4..8403cf3 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -549,6 +549,12 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
+	if (!sata_dev_present(ap)) {
+		DPRINTK("PHY reports no device\n");
+		*class = ATA_DEV_NONE;
+		return 0;
+	}
+
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_stop_engine(ap);
 	if (rc) {
