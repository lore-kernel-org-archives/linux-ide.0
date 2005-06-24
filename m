From: Yuri Kirsanov <flash@rccb.ru>
Subject: Re[10]: TX4000 RAID and sata_promise
Date: Fri, 24 Jun 2005 13:03:14 +0400
Message-ID: <434235437.20050624130314@rccb.ru>
References: <653445328.20050623210533@rccb.ru>
 <1124385089.5921.0.camel@localhost.localdomain>
 <375116875.20050623213325@cln.ru>
 <1124386553.5921.6.camel@localhost.localdomain>
 <865539343.20050623214027@rccb.ru>
 <1124387028.5921.10.camel@localhost.localdomain>
 <1915980015.20050623214748@rccb.ru>
 <1124387908.5921.12.camel@localhost.localdomain>
 <13110079218.20050623225607@cln.ru>
 <1124441805.2217.32.camel@localhost.localdomain>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:49373 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S932552AbVHSJCa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Aug 2005 05:02:30 -0400
In-Reply-To: <1124441805.2217.32.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

Yes, you are right, 4xPATA.
http://www.promise.com/product/product_detail_eng.asp?segment=RAID%20HBAs&product_id=104

I've been googling for a patch and found
Jeff Garzik's patch for this card to support it.
Here's the patch:

--- a/drivers/scsi/sata_promise.c       Sat May  7 05:20:31 2005
+++ b/drivers/scsi/sata_promise.c       Thu May 12 19:51:01 2005
@@ -59,6 +59,7 @@
 
        board_2037x             = 0,    /* FastTrak S150 TX2plus */
        board_20319             = 1,    /* FastTrak S150 TX4 */
+       board_20619             = 2,    /* FastTrak TX4000 */
 
        PDC_HAS_PATA            = (1 << 1), /* PDC20375 has PATA */
 
@@ -146,6 +147,17 @@
                .udma_mask      = 0x7f, /* udma0-6 ; FIXME */
                .port_ops       = &pdc_ata_ops,
        },
+
+       /* board_20619 */
+       {
+               .sht            = &pdc_ata_sht,
+               .host_flags     = ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+                                 ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS,
+               .pio_mask       = 0x1f, /* pio0-4 */
+               .mwdma_mask     = 0x07, /* mwdma0-2 */
+               .udma_mask      = 0x7f, /* udma0-6 ; FIXME */
+               .port_ops       = &pdc_ata_ops,
+       },
 };
 
 static struct pci_device_id pdc_ata_pci_tbl[] = {
@@ -169,6 +181,9 @@
        { PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },
 
+       { PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_20619 },
+
        { }     /* terminate list */
 };
 
@@ -633,6 +648,15 @@
        case board_2037x:
                        probe_ent->n_ports = 2;
                break;
+       case board_20619:
+               probe_ent->n_ports = 4;
+
+               pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+               pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+
+               probe_ent->port[2].scr_addr = base + 0x600;
+               probe_ent->port[3].scr_addr = base + 0x700;
+                break;
        default:
                BUG();
                break;
@@ -673,7 +697,7 @@
 
 
 MODULE_AUTHOR("Jeff Garzik");
-MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
+MODULE_DESCRIPTION("Promise ATA TX2/TX4/TX4000 low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
 MODULE_VERSION(DRV_VERSION);





ES> I notice that the driver reports PATA controllers. What kind of
ES> controller is it anyway, I suspect a 4xPATA? I am not sure these are
ES> actually supported! Did you do any googling on this (and searching the
ES> mailing list archives).

