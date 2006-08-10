From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/9] [libata] Kill 'count' var in ata_device_add()
Date: Thu, 10 Aug 2006 17:16:29 +0900
Message-ID: <1155197789264-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:27950 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751455AbWHJIQf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:35 -0400
Received: by py-out-1112.google.com with SMTP id z74so730394pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:34 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Eliminate redundant loop variable 'count'

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

6d0500df5b37c94b779ac2c3f522ff917e039f99
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3aa477a..38fc75d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5403,7 +5403,7 @@ void ata_host_set_init(struct ata_host_s
  */
 int ata_device_add(const struct ata_probe_ent *ent)
 {
-	unsigned int count = 0, i;
+	unsigned int i;
 	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
 	int rc;
@@ -5422,7 +5422,7 @@ int ata_device_add(const struct ata_prob
 	host_set->private_data = ent->private_data;
 
 	/* register each port bound to this device */
-	for (i = 0; i < ent->n_ports; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
 
@@ -5448,12 +5448,8 @@ int ata_device_add(const struct ata_prob
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
@@ -5465,13 +5461,11 @@ int ata_device_add(const struct ata_prob
 
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
@@ -5527,7 +5521,7 @@ int ata_device_add(const struct ata_prob
 
 	/* probes are done, now scan each port's disk(s) */
 	DPRINTK("host probe begin\n");
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
 		ata_scsi_scan_host(ap);
@@ -5539,14 +5533,14 @@ int ata_device_add(const struct ata_prob
 	return ent->n_ports; /* success */
 
 err_out:
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 		if (ap) {
 			ap->ops->port_stop(ap);
 			scsi_host_put(ap->host);
 		}
 	}
-err_free_ret:
+
 	kfree(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
-- 
1.3.2


