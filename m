From: Brad Campbell <brad@wasp.net.au>
Subject: libata dev_config call order wrong.
Date: Sun, 29 Aug 2004 21:09:03 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41320DAF.2060306@wasp.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-22999-1093799306-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:60828 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268204AbUH2RI2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Aug 2004 13:08:28 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-22999-1093799306-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Well, well, well - Three holes in the ground.

My bridge boards *are* choking on > 200 sector transfers.

I patched sata_via in the same way sata_sil was patched to tell the controller to use 200 as 
max_sectors the same way sata_sil uses 15 as max_sectors on the seagates.

The problem is that ata_scsi_slave_config in libata-scsi.c is getting called *after* .dev_config in 
sata_via and resetting my value of 200 to 2048.

If I hard code 200 into ata_scsi_slave_config then this issue never raises it's ugly head and I 
can't get the bridge boards to crash.

I wonder if this might be happening in sata_sil also?

I added a simple printk in ata_scsi_slave_config to print "Slave Config!!!"
See attached log. I have also attached my patch to sata_via for sanity checking, in case I did 
something obviously wrong.

ata9: no device found (phy stat 00000000)
scsi8 : sata_promise
ata10: no device found (phy stat 00000000)
scsi9 : sata_promise
ata11: no device found (phy stat 00000000)
scsi10 : sata_promise
ata12: no device found (phy stat 00000000)
scsi11 : sata_promise
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 0
ata13: SATA max UDMA/133 cmd 0x8800 ctl 0x8402 bmdma 0x7400 irq 20
ata14: SATA max UDMA/133 cmd 0x8000 ctl 0x7802 bmdma 0x7408 irq 20
ata13: dev 0 ATA, max UDMA/100, 390622887 sectors: lba48

ata13(0): applying WD errata fix

ata13: dev 0 configured for UDMA/100
scsi12 : sata_via
ata14: no device found (phy stat 00000000)
scsi13 : sata_via
   Vendor: ATA       Model: WDC WD2000JB-00D  Rev: 02.1
   Type:   Direct-Access                      ANSI SCSI revision: 05

Slave Config!!!

SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host12/bus0/target0/lun0: unknown partition table
Attached scsi disk sda at scsi12, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi12, channel 0, id 0, lun 0,  type 0

Regards,
Brad

--=_wasp.net.au-22999-1093799306-0001-2
Content-Type: text/plain; name="sata.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata.patch"

--- orig/linux-2.6.0/drivers/scsi/sata_via.c	2004-08-26 22:21:56.000000000 +0400
+++ linux-2.6.9-rc1/drivers/scsi/sata_via.c	2004-08-26 22:14:19.000000000 +0400
@@ -59,10 +59,13 @@
 
 	SATA_EXT_PHY		= (1 << 6), /* 0==use PATA, 1==ext phy */
 	SATA_2DEV		= (1 << 5), /* SATA is master/slave */
+	SVIA_QUIRK_200SECTS	= (1 << 0),
+
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void svia_dev_config(struct ata_port *ap, struct ata_device *dev);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id svia_pci_tbl[] = {
@@ -71,6 +74,14 @@
 	{ }	/* terminate list */
 };
 
+struct svia_drivelist {
+        const char * product;
+        unsigned int quirk;
+} svia_blacklist [] = {
+        { "WDC WD2000JB",         SVIA_QUIRK_200SECTS },
+        { }
+};
+
 static struct pci_driver svia_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= svia_pci_tbl,
@@ -122,6 +133,8 @@
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.dev_config		= svia_dev_config,
+
 };
 
 MODULE_AUTHOR("Jeff Garzik");
@@ -283,6 +296,40 @@
 	return rc;
 }
 
+static void svia_dev_config(struct ata_port *ap, struct ata_device *dev)
+{
+        unsigned int n, quirks = 0;
+        unsigned char model_num[40];
+        const char *s;
+        unsigned int len;
+
+        ata_dev_id_string(dev, model_num, ATA_ID_PROD_OFS,
+                          sizeof(model_num));
+        s = &model_num[0];
+        len = strnlen(s, sizeof(model_num));
+
+        /* ATAPI specifies that empty space is blank-filled; remove blanks */
+        while ((len > 0) && (s[len - 1] == ' '))
+                len--;
+
+        for (n = 0; svia_blacklist[n].product; n++) 
+                if (!memcmp(svia_blacklist[n].product, s,
+                            strlen(svia_blacklist[n].product))) {
+                        quirks = svia_blacklist[n].quirk;
+                        break;
+                }
+        
+        /* limit requests to 200 sectors */
+        if (quirks & SVIA_QUIRK_200SECTS) {
+                printk(KERN_INFO "ata%u(%u): applying WD errata fix\n",
+                       ap->id, dev->devno);
+                ap->host->max_sectors = 200;
+                ap->host->hostt->max_sectors = 200;
+                return;
+        }
+
+}
+
 static int __init svia_init(void)
 {
 	return pci_module_init(&svia_pci_driver);

--=_wasp.net.au-22999-1093799306-0001-2--
