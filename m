From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pcmcia: Add support for dumb 8bit IDE emulations
Date: Mon, 15 Oct 2007 20:44:11 +0100
Message-ID: <20071015204411.52d5d956@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59679 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756701AbXJOTkN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 15:40:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/pata_pcmcia.c linux-2.6.23-mm1/drivers/ata/pata_pcmcia.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/pata_pcmcia.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/pata_pcmcia.c	2007-10-15 15:17:56.000000000 +0100
@@ -87,6 +87,43 @@
 	return ata_do_set_mode(link, r_failed_dev);
 }
 
+/**
+ *	pcmcia_set_mode_8bit	-	PCMCIA specific mode setup
+ *	@link: link
+ *	@r_failed_dev: Return pointer for failed device
+ *
+ *	For the simple emulated 8bit stuff the less we do the better.
+ */
+
+static int pcmcia_set_mode_8bit(struct ata_link *link, struct ata_device **r_failed_dev)
+{
+	return 0;
+}
+
+/**
+ *	ata_data_xfer_8bit	 -	Transfer data by 8bit PIO
+ *	@adev: device to target
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@write_data: read/write
+ *
+ *	Transfer data from/to the device data register by 8 bit PIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+static void ata_data_xfer_8bit(struct ata_device *adev, unsigned char *buf,
+		   unsigned int buflen, int write_data)
+{
+	struct ata_port *ap = adev->link->ap;
+	if (write_data)
+		iowrite8_rep(ap->ioaddr.data_addr, buf, buflen);
+	else
+		ioread8_rep(ap->ioaddr.data_addr, buf, buflen);
+}
+
+
 static struct scsi_host_template pcmcia_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -130,12 +167,38 @@
 	.port_start	= ata_sff_port_start,
 };
 
+static struct ata_port_operations pcmcia_8bit_port_ops = {
+	.set_mode	= pcmcia_set_mode_8bit,
+	.tf_load	= ata_tf_load,
+	.tf_read	= ata_tf_read,
+	.check_status 	= ata_check_status,
+	.exec_command	= ata_exec_command,
+	.dev_select 	= ata_std_dev_select,
+
+	.freeze		= ata_bmdma_freeze,
+	.thaw		= ata_bmdma_thaw,
+	.error_handler	= ata_bmdma_error_handler,
+	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
+
+	.qc_prep 	= ata_qc_prep,
+	.qc_issue	= ata_qc_issue_prot,
+
+	.data_xfer	= ata_data_xfer_8bit,
+
+	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+
+	.port_start	= ata_sff_port_start,
+};
+
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
 /**
  *	pcmcia_init_one		-	attach a PCMCIA interface
  *	@pdev: pcmcia device
+ *	@ops: operations for this device
  *
  *	Register a PCMCIA IDE interface. Such interfaces are PIO 0 and
  *	shared IRQ.
@@ -157,6 +220,8 @@
 	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM;
 	unsigned long io_base, ctl_base;
 	void __iomem *io_addr, *ctl_addr;
+	
+	struct ata_port_operations *ops = &pcmcia_port_ops;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL)
@@ -284,6 +349,8 @@
 	if (pdev->io.NumPorts1 >= 0x20)
 		printk(KERN_WARNING DRV_NAME ": second channel not yet supported.\n");
 
+	if (pdev->manf_id == 0x0097 && pdev->card_id == 0x1620)
+		ops = &pcmcia_8bit_port_ops;
 	/*
  	 *	Having done the PCMCIA plumbing the ATA side is relatively
  	 *	sane.
@@ -294,7 +361,7 @@
 		goto failed;
 	ap = host->ports[0];
 
-	ap->ops = &pcmcia_port_ops;
+	ap->ops = ops;
 	ap->pio_mask = 1;		/* ISA so PIO 0 cycles */
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 	ap->ioaddr.cmd_addr = io_addr;
@@ -359,6 +426,7 @@
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x0704),
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x2904),
 	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),	/* SanDisk CFA */
+ 	PCMCIA_DEVICE_MANF_CARD(0x0097, 0x1620), 	/* TI emulated */
 	PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),	/* Toshiba */
 	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
 	PCMCIA_DEVICE_MANF_CARD(0x00ce, 0x0000),	/* Samsung */
@@ -415,7 +483,7 @@
 	.drv = {
 		.name		= DRV_NAME,
 	},
-	.id_table	= pcmcia_devices,
+ 	.id_table	= pcmcia_devices,
 	.probe		= pcmcia_init_one,
 	.remove		= pcmcia_remove_one,
 };
