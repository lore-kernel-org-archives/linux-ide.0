From: Tobias Lorenz <tobias.lorenz@gmx.net>
Subject: [PATCH 2.6.9-libata1-dev1] sata_promise: pdc20619 support
Date: Sat, 23 Oct 2004 01:55:20 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098489319.2992.48.camel@server.lorenz.priv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:64193 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269298AbUJVXzL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Oct 2004 19:55:11 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi,

this patch add support for Promise FastTrak TX4000 4-port PATA hardware
raid controller (pdc20619). It is very similar to the sata_promise.c
driver, so we added the support here.

Jeff Garzik wrote:
> 6) [summary]  Overall, I do not see any bugs or problems in your 
> sata_promise patch.  However...  I need to ponder a "human"
> question... 
>   does it make sense to add support for a PATA controller to a module 
> named 'sata_promise'?
> 
> I wish to avoid code duplication of course, but this is an issue I
> would 
> like to address.

I can ask you the same question ? Isn't SATA more IDE/ATA than SCSI ?
:-)

We made the support here for three reasons:
1. It was the fastest way to support the controller.
2. It's now based on a proven and stable driver for almost identical
hardware.
3. And we failed to create the driver as an ide driver. Opposite to all
other ide drivers, the pdc20619 is not compatible with the generic ide
driver. All other 4-port cards presenting themselfs as two 2-port cards.
The ide layer doesn't even seem to support more than 2 channels per
controller.

> Perhaps we could apply your patch, then rename the kernel module to 
> 'ata_promise'.  [we can use the MODULE_ALIAS facility to smooth the
> user 
> transition]
I think that's a good idea, as the driver now supports PATA controllers
too and maybe the other pdc206xx PATA controllers are also working with
that driver (we don't have the hardware to try). This patch also renames
all the pata-compatible sata-structures and -functions to ata.

Signed-off-by: Tobias Lorenz <tobias.lorenz@gmx.net>

--- a/drivers/scsi/sata_promise.c       2004-10-20 22:07:50.000000000 +0200
+++ b/drivers/scsi/sata_promise.c       2004-10-20 13:18:44.000000000 +0200
@@ -59,6 +59,7 @@

        board_2037x             = 0,    /* FastTrak S150 TX2plus */
        board_20319             = 1,    /* FastTrak S150 TX4 */
+       board_20619             = 2,    /* FastTrak TX4000 */

        PDC_HAS_PATA            = (1 << 1), /* PDC20375 has PATA */

@@ -73,7 +74,7 @@

 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -87,7 +88,7 @@
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);

-static Scsi_Host_Template pdc_sata_sht = {
+static Scsi_Host_Template pdc_ata_sht = {
        .module                 = THIS_MODULE,
        .name                   = DRV_NAME,
        .ioctl                  = ata_scsi_ioctl,
@@ -106,7 +107,7 @@
        .bios_param             = ata_std_bios_param,
 };

-static struct ata_port_operations pdc_sata_ops = {
+static struct ata_port_operations pdc_ata_ops = {
        .port_disable           = ata_port_disable,
        .tf_load                = pdc_tf_load_mmio,
        .tf_read                = ata_tf_read,
@@ -128,48 +129,61 @@
 static struct ata_port_info pdc_port_info[] = {
        /* board_2037x */
        {
-               .sht            = &pdc_sata_sht,
+               .sht            = &pdc_ata_sht,
                .host_flags     = /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |
                                  ATA_FLAG_SRST | ATA_FLAG_MMIO,
                .pio_mask       = 0x1f, /* pio0-4 */
                .mwdma_mask     = 0x07, /* mwdma0-2 */
                .udma_mask      = 0x7f, /* udma0-6 ; FIXME */
-               .port_ops       = &pdc_sata_ops,
+               .port_ops       = &pdc_ata_ops,
        },

        /* board_20319 */
        {
-               .sht            = &pdc_sata_sht,
+               .sht            = &pdc_ata_sht,
                .host_flags     = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
                                  ATA_FLAG_SRST | ATA_FLAG_MMIO,
                .pio_mask       = 0x1f, /* pio0-4 */
                .mwdma_mask     = 0x07, /* mwdma0-2 */
                .udma_mask      = 0x7f, /* udma0-6 ; FIXME */
-               .port_ops       = &pdc_sata_ops,
+               .port_ops       = &pdc_ata_ops,
+       },
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
        },
 };

-static struct pci_device_id pdc_sata_pci_tbl[] = {
+static struct pci_device_id pdc_ata_pci_tbl[] = {
        { PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },
        { PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },
+       { PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_20619 },
        { }     /* terminate list */
 };


-static struct pci_driver pdc_sata_pci_driver = {
+static struct pci_driver pdc_ata_pci_driver = {
        .name                   = DRV_NAME,
-       .id_table               = pdc_sata_pci_tbl,
-       .probe                  = pdc_sata_init_one,
+       .id_table               = pdc_ata_pci_tbl,
+       .probe                  = pdc_ata_init_one,
        .remove                 = ata_pci_remove_one,
 };

@@ -258,7 +272,7 @@
        void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;

        tmp = readb(mmio);
-
+
        if (tmp & 0x01)
        {
                ap->cbl = ATA_CBL_PATA40;
@@ -267,13 +281,13 @@
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

@@ -511,7 +525,7 @@
 }


-static void pdc_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
 {
        port->cmd_addr          = base;
        port->data_addr         = base;
@@ -569,7 +583,7 @@
        writel(tmp, mmio + PDC_SLEW_CTL);
 }

-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
        static int printed_version;
        struct ata_probe_ent *probe_ent = NULL;
@@ -630,44 +644,55 @@
                probe_ent->irq_flags = SA_SHIRQ;
        probe_ent->mmio_base = mmio_base;

-       pdc_sata_setup_port(&probe_ent->port[0], base + 0x200);
-       pdc_sata_setup_port(&probe_ent->port[1], base + 0x280);
+       pdc_ata_setup_port(&probe_ent->port[0], base + 0x200);
+       pdc_ata_setup_port(&probe_ent->port[1], base + 0x280);

        probe_ent->port[0].scr_addr = base + 0x400;
        probe_ent->port[1].scr_addr = base + 0x500;

-       probe_ent->port_flags[0] = ATA_FLAG_SATA;
-       probe_ent->port_flags[1] = ATA_FLAG_SATA;
-
        /* notice 4-port boards */
        switch (board_idx) {
        case board_20319:
                        probe_ent->n_ports = 4;

-               pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
-               pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
+               pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+               pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);

                probe_ent->port[2].scr_addr = base + 0x600;
                probe_ent->port[3].scr_addr = base + 0x700;

+               probe_ent->port_flags[0] = ATA_FLAG_SATA;
+               probe_ent->port_flags[1] = ATA_FLAG_SATA;
                probe_ent->port_flags[2] = ATA_FLAG_SATA;
                probe_ent->port_flags[3] = ATA_FLAG_SATA;
                break;
        case board_2037x:
+               probe_ent->port_flags[0] = ATA_FLAG_SATA;
+               probe_ent->port_flags[1] = ATA_FLAG_SATA;
+
                /* Some boards have also PATA port */
                tmp = readb(base + PDC_FLASH_CTL+1);
                if (!(tmp & 0x80))
                {
                        probe_ent->n_ports = 3;
-
-                       pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
+
+                       pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);

                        probe_ent->port_flags[2] = ATA_FLAG_SLAVE_POSS;

                        printk(KERN_INFO DRV_NAME " PATA port found\n");
                }
                else
-                               probe_ent->n_ports = 2;
+                       probe_ent->n_ports = 2;
+               break;
+       case board_20619:
+               probe_ent->n_ports = 4;
+
+               pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+               pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
+
+               probe_ent->port[2].scr_addr = base + 0x600;
+               probe_ent->port[3].scr_addr = base + 0x700;
                break;
        default:
                BUG();
@@ -695,22 +720,22 @@
 }


-static int __init pdc_sata_init(void)
+static int __init pdc_ata_init(void)
 {
-       return pci_module_init(&pdc_sata_pci_driver);
+       return pci_module_init(&pdc_ata_pci_driver);
 }


-static void __exit pdc_sata_exit(void)
+static void __exit pdc_ata_exit(void)
 {
-       pci_unregister_driver(&pdc_sata_pci_driver);
+       pci_unregister_driver(&pdc_ata_pci_driver);
 }


 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, pdc_sata_pci_tbl);
+MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);

-module_init(pdc_sata_init);
-module_exit(pdc_sata_exit);
+module_init(pdc_ata_init);
+module_exit(pdc_ata_exit);


