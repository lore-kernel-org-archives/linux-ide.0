From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata fixes
Date: Tue, 31 Aug 2004 03:06:42 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040831070642.GA22296@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:28106 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266905AbUHaHHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2004 03:07:53 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>


Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 drivers/scsi/ata_piix.c    |    2 +-
 drivers/scsi/libata-core.c |   13 +++++++------
 drivers/scsi/libata-scsi.c |    8 ++++----
 drivers/scsi/sata_nv.c     |   20 ++++++++++++--------
 include/linux/libata.h     |    1 +
 5 files changed, 25 insertions(+), 19 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/08/31 1.1523.1.5)
   [libata] resync with 2.6 (very minor, mostly cosmetic)

<bzolnier@elka.pw.edu.pl> (04/08/30 1.1523.1.4)
   [PATCH] libata: ata_piix.c PIO fix
   
   [patch] libata: ata_piix.c PIO fix
   
   "[libata] transfer mode cleanup" introduced bug in ata_piix.c:
   previously PIO number (not mode) was passed to piix_set_piomode().
   Fortunately this function is only used for (disabled) PATA support.
   
   I bet that this is the reason why MWDMA didn't work for PATA.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

<achew@nvidia.com> (04/08/28 1.1523.1.3)
   [PATCH] sata_nv: fix CK804 support
   
   This patch fixes a problem introduced when CK804 support was added.  mmio_base can only be set in the CK804 case,
   else libata will attempt to iounmap mmio_base, which isn't iomapped for the non-CK804 case.  Still need the bar 5
   address, so steal from host_set->ports[0]->ioaddr.scr_addr.  Jeff, let me know if this is a bad thing to do.

<jeremy@sgi.com> (04/08/28 1.1523.1.2)
   [PATCH] Fix DMA boundary overflow bug
   
   We seem to have found an overflow problem in libata-core.c.
   We were trying to DMA to the address range 0xffff8000-0xffffbfff.
   
   In the original version of the code, given that address and
   count (0xffff8000 and 0x4000), the variable "boundary" would be
   set to 0, causing len to be set to 0x8000 (which is greater than
   sg_len).  Then at the bottom of the loop, sg_len would be set
   to 0xffffc000 (0x4000 - 0x8000), which would then cause the
   loop never to terminate (until much of memory was scribbled
   over or the kernel died).
   
   The code below should be functionally identical, but not be
   subject to the same overflow problem (boundary needs to be a
   u33).
   
   Signed-off-by: jeremy@sgi.com
   
   ===== drivers/scsi/libata-core.c 1.94 vs edited =====

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-08-31 03:05:50 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-08-31 03:05:50 -04:00
@@ -390,7 +390,7 @@
 
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned int pio	= adev->pio_mode;
+	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= ap->host_set->pdev;
 	unsigned int is_slave	= (adev->devno != 0);
 	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-08-31 03:05:50 -04:00
+++ b/drivers/scsi/libata-core.c	2004-08-31 03:05:50 -04:00
@@ -1858,7 +1858,7 @@
 
 	idx = 0;
 	for (nelem = qc->n_elem; nelem; nelem--,sg++) {
-		u32 addr, boundary;
+		u32 addr, offset;
 		u32 sg_len, len;
 
 		/* determine if physical DMA addr spans 64K boundary.
@@ -1869,10 +1869,10 @@
 		sg_len = sg_dma_len(sg);
 
 		while (sg_len) {
-			boundary = (addr & ~0xffff) + (0xffff + 1);
+			offset = addr & 0xffff;
 			len = sg_len;
-			if ((addr + sg_len) > boundary)
-				len = boundary - addr;
+			if ((offset + sg_len) > 0x10000)
+				len = 0x10000 - offset;
 
 			ap->prd[idx].addr = cpu_to_le32(addr);
 			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
@@ -2304,8 +2304,9 @@
 
 	if ((ap->pio_task_state != PIO_ST_IDLE) &&
 	    (ap->pio_task_state != PIO_ST_TMOUT) &&
-	    (ap->pio_task_state != PIO_ST_ERR))
+	    (ap->pio_task_state != PIO_ST_ERR)) {
 		schedule_task(&ap->pio_task);
+	}
 }
 
 /**
@@ -3596,7 +3597,7 @@
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_detect);
 EXPORT_SYMBOL_GPL(ata_add_to_probe_list);
-EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(libata_msleep);
+EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-08-31 03:05:50 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-08-31 03:05:50 -04:00
@@ -46,8 +46,8 @@
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
  *	@disk: SCSI device for which BIOS geometry is to be determined
- *	@dev: device major/minor
- *	@ip: location to which geometry will be output
+ *	@bdev: device major/minor
+ *	@geom: location to which geometry will be output
  *
  *	Generic bios head/sector/cylinder calculator
  *	used by sd. Most BIOSes nowadays expect a XXX/255/16  (CHS)
@@ -61,7 +61,7 @@
  *	Zero.
  */
 int ata_std_bios_param(Disk * disk,	/* SCSI disk */
-		       kdev_t dev,	/* Device major, minor */
+		       kdev_t bdev,	/* Device major, minor */
 		  int *geom /* Heads, sectors, cylinders in that order */ )
 {
 	geom[0] = 255;
@@ -95,7 +95,7 @@
 		return 0;
 
 	case ATA_IOC_SET_IO32:
-		val = (long) arg;
+		val = (unsigned long) arg;
 		if (val != 0)
 			return -EINVAL;
 		return 0;
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-08-31 03:05:50 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-08-31 03:05:50 -04:00
@@ -20,6 +20,10 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.03
+ *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
+ *       mmio_base, which is only set for the CK804/MCP04 case.
+ *
  *  0.02
  *     - Added support for CK804 SATA controller.
  *
@@ -40,7 +44,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.02"
+#define DRV_VERSION			"0.03"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -416,33 +420,33 @@
 	u8 intr_mask;
 
 	outb(NV_INT_STATUS_HOTPLUG,
-		(unsigned long)probe_ent->mmio_base + NV_INT_STATUS);
+		probe_ent->port[0].scr_addr + NV_INT_STATUS);
 
-	intr_mask = inb((unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+	intr_mask = inb(probe_ent->port[0].scr_addr + NV_INT_ENABLE);
 	intr_mask |= NV_INT_ENABLE_HOTPLUG;
 
-	outb(intr_mask, (unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+	outb(intr_mask, probe_ent->port[0].scr_addr + NV_INT_ENABLE);
 }
 
 static void nv_disable_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_mask;
 
-	intr_mask = inb((unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+	intr_mask = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 
 	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
 
-	outb(intr_mask, (unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
 static void nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
-	intr_status = inb((unsigned long)host_set->mmio_base + NV_INT_STATUS);
+	intr_status = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
 
 	// Clear interrupt status.
-	outb(0xff, (unsigned long)host_set->mmio_base + NV_INT_STATUS);
+	outb(0xff, host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
 
 	if (intr_status & NV_INT_STATUS_HOTPLUG) {
 		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-08-31 03:05:50 -04:00
+++ b/include/linux/libata.h	2004-08-31 03:05:50 -04:00
@@ -157,6 +157,7 @@
 };
 
 /* forward declarations */
+struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
 struct ata_queued_cmd;
