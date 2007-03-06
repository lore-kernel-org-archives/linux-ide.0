From: akpm@linux-foundation.org
Subject: [patch 05/30] pcmcia - spot slave decode flaws (for testing)
Date: Tue, 06 Mar 2007 02:37:54 -0800
Message-ID: <200703061037.l26AbsJI019466@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34429 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934035AbXCFKiP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan <alan@lxorguk.ukuu.org.uk>

If you've got a CF adapter or PCMCIA disc which shows up twice in libata
pata_pcmcia can you try this patch on top of the updates posted.  It tries
to spot when the slave is a mirror of the master and to fix up problems
that causes.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_pcmcia.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff -puN drivers/ata/pata_pcmcia.c~pcmcia-spot-slave-decode-flaws-for-testing drivers/ata/pata_pcmcia.c
--- a/drivers/ata/pata_pcmcia.c~pcmcia-spot-slave-decode-flaws-for-testing
+++ a/drivers/ata/pata_pcmcia.c
@@ -54,6 +54,39 @@ struct ata_pcmcia_info {
 	dev_node_t	node;
 };
 
+/**
+ *	pcmcia_set_mode	-	PCMCIA specific mode setup
+ *	@ap: Port
+ *	@r_failed_dev: Return pointer for failed device
+ *
+ *	Perform the tuning and setup of the devices and timings, which
+ *	for PCMCIA is the same as any other controller. We wrap it however
+ *	as we need to spot hardware with incorrect or missing master/slave
+ *	decode, which alas is embarrassingly common in the PC world
+ */
+
+static int pcmcia_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_device *master = &ap->device[0];
+	struct ata_device *slave = &ap->device[1];
+
+	if (!ata_dev_enabled(master) || !ata_dev_enabled(slave))
+		return ata_do_set_mode(ap, r_failed_dev);
+
+	if (memcmp(master->id + ATA_ID_FW_REV,  slave->id + ATA_ID_FW_REV,
+			   ATA_ID_FW_REV_LEN + ATA_ID_PROD_LEN) == 0)
+	{
+		/* Suspicious match, but could be two cards from
+		   the same vendor - check serial */
+		if (memcmp(master->id + ATA_ID_SERNO, slave->id + ATA_ID_SERNO,
+			   ATA_ID_SERNO_LEN) == 0 && master->id[ATA_ID_SERNO] >> 8) {
+			ata_dev_printk(slave, KERN_WARNING, "is a ghost device, ignoring.\n");
+			ata_dev_disable(slave);
+		}
+	}
+	return ata_do_set_mode(ap, r_failed_dev);
+}
+
 static struct scsi_host_template pcmcia_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -73,6 +106,7 @@ static struct scsi_host_template pcmcia_
 };
 
 static struct ata_port_operations pcmcia_port_ops = {
+	.set_mode	= pcmcia_set_mode,
 	.port_disable	= ata_port_disable,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
_
