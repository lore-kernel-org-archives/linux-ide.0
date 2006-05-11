From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] libata-link: separate out link initialization functions
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <11473650232783-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:38964 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751868AbWEKQaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:35 -0400
Received: by nz-out-0102.google.com with SMTP id 13so244957nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:35 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out link initialization into ata_link_init() and
ata_link_init_sata_spd_limit().

---

 drivers/scsi/libata-core.c |   83 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 65 insertions(+), 18 deletions(-)

b1520dbca5c449c69ccb6eb54a6449801d044b87
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index dd40909..de0f56f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,6 +65,7 @@ static unsigned int ata_dev_init_params(
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
+static int ata_link_init_sata_spd_limit(struct ata_link *link);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -5094,6 +5095,68 @@ void ata_dev_init(struct ata_device *dev
 }
 
 /**
+ *	ata_link_init - Initialize an ata_link structure
+ *	@ap: ATA port link is attached to
+ *	@link: Link structure to initialize
+ *	@pmp: Port multiplier port number
+ *
+ *	Initialize @link.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
+{
+	struct ata_device *dev;
+
+	/* clear everything except for devices */
+	memset(link, 0, offsetof(struct ata_link, device[0]));
+
+	link->ap = ap;
+	link->pmp = pmp;
+	link->active_tag = ATA_TAG_POISON;
+	link->hw_sata_spd_limit = UINT_MAX;
+
+	ata_link_for_each_dev(dev, link) {
+		dev->link = link;
+		dev->devno = dev - link->device;
+		ata_dev_init(dev);
+	}
+}
+
+/**
+ *	ata_link_init_sata_spd_limit - Initialize link->sata_spd_limit
+ *	@link: Link to configure sata_spd_limit for
+ *
+ *	Initialize @link->[orig_]sata_spd_limit to the currently
+ *	configured value.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int ata_link_init_sata_spd_limit(struct ata_link *link)
+{
+
+	u32 scontrol, spd;
+	int rc;
+
+	rc = ata_scr_read(link, SCR_CONTROL, &scontrol);
+	if (rc)
+		return rc;
+
+	spd = (scontrol >> 4) & 0xf;
+	if (spd)
+		link->hw_sata_spd_limit &= (1 << spd) - 1;
+
+	link->sata_spd_limit = link->hw_sata_spd_limit;
+
+	return 0;
+}
+
+/**
  *	ata_host_init - Initialize an ata_port structure
  *	@ap: Structure to initialize
  *	@host: associated SCSI mid-layer structure
@@ -5111,8 +5174,6 @@ static void ata_host_init(struct ata_por
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
 {
-	unsigned int i;
-
 	host->max_id = 16;
 	host->max_lun = 1;
 	host->max_channel = 1;
@@ -5133,8 +5194,6 @@ static void ata_host_init(struct ata_por
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->link.hw_sata_spd_limit = UINT_MAX;
-	ap->link.active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
@@ -5146,14 +5205,7 @@ static void ata_host_init(struct ata_por
 	if (ap->flags & ATA_FLAG_SATA)
 		ap->cbl = ATA_CBL_SATA;
 
-	ap->link.ap = ap;
-
-	for (i = 0; i < ata_link_max_devices(&ap->link); i++) {
-		struct ata_device *dev = &ap->link.device[i];
-		dev->link = &ap->link;
-		dev->devno = i;
-		ata_dev_init(dev);
-	}
+	ata_link_init(ap, &ap->link, 0);
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
@@ -5304,17 +5356,12 @@ int ata_device_add(const struct ata_prob
 	DPRINTK("probe begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap;
-		u32 scontrol;
 		int rc;
 
 		ap = host_set->ports[i];
 
 		/* init sata_spd_limit to the current value */
-		if (ata_scr_read(&ap->link, SCR_CONTROL, &scontrol) == 0) {
-			int spd = (scontrol >> 4) & 0xf;
-			ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
-		}
-		ap->link.sata_spd_limit = ap->link.hw_sata_spd_limit;
+		ata_link_init_sata_spd_limit(&ap->link);
 
 		rc = scsi_add_host(ap->host, dev);
 		if (rc) {
-- 
1.2.4


