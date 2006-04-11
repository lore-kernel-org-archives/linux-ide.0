From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/15] libata-hp: implement transportt->user_scan
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648474001-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:37545 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102587nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:14 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_scsi_user_scan() which is used for
ata_scsi_transport_template->user_scan.  This function schedules ATA
hotplug probe on user request.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

18519ac3e6800187945e6d81bd1574c091eb0eaf
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 5e68305..b05cd8a 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -55,6 +55,8 @@ typedef unsigned int (*ata_xlat_func_t)(
 
 static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 					      const struct scsi_device *scsidev);
+static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
+			      unsigned int id, unsigned int lun);
 
 #define RW_RECOVERY_MPAGE 0x1
 #define RW_RECOVERY_MPAGE_LEN 12
@@ -101,6 +103,7 @@ static const u8 def_control_mpage[CONTRO
  */
 struct scsi_transport_template ata_scsi_transport_template = {
 	.eh_timed_out		= ata_scsi_timed_out,
+	.user_scan		= ata_scsi_user_scan,
 };
 
 
@@ -2852,3 +2855,37 @@ void ata_scsi_remove_dev(struct ata_port
 
 	scsi_remove_device(sdev);
 }
+
+/**
+ *	ata_scsi_user_scan - indication for user-initiated bus scan
+ *	@shost: SCSI host to scan
+ *	@channel: Channel to scan
+ *	@id: ID to scan
+ *	@lun: LUN to scan
+ *
+ *	This function is called when user explicitly requests bus
+ *	scan.  Set probe pending flag and invoke EH.  libata scans the
+ *	whole bus regardless of channel, id and lun arguments.
+ *
+ *	LOCKING:
+ *	SCSI layer (we don't care)
+ *
+ *	RETURNS:
+ *	Zero.
+ */
+static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
+			      unsigned int id, unsigned int lun)
+{
+	struct ata_port *ap = (struct ata_port *)&shost->hostdata[0];
+	unsigned long flags;
+
+	if (!ap->ops->error_handler)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ata_set_hotplug_flags(ap, ATA_HOTPLUG_PROBE);
+	ata_eh_schedule_port(ap, ATA_EH_FREEZE);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	return 0;
+}
-- 
1.2.4


