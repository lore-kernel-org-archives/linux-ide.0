From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/11] libata: implement ata_std_probeinit()
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720001073-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:10653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423404AbWBBJUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:05 -0500
Received: by wproxy.gmail.com with SMTP id i30so336637wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:05 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch implements the off-the-shelf probeinit component operation.
Currently, all it does is waking up the PHY if it's a SATA port.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   16 +++++++++++++++-
 include/linux/libata.h     |    1 +
 2 files changed, 16 insertions(+), 1 deletions(-)

9be7440acf08c8100e70ab3406a956c5d8086c0a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8bd197d..fac9677 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2296,6 +2296,19 @@ static int sata_phy_resume(struct ata_po
 }
 
 /**
+ *	ata_std_probeinit - initialize probing
+ *	@ap: port to be probed
+ *
+ *	@ap is about to be probed.  Initialize it.  This function is
+ *	to be used as standard callback for ata_drive_probe_reset().
+ */
+extern void ata_std_probeinit(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
+		sata_phy_resume(ap);
+}
+
+/**
  *	ata_std_softreset - reset host port via ATA SRST
  *	@ap: port to reset
  *	@verbose: fail verbosely
@@ -2485,7 +2498,7 @@ int ata_std_probe_reset(struct ata_port 
 	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
 		hardreset = sata_std_hardreset;
 
-	return ata_drive_probe_reset(ap, NULL,
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
 				     ata_std_softreset, hardreset,
 				     ata_std_postreset, classes);
 }
@@ -5525,6 +5538,7 @@ EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(ata_std_probeinit);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e8f29ce..68b3fe6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -488,6 +488,7 @@ extern int ata_drive_probe_reset(struct 
 			ata_probeinit_fn_t probeinit,
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset, unsigned int *classes);
+extern void ata_std_probeinit(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, int verbose,
 			     unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, int verbose,
-- 
1.1.3


