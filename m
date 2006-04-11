From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/15] libata-ncq: implement command exclusion
Date: Tue, 11 Apr 2006 22:53:36 +0900
Message-ID: <1144763616442-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:55716 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750985AbWDKNxo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:44 -0400
Received: by zproxy.gmail.com with SMTP id o37so1097574nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:44 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

NCQ enabled device will have queue depth larger than one but no two
non-NCQ commands can be issued simultaneously, neither can a non-NCQ
command and NCQ commands.  This patch makes ata_scsi_translate()
return SCSI_MLQUEUE_DEVICE_BUSY if such exclusion is necessary.  SCSI
midlayer will retry the command later.

As SCSI midlayer always retries once a command completes, this doesn't
incur unnecessary delays and as most commands will be NCQ ones for NCQ
device, so the overhead should be negligible.

Initial implementation is from Jens Axboe and using
SCSI_MLQUEUE_DEVICE_BUSY for exclusion is suggested by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

7f78182953826cfcd2c9b0a7d897e01f6724cb6b
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index c978a5d..00cb9ca 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1229,6 +1229,39 @@ static void ata_scsi_qc_complete(struct 
 }
 
 /**
+ *	ata_scmd_need_defer - Check whether we need to defer scmd
+ *	@ap: ATA port to which the command is addressed
+ *	@dev: ATA device to which the command is addressed
+ *	@is_io: Is the command IO (and thus possibly NCQ)?
+ *
+ *	NCQ and non-NCQ commands cannot run together.  As upper layer
+ *	only knows the queue depth, we are responsible for maintaining
+ *	exclusion.  This function checks whether a new command can be
+ *	issued to @dev.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	1 if deferring is needed, 0 otherwise.
+ */
+static int ata_scmd_need_defer(struct ata_port *ap, struct ata_device *dev,
+			       int is_io)
+{
+	if (!(dev->flags & ATA_DFLAG_NCQ))
+		return 0;
+
+	if (is_io) {
+		if (!ata_tag_valid(ap->active_tag))
+			return 0;
+	} else {
+		if (!ata_tag_valid(ap->active_tag) && !ap->sactive)
+			return 0;
+	}
+	return 1;
+}
+
+/**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@ap: ATA port to which the command is addressed
  *	@dev: ATA device to which the command is addressed
@@ -1263,9 +1296,13 @@ static int ata_scsi_translate(struct ata
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
+	int is_io = xlat_func == ata_scsi_rw_xlat;
 
 	VPRINTK("ENTER\n");
 
+	if (unlikely(ata_scmd_need_defer(ap, dev, is_io)))
+		goto defer;
+
 	qc = ata_scsi_qc_new(ap, dev, cmd, done);
 	if (!qc)
 		goto err_mem;
@@ -1312,6 +1349,10 @@ err_mem:
 	done(cmd);
 	DPRINTK("EXIT - internal\n");
 	return 0;
+
+defer:
+	DPRINTK("EXIT - defer\n");
+	return SCSI_MLQUEUE_DEVICE_BUSY;
 }
 
 /**
-- 
1.2.4


