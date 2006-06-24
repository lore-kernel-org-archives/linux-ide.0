From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/15] libata: implement and use ata_deh_dev_action()
Date: Sat, 24 Jun 2006 20:30:18 +0900
Message-ID: <11511486183049-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:48166 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752223AbWFXLaJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:09 -0400
Received: by py-out-1112.google.com with SMTP id t32so931812pyc
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:08 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement and use ata_eh_dev_action() which returns EH action mask for
a device.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

0b207dfe1d875f76363c79dbd0b4111f2cbd53f8
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 126be36..c7e6298 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -93,6 +93,13 @@ static int ata_ering_map(struct ata_erin
 	return rc;
 }
 
+static unsigned int ata_eh_dev_action(struct ata_device *dev)
+{
+	struct ata_eh_context *ehc = &dev->ap->eh_context;
+
+	return ehc->i.action | ehc->i.dev_action[dev->devno];
+}
+
 static void ata_eh_clear_action(struct ata_device *dev,
 				struct ata_eh_info *ehi, unsigned int action)
 {
@@ -1592,7 +1599,7 @@ static int ata_eh_revalidate_and_attach(
 		unsigned int action;
 
 		dev = &ap->device[i];
-		action = ehc->i.action | ehc->i.dev_action[dev->devno];
+		action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_enabled(dev)) {
 			if (ata_port_offline(ap)) {
-- 
1.3.2


