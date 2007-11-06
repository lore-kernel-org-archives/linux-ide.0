From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] libata: add ATA_CBL_PATA_IGN
Date: Tue,  6 Nov 2007 14:39:09 +0900
Message-ID: <11943275512264-git-send-email-htejun@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:7443 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbXKFFjQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 00:39:16 -0500
In-Reply-To: <1194327550227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

ATA_CBL_PATA_UNK indicates that the cable type can't be determined
from the host side and might be either 80c or 40c.  libata applies
drive or other generic limit in this case.  However, there are
controllers where both host and drive side detections are
misimplemented and the driver has to rely solely on private method -
peeking BIOS or ACPI configuration or using some other private
mechanism.

This patch adds ATA_CBL_PATA_IGN which tells libata to ignore the
cable type completely and just let the LLD determine the transfer mode
via host transfer mode masks and ->mode_filter().

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-core.c |   13 +++++++++++++
 include/linux/ata.h       |    7 ++++---
 include/linux/libata.h    |    1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4372099..f75a26c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2331,6 +2331,18 @@ int ata_cable_unknown(struct ata_port *ap)
 }
 
 /**
+ *	ata_cable_ignore	-	return ignored PATA cable.
+ *	@ap: port
+ *
+ *	Helper method for drivers which don't use cable type to limit
+ *	transfer mode.
+ */
+int ata_cable_ignore(struct ata_port *ap)
+{
+	return ATA_CBL_PATA_IGN;
+}
+
+/**
  *	ata_cable_sata	-	return SATA cable type
  *	@ap: port
  *
@@ -7707,4 +7719,5 @@ EXPORT_SYMBOL_GPL(ata_dev_try_classify);
 EXPORT_SYMBOL_GPL(ata_cable_40wire);
 EXPORT_SYMBOL_GPL(ata_cable_80wire);
 EXPORT_SYMBOL_GPL(ata_cable_unknown);
+EXPORT_SYMBOL_GPL(ata_cable_ignore);
 EXPORT_SYMBOL_GPL(ata_cable_sata);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index e1323e2..d942dba 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -271,9 +271,10 @@ enum {
 	ATA_CBL_NONE		= 0,
 	ATA_CBL_PATA40		= 1,
 	ATA_CBL_PATA80		= 2,
-	ATA_CBL_PATA40_SHORT	= 3,		/* 40 wire cable to high UDMA spec */
-	ATA_CBL_PATA_UNK	= 4,
-	ATA_CBL_SATA		= 5,
+	ATA_CBL_PATA40_SHORT	= 3,	/* 40 wire cable to high UDMA spec */
+	ATA_CBL_PATA_UNK	= 4,	/* don't know, maybe 80c? */
+	ATA_CBL_PATA_IGN	= 5,	/* don't know, ignore cable handling */
+	ATA_CBL_SATA		= 6,
 
 	/* SATA Status and Control Registers */
 	SCR_STATUS		= 0,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5ad2186..5145a5c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -924,6 +924,7 @@ extern u8 ata_irq_on(struct ata_port *ap);
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
 extern int ata_cable_sata(struct ata_port *ap);
+extern int ata_cable_ignore(struct ata_port *ap);
 extern int ata_cable_unknown(struct ata_port *ap);
 
 /*
-- 
1.5.2.4

