From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: implement ata_dev_disable()
Date: Fri, 24 Mar 2006 15:25:31 +0900
Message-ID: <11431815311864-git-send-email-htejun@gmail.com>
References: <11431815303216-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:7712 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423169AbWCXGZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 01:25:36 -0500
Received: by pproxy.gmail.com with SMTP id w49so645699pyg
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 22:25:35 -0800 (PST)
In-Reply-To: <11431815303216-git-send-email-htejun@gmail.com>
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

e117990623836ac284ecd9f472302b5110e03f82
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9cd9053..d1530b9 100644
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


