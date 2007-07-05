From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc7 3/3] libata: pata_via CX700 quirks
Date: Thu, 5 Jul 2007 13:39:49 +0900
Message-ID: <20070705043949.GZ29122@htj.dyndns.org>
References: <20070705043127.GX29122@htj.dyndns.org> <20070705043501.GY29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:42999 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbXGEEjy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 00:39:54 -0400
Received: by py-out-1112.google.com with SMTP id u77so4195316pyb
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 21:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070705043501.GY29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

For some reason, via decided that combined SATA/PATA setup in sata_via
isn't good enough and added a SATA port without SCR access to CX700.
For yet another unknown reason, slave slot of the SATA port dislikes
SETXFER.

This patch implements two quirks for CX700 - VIA_SATA_PATA and
VIA_BAD_SLAVE_SETXFER.  SATA_PATA indicates that the first port is
SATA and BAD_SLAVE_SETXFER indicates slave port may fail SETXFER.

  http://bugzilla.kernel.org/show_bug.cgi?id=8563

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_via.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -84,6 +84,8 @@ enum {
 	VIA_BAD_ID	= 0x100, /* Has wrong vendor ID (0x1107) */
 	VIA_BAD_AST	= 0x200, /* Don't touch Address Setup Timing */
 	VIA_NO_ENABLES	= 0x400, /* Has no enablebits */
+	VIA_BAD_SLAVE_SETXFER = 0x0800, /* SETXFER on slave device may fail */
+	VIA_SATA_PATA	= 0x1000, /* SATA/PATA combined configuration */
 };
 
 /*
@@ -99,7 +101,7 @@ static const struct via_isa_bridge {
 } via_isa_bridges[] = {
 	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_SATA_PATA | VIA_BAD_SLAVE_SETXFER },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES},
 	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -168,6 +170,9 @@ static int via_cable_detect(struct ata_p
 	if (via_cable_override(pdev))
 		return ATA_CBL_PATA40_SHORT;
 
+	if ((config->flags & VIA_SATA_PATA) && ap->port_no == 0)
+		return ATA_CBL_SATA;
+
 	/* Early chips are 40 wire */
 	if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
 		return ATA_CBL_PATA40;
@@ -292,6 +297,15 @@ static void via_do_set_mode(struct ata_p
 		pci_write_config_byte(pdev, 0x50 + offset, ut);
 }
 
+static void via_dev_config(struct ata_device *dev)
+{
+	const struct via_isa_bridge *config = dev->ap->host->private_data;
+
+	/* some new VIA chips have problem with SETXFER on slave slot */
+	if (dev->devno && (config->flags & VIA_BAD_SLAVE_SETXFER))
+		dev->horkage |= ATA_HORKAGE_SETXFER;
+}
+
 static void via_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	const struct via_isa_bridge *config = ap->host->private_data;
@@ -334,6 +348,7 @@ static struct scsi_host_template via_sht
 
 static struct ata_port_operations via_port_ops = {
 	.port_disable	= ata_port_disable,
+	.dev_config	= via_dev_config,
 	.set_piomode	= via_set_piomode,
 	.set_dmamode	= via_set_dmamode,
 	.mode_filter	= ata_pci_default_filter,
@@ -370,6 +385,7 @@ static struct ata_port_operations via_po
 
 static struct ata_port_operations via_port_ops_noirq = {
 	.port_disable	= ata_port_disable,
+	.dev_config	= via_dev_config,
 	.set_piomode	= via_set_piomode,
 	.set_dmamode	= via_set_dmamode,
 	.mode_filter	= ata_pci_default_filter,
