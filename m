From: Tobias Lorenz <tobias.lorenz@gmx.net>
Subject: Re: [PATCH 2.6.9-libata1-dev1 2/2] sata_promise: pdc20619 support
Date: Sat, 30 Oct 2004 17:05:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1099148731.15964.13.camel@server.lorenz.priv>
References: <1098489319.2992.48.camel@server.lorenz.priv>
	 <41838CB4.6090100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261271AbUJ3PFi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 11:05:38 -0400
In-Reply-To: <41838CB4.6090100@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

> Can I ask you to do one further task on this patch:  split it up into 
> two patches:  1) rename s/sata/ata/ symbols, etc.  2) implement pdc20619 
> supports
here comes patch two.

This one with support for pdc20619.

Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>

--- a/drivers/scsi/sata_promise.c	2004-10-30 16:44:04.000000000 +0200
+++ b/drivers/scsi/sata_promise.c	2004-10-30 16:52:49.000000000 +0200
@@ -59,6 +59,7 @@
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
+	board_20619		= 2,	/* FastTrak TX4000 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
@@ -147,6 +148,17 @@
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_ata_ops,
 	},
+
+	/* board_20619 */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+				  ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_ata_ops,
+	},
 };
 
 static struct pci_device_id pdc_ata_pci_tbl[] = {
@@ -162,6 +174,8 @@
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20619 },
 	{ }	/* terminate list */
 };
 
@@ -636,9 +650,6 @@
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
 
-	probe_ent->port_flags[0] = ATA_FLAG_SATA;
-	probe_ent->port_flags[1] = ATA_FLAG_SATA;
-	
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_20319:
@@ -650,10 +661,15 @@
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
 	
+		probe_ent->port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->port_flags[1] = ATA_FLAG_SATA;
 		probe_ent->port_flags[2] = ATA_FLAG_SATA;
 		probe_ent->port_flags[3] = ATA_FLAG_SATA;
 		break;
 	case board_2037x:
+		probe_ent->port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->port_flags[1] = ATA_FLAG_SATA;
+
 		/* Some boards have also PATA port */
 		tmp = readb(base + PDC_FLASH_CTL+1);
 		if (!(tmp & 0x80))
@@ -669,6 +685,15 @@
 		else
 			probe_ent->n_ports = 2;
 		break;
+	case board_20619:
+		probe_ent->n_ports = 4;
+
+		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+
+		probe_ent->port[2].scr_addr = base + 0x600;
+		probe_ent->port[3].scr_addr = base + 0x700;
+                break;
 	default:
 		BUG();
 		break;
@@ -708,7 +733,7 @@
 
 
 MODULE_AUTHOR("Jeff Garzik");
-MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
+MODULE_DESCRIPTION("Promise ATA TX2/TX4/TX4000 low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);


