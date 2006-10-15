From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/18] [PATCH] libata-link: separate out link initialization functions
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <11609528803880-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:34230 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422931AbWJOWyy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:54 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626616nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:53 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out link initialization into ata_link_init() and
ata_link_init_sata_spd_limit().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   80 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6a3442b..f5a9ac2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5392,6 +5392,66 @@ void ata_dev_init(struct ata_device *dev
 }
 
 /**
+ *	ata_link_init - Initialize an ata_link structure
+ *	@ap: ATA port link is attached to
+ *	@link: Link structure to initialize
+ *
+ *	Initialize @link.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+static void ata_link_init(struct ata_port *ap, struct ata_link *link)
+{
+	struct ata_device *dev;
+
+	/* clear everything except for devices */
+	memset(link, 0, offsetof(struct ata_link, device[0]));
+
+	link->ap = ap;
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
+ *	sata_link_init_spd_limit - Initialize link->sata_spd_limit
+ *	@link: Link to configure sata_spd_limit for
+ *
+ *	Initialize @link->[hw_]sata_spd_limit to the currently
+ *	configured value.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int sata_link_init_spd_limit(struct ata_link *link)
+{
+
+	u32 scontrol, spd;
+	int rc;
+
+	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
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
  *	ata_port_init - Initialize an ata_port structure
  *	@ap: Structure to initialize
  *	@host: Collection of hosts to which @ap belongs
@@ -5406,8 +5466,6 @@ void ata_dev_init(struct ata_device *dev
 void ata_port_init(struct ata_port *ap, struct ata_host *host,
 		   const struct ata_probe_ent *ent, unsigned int port_no)
 {
-	unsigned int i;
-
 	ap->lock = &host->lock;
 	ap->flags = ATA_FLAG_DISABLED;
 	ap->id = ata_unique_id++;
@@ -5428,8 +5486,6 @@ void ata_port_init(struct ata_port *ap, 
 		ap->flags |= ent->port_flags;
 		ap->ops = ent->port_ops;
 	}
-	ap->link.hw_sata_spd_limit = UINT_MAX;
-	ap->link.active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
 #if defined(ATA_VERBOSE_DEBUG)
@@ -5452,14 +5508,7 @@ #endif
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
+	ata_link_init(ap, &ap->link);
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
@@ -5677,15 +5726,10 @@ int ata_device_add(const struct ata_prob
 	DPRINTK("probe begin\n");
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		u32 scontrol;
 		int rc;
 
 		/* init sata_spd_limit to the current value */
-		if (sata_scr_read(&ap->link, SCR_CONTROL, &scontrol) == 0) {
-			int spd = (scontrol >> 4) & 0xf;
-			ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
-		}
-		ap->link.sata_spd_limit = ap->link.hw_sata_spd_limit;
+		sata_link_init_spd_limit(&ap->link);
 
 		rc = scsi_add_host(ap->scsi_host, dev);
 		if (rc) {
-- 
1.4.2.3


