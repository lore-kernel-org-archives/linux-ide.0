From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.9-libata1-dev1 2/2] sata_promise: pdc20619 support
Date: Sat, 05 Feb 2005 22:52:29 -0500
Message-ID: <4205947D.4000303@pobox.com>
References: <1098489319.2992.48.camel@server.lorenz.priv>	 <41838CB4.6090100@pobox.com> <1099148731.15964.13.camel@server.lorenz.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090307080201010308000607"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12462 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S272755AbVBFDwr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 22:52:47 -0500
In-Reply-To: <1099148731.15964.13.camel@server.lorenz.priv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Lorenz <tobias.lorenz@gmx.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090307080201010308000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

applied to libata-dev queue, in two parts (see two attached patches).


--------------090307080201010308000607
Content-Type: text/plain;
 name="patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/05 22:27:51-05:00 tobias.lorenz@gmx.net 
#   [libata sata_promise] pdc20619 (PATA) support
# 
# drivers/scsi/sata_promise.c
#   2005/02/05 22:27:44-05:00 tobias.lorenz@gmx.net +25 -1
#   [libata sata_promise] pdc20619 (PATA) support
# 
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-02-05 22:52:06 -05:00
+++ b/drivers/scsi/sata_promise.c	2005-02-05 22:52:06 -05:00
@@ -59,6 +59,7 @@
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
+	board_20619		= 2,	/* FastTrak TX4000 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
@@ -145,6 +146,17 @@
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
@@ -168,6 +180,9 @@
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 
+	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20619 },
+
 	{ }	/* terminate list */
 };
 
@@ -629,6 +644,15 @@
 	case board_2037x:
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
@@ -668,7 +692,7 @@
 
 
 MODULE_AUTHOR("Jeff Garzik");
-MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
+MODULE_DESCRIPTION("Promise ATA TX2/TX4/TX4000 low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
 MODULE_VERSION(DRV_VERSION);

--------------090307080201010308000607
Content-Type: text/plain;
 name="patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/05 22:51:28-05:00 jgarzik@pobox.com 
#   [libata sata_promise] merge Tobias Lorenz' pdc20619 patch, part 2
#   
#   Apply the second part of Tobias Lorenz's patch, the portion that
#   depended on functionality not in the base libata, but in libata-dev.
#   
#   Also, trim trailing whitespace, and remove setting of .scr_addr
#   for PDC20619, since that is senseless.
# 
# drivers/scsi/sata_promise.c
#   2005/02/05 22:51:21-05:00 jgarzik@pobox.com +14 -12
#   [libata sata_promise] merge Tobias Lorenz' pdc20619 patch, part 2
#   
#   Apply the second part of Tobias Lorenz's patch, the portion that
#   depended on functionality not in the base libata, but in libata-dev.
#   
#   Also, trim trailing whitespace, and remove setting of .scr_addr
#   for PDC20619, since that is senseless.
# 
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-02-05 22:51:53 -05:00
+++ b/drivers/scsi/sata_promise.c	2005-02-05 22:51:53 -05:00
@@ -281,7 +281,7 @@
 	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
 
 	tmp = readb(mmio);
-	
+
 	if (tmp & 0x01)
 	{
 		ap->cbl = ATA_CBL_PATA40;
@@ -290,13 +290,13 @@
 	else
 		ap->cbl = ATA_CBL_PATA80;
 }
-		
+
 static void pdc_pata_phy_reset(struct ata_port *ap)
 {
 	pdc_pata_cbl_detect(ap);
 
 	ata_port_probe(ap);
-	
+
 	ata_bus_reset(ap);
 }
 
@@ -661,9 +661,6 @@
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
 
-	probe_ent->port_flags[0] = ATA_FLAG_SATA;
-	probe_ent->port_flags[1] = ATA_FLAG_SATA;
-	
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_20319:
@@ -674,35 +671,40 @@
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
-	
+
+		probe_ent->port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->port_flags[1] = ATA_FLAG_SATA;
 		probe_ent->port_flags[2] = ATA_FLAG_SATA;
 		probe_ent->port_flags[3] = ATA_FLAG_SATA;
 		break;
+
 	case board_2037x:
+		probe_ent->port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->port_flags[1] = ATA_FLAG_SATA;
+
 		/* Some boards have also PATA port */
 		tmp = readb(mmio_base + PDC_FLASH_CTL+1);
 		if (!(tmp & 0x80))
 		{
 			probe_ent->n_ports = 3;
-			
+
 			pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
 
 			probe_ent->port_flags[2] = ATA_FLAG_SLAVE_POSS;
-			
+
 			printk(KERN_INFO DRV_NAME " PATA port found\n");
 		}
 		else
        			probe_ent->n_ports = 2;
 		break;
+
 	case board_20619:
 		probe_ent->n_ports = 4;
 
 		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
 		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+		break;
 
-		probe_ent->port[2].scr_addr = base + 0x600;
-		probe_ent->port[3].scr_addr = base + 0x700;
-                break;
 	default:
 		BUG();
 		break;

--------------090307080201010308000607--
