From: Yuri Kirsanov <flash@rccb.ru>
Subject: Re[6]: TX4000 RAID and sata_promise
Date: Tue, 21 Jun 2005 22:19:13 +0400
Message-ID: <1483195265.20050621221913@rccb.ru>
References: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
 <4301E5C5.2030203@dtbb.net>  <1124199054.5550.71.camel@localhost.localdomain>
 <015701c5a267$594284f0$6f0aa8c0@rgkb.local>
 <1124200207.5550.74.camel@localhost.localdomain>
 <016a01c5a26a$1745ca50$6f0aa8c0@rgkb.local>
 <1124200516.5550.77.camel@localhost.localdomain>
 <017501c5a26a$bb31bfc0$6f0aa8c0@rgkb.local>
 <1124202300.19419.0.camel@localhost.localdomain>
 <1721975015.20050621203841@rccb.ru>
 <1124211467.19419.24.camel@localhost.localdomain>
 <71290359.20050621214728@rccb.ru>
 <1124215786.29001.2.camel@localhost.localdomain>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.100] ([213.85.106.100]:57263 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S1030280AbVHPSS3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2005 14:18:29 -0400
In-Reply-To: <1124215786.29001.2.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org


ES> Hmm, then I guess it would be very interesting to know WHY it doesn't
ES> load at boot time! What are the symptoms?

ES> It seems to strange to me that sata reports PATA devices... What kind of
ES> harddisks do you connected (brand, type, pata/sata?)

I have Promise TX4000 4xPATA controller...I've patched it with this
patch:

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

