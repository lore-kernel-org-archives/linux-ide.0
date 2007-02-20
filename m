From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]: pcmcia - spot slave decode flaws (for testing)
Date: Tue, 20 Feb 2007 18:18:36 +0000
Message-ID: <20070220181836.524e5f9a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030319AbXBTROw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

If you've got a CF adapter or PCMCIA disc which shows up twice in libata
pata_pcmcia can you try this patch on top of the updates posted. It tries
to spot when the slave is a mirror of the master and to fix up problems
that causes.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-mm2/drivers/ata/pata_pcmcia.c linux-2.6.20-mm2/drivers/ata/pata_pcmcia.c
--- linux.vanilla-2.6.20-mm2/drivers/ata/pata_pcmcia.c	2007-02-20 13:37:58.000000000 +0000
+++ linux-2.6.20-mm2/drivers/ata/pata_pcmcia.c	2007-02-20 14:28:13.000000000 +0000
@@ -54,6 +54,39 @@
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
@@ -73,6 +106,7 @@
 };
 
 static struct ata_port_operations pcmcia_port_ops = {
+	.set_mode	= pcmcia_set_mode,
 	.port_disable	= ata_port_disable,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
