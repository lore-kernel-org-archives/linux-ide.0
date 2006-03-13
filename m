From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement ata_dev_disable()
Date: Mon, 13 Mar 2006 17:12:33 +0900
Message-ID: <11422375532417-git-send-email-htejun@gmail.com>
References: <11422373402858-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:10514 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932127AbWCMIRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:17:39 -0500
Received: by wproxy.gmail.com with SMTP id 69so1342663wri
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:17:38 -0800 (PST)
In-Reply-To: <11422373402858-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch implements ata_dev_disable() which prints a warning message
and takes @dev offline.  Currently, this is done by explicitly
incrementing dev->class with case-by-case warning messages.  Giving
user clear indication when libata gives up will be more important as
libata will be doing more retries.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

b0e8e3c30b12f3adf35a7047031c9a6e8258e289
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7b1150d..92c7c53 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -394,6 +394,15 @@ static const char *ata_mode_string(unsig
 	return "<n/a>";
 }
 
+static void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
+{
+	if (ata_dev_present(dev)) {
+		printk(KERN_WARNING "ata%u: dev %u disabled\n",
+		       ap->id, dev->devno);
+		dev->class++;
+	}
+}
+
 /**
  *	ata_pio_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
-- 
1.2.4


