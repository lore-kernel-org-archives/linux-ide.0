From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/11] [libata] Kill 'count' var in ata_device_add()
Date: Wed, 2 Aug 2006 05:11:49 +0900
Message-ID: <11544631091408-git-send-email-htejun@gmail.com>
References: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:2397 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932477AbWHAULz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:11:55 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1502194uge
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:11:53 -0700 (PDT)
In-Reply-To: <11544631081793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Eliminate redundant loop variable 'count'

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

bbf12ff2c1007f7c1275d7e5b44db8217af30cf2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4e06edc..fdcc58e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5370,7 +5370,7 @@ err_out:
  */
 int ata_device_add(const struct ata_probe_ent *ent)
 {
-	unsigned int count = 0, i;
+	unsigned int i;
 	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
 	int rc;
@@ -5392,7 +5392,7 @@ int ata_device_add(const struct ata_prob
 	host_set->flags = ent->host_set_flags;
 
 	/* register each port bound to this device */
-	for (i = 0; i < ent->n_ports; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
 
@@ -5418,12 +5418,8 @@ int ata_device_add(const struct ata_prob
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
 		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
-		count++;
 	}
 
-	if (!count)
-		goto err_free_ret;
-
 	/* obtain irq, that is shared between channels */
 	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			 DRV_NAME, host_set);
@@ -5435,13 +5431,11 @@ int ata_device_add(const struct ata_prob
 
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
-	for (i = 0; i < count; i++) {
-		struct ata_port *ap;
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 		u32 scontrol;
 		int rc;
 
-		ap = host_set->ports[i];
-
 		/* init sata_spd_limit to the current value */
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
@@ -5497,7 +5491,7 @@ int ata_device_add(const struct ata_prob
 
 	/* probes are done, now scan each port's disk(s) */
 	DPRINTK("host probe begin\n");
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
 		ata_scsi_scan_host(ap);
@@ -5509,14 +5503,14 @@ int ata_device_add(const struct ata_prob
 	return ent->n_ports; /* success */
 
 err_out:
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
 		scsi_remove_host(ap->host);
 		ap->ops->port_stop(ap);
 		scsi_host_put(ap->host);
 	}
-err_free_ret:
+
 	kfree(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
-- 
1.3.2


