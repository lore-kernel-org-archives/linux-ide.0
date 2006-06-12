From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/10] libata: implement new EH action ATA_EH_SPINUP
Date: Tue, 13 Jun 2006 00:50:29 +0900
Message-ID: <11501274283970-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:36172 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752083AbWFLPuk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:40 -0400
Received: by py-out-1112.google.com with SMTP id x31so1732388pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:40 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement new EH action ATA_EH_SPINUP.  This will be used by new PM
implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/libata.h   |    1 +
 2 files changed, 37 insertions(+), 0 deletions(-)

c0a5ccaf24b0acc3e03c4b265ef6495db36623ae
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 531a4e1..8711e83 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1585,6 +1585,37 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
 }
 
+static int ata_eh_spinup(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_device *dev;
+	unsigned int err_mask = 0;
+	int i;
+
+	if (!(ehc->i.action & ATA_EH_SPINUP))
+		return 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (dev->class != ATA_DEV_ATA)
+			continue;
+
+		ata_eh_about_to_do(ap, ATA_EH_SPINUP);
+		err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+		if (err_mask)
+			break;
+	}
+
+	if (err_mask == 0) {
+		ehc->i.action &= ~ATA_EH_SPINUP;
+		return 0;
+	} else {
+		*r_failed_dev = dev;
+		return -EIO;
+	}
+}
+
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
 	int i, cnt = 0;
@@ -1711,6 +1742,11 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
+	/* spin up if requested */
+	rc = ata_eh_spinup(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	/* configure transfer mode if the port has been reset */
 	if (ehc->i.flags & ATA_EHI_DID_RESET) {
 		rc = ata_set_mode(ap, &dev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 17c8ced..e5ff148 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -246,6 +246,7 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_SPINUP		= (1 << 3),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 
-- 
1.3.2


