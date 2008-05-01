From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: improve post-reset device ready test
Date: Thu, 01 May 2008 23:41:41 +0900
Message-ID: <4819D6A5.2030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:62300 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbYEAOl5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 10:41:57 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1059508waf.23
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 07:41:57 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Some controllers (jmb and inic162x) use 0x77 and 0x7f to indicate that
the device isn't ready yet.  It looks like they use 0xff if device
presence is detected but connection isn't established.  0x77 or 0x7f
after connection is established and use the value from signature FIS
after receiving it.

This patch implements ata_check_ready(), which takes TF status value
and determines whether the port is ready or not considering the above
and other conditions, and use it in @check_ready() functions.  This is
safe as both 0x77 and 0x7f aren't valid ready status value even though
they have BSY bit cleared.

This fixes hot plug detection failures which can be triggered with
certain drives if they aren't already spun up when the data connector
is hot plugged.

Tested on sil, sil24, ahci (jmb/ich), piix and inic162x combined with
eight drives from all major vendors.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c       |    4 +---
 drivers/ata/libata-sff.c |    6 +-----
 include/linux/libata.h   |   15 +++++++++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8cace9a..97f83fb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1267,9 +1267,7 @@ static int ahci_check_ready(struct ata_link *link)
 	void __iomem *port_mmio = ahci_port_base(link->ap);
 	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
 
-	if (!(status & ATA_BUSY))
-		return 1;
-	return 0;
+	return ata_check_ready(status);
 }
 
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2ec65a8..3c2d228 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -314,11 +314,7 @@ static int ata_sff_check_ready(struct ata_link *link)
 {
 	u8 status = link->ap->ops->sff_check_status(link->ap);
 
-	if (!(status & ATA_BUSY))
-		return 1;
-	if (status == 0xff)
-		return -ENODEV;
-	return 0;
+	return ata_check_ready(status);
 }
 
 /**
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 2f8f1df..3ead02f 100644
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d1dfe87..95e6159 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1381,6 +1381,21 @@ static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 	return *(struct ata_port **)&host->hostdata[0];
 }
 
+static inline int ata_check_ready(u8 status)
+{
+	/* Some controllers report 0x77 or 0x7f during intermediate
+	 * not-ready stages.
+	 */
+	if (status == 0x77 || status == 0x7f)
+		return 0;
+
+	/* 0xff indicates either no device or device not ready */
+	if (status == 0xff)
+		return -ENODEV;
+
+	return !(status & ATA_BUSY);
+}
+
 
 /**************************************************************************
  * PMP - drivers/ata/libata-pmp.c
