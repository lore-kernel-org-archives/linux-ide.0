From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
Date: Tue, 14 Mar 2017 18:50:43 +0100
Message-ID: <3458240.9SL7iGif3L@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48739 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdCNRuv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2017 13:50:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>, Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Sekhar Nori <nsekhar@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com


Add EBSA110's PCMCIA slot support.

Cc: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Cross compile tested only.

 drivers/ata/pata_pcmcia.c |  297 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 294 insertions(+), 3 deletions(-)

Index: b/drivers/ata/pata_pcmcia.c
===================================================================
--- a/drivers/ata/pata_pcmcia.c	2017-03-14 18:32:21.667263033 +0100
+++ b/drivers/ata/pata_pcmcia.c	2017-03-14 18:41:48.995277320 +0100
@@ -164,6 +164,286 @@ static struct ata_port_operations pcmcia
 	.sff_drain_fifo	= pcmcia_8bit_drain_fifo,
 };
 
+#ifdef CONFIG_ARCH_EBSA110
+static void pmcmia_ebsa110_dev_select(struct ata_port *ap, unsigned int device)
+{
+	u8 tmp;
+
+	if (device == 0)
+		tmp = ATA_DEVICE_OBS;
+	else
+		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+
+	__outb16(tmp, (unsigned long)ap->ioaddr.device_addr);
+	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
+}
+
+static void pcmcia_ebsa110_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	__outb16(ctl, (unsigned long)ap->ioaddr.ctl_addr);
+}
+
+static u8 pcmcia_ebsa110_check_status(struct ata_port *ap)
+{
+	return __inb16((unsigned long)ap->ioaddr.status_addr);
+}
+
+static u8 pcmcia_ebsa110_check_altstatus(struct ata_port *ap)
+{
+	return __inb16((unsigned long)ap->ioaddr.altstatus_addr);
+}
+
+static void pcmcia_ebsa110_tf_load(struct ata_port *ap,
+				   const struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl != ap->last_ctl) {
+		if (ioaddr->ctl_addr)
+			__outb16(tf->ctl, (unsigned long)ioaddr->ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		WARN_ON_ONCE(!ioaddr->ctl_addr);
+		__outb16(tf->hob_feature, (unsigned long)ioaddr->feature_addr);
+		__outb16(tf->hob_nsect, (unsigned long)ioaddr->nsect_addr);
+		__outb16(tf->hob_lbal, (unsigned long)ioaddr->lbal_addr);
+		__outb16(tf->hob_lbam, (unsigned long)ioaddr->lbam_addr);
+		__outb16(tf->hob_lbah, (unsigned long)ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		__outb16(tf->feature, (unsigned long)ioaddr->feature_addr);
+		__outb16(tf->nsect, (unsigned long)ioaddr->nsect_addr);
+		__outb16(tf->lbal, (unsigned long)ioaddr->lbal_addr);
+		__outb16(tf->lbam, (unsigned long)ioaddr->lbam_addr);
+		__outb16(tf->lbah, (unsigned long)ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		__outb16(tf->device, (unsigned long)ioaddr->device_addr);
+		VPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ap);
+}
+
+static void pcmcia_ebsa110_tf_read(struct ata_port *ap,
+				   struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	tf->command = ata_sff_check_status(ap);
+	tf->feature = __inb16((unsigned long)ioaddr->error_addr);
+	tf->nsect = __inb16((unsigned long)ioaddr->nsect_addr);
+	tf->lbal = __inb16((unsigned long)ioaddr->lbal_addr);
+	tf->lbam = __inb16((unsigned long)ioaddr->lbam_addr);
+	tf->lbah = __inb16((unsigned long)ioaddr->lbah_addr);
+	tf->device = __inb16((unsigned long)ioaddr->device_addr);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		if (likely(ioaddr->ctl_addr)) {
+			__outb16(tf->ctl | ATA_HOB, (unsigned long)ioaddr->ctl_addr);
+			tf->hob_feature = __inb16((unsigned long)ioaddr->error_addr);
+			tf->hob_nsect = __inb16((unsigned long)ioaddr->nsect_addr);
+			tf->hob_lbal = __inb16((unsigned long)ioaddr->lbal_addr);
+			tf->hob_lbam = __inb16((unsigned long)ioaddr->lbam_addr);
+			tf->hob_lbah = __inb16((unsigned long)ioaddr->lbah_addr);
+			__outb16(tf->ctl, (unsigned long)ioaddr->ctl_addr);
+			ap->last_ctl = tf->ctl;
+		} else
+			WARN_ON_ONCE(1);
+	}
+}
+
+static void pcmcia_ebsa110_exec_command(struct ata_port *ap,
+					 const struct ata_taskfile *tf)
+{
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
+
+	__outb16(tf->command, (unsigned long)ap->ioaddr.command_addr);
+	ata_sff_pause(ap);
+}
+
+static unsigned int pata_pcmcia_ebsa110_devchk(struct ata_port *ap,
+					      unsigned int device)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 nsect, lbal;
+
+	ap->ops->sff_dev_select(ap, device);
+
+	__outb16(0x55, (unsigned long)ioaddr->nsect_addr);
+	__outb16(0xaa, (unsigned long)ioaddr->lbal_addr);
+
+	__outb16(0xaa, (unsigned long)ioaddr->nsect_addr);
+	__outb16(0x55, (unsigned long)ioaddr->lbal_addr);
+
+	__outb16(0x55, (unsigned long)ioaddr->nsect_addr);
+	__outb16(0xaa, (unsigned long)ioaddr->lbal_addr);
+
+	nsect = __inb16((unsigned long)ioaddr->nsect_addr);
+	lbal = __inb16((unsigned long)ioaddr->lbal_addr);
+
+	if ((nsect == 0x55) && (lbal == 0xaa))
+		return 1;	/* we found a device */
+
+	return 0;		/* nothing found */
+}
+
+static int pata_pcmcia_ebsa110_wait_after_reset(struct ata_link *link,
+						unsigned int devmask,
+						unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int dev0 = devmask & (1 << 0);
+	unsigned int dev1 = devmask & (1 << 1);
+	int rc, ret = 0;
+
+	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
+
+	/* always check readiness of the master device */
+	rc = ata_sff_wait_ready(link, deadline);
+	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
+	 * and TF status is 0xff, bail out on it too.
+	 */
+	if (rc)
+		return rc;
+
+	/* if device 1 was found in ata_devchk, wait for register
+	 * access briefly, then wait for BSY to clear.
+	 */
+	if (dev1) {
+		int i;
+
+		ap->ops->sff_dev_select(ap, 1);
+
+		/* Wait for register access.  Some ATAPI devices fail
+		 * to set nsect/lbal after reset, so don't waste too
+		 * much time on it.  We're gonna wait for !BSY anyway.
+		 */
+		for (i = 0; i < 2; i++) {
+			u8 nsect, lbal;
+
+			nsect = __inb16((unsigned long)ioaddr->nsect_addr);
+			lbal = __inb16((unsigned long)ioaddr->lbal_addr);
+			if ((nsect == 1) && (lbal == 1))
+				break;
+			ata_msleep(ap, 50);	/* give drive a breather */
+		}
+
+		rc = ata_sff_wait_ready(link, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
+	}
+
+	/* is all this really necessary? */
+	ap->ops->sff_dev_select(ap, 0);
+	if (dev1)
+		ap->ops->sff_dev_select(ap, 1);
+	if (dev0)
+		ap->ops->sff_dev_select(ap, 0);
+
+	return ret;
+}
+
+static int pata_pcmcia_ebsa110_bus_softreset(struct ata_port *ap,
+					     unsigned int devmask,
+					     unsigned long deadline)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
+
+	/* software reset.  causes dev0 to be selected */
+	__outb16(ap->ctl, (unsigned long)ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	__outb16(ap->ctl | ATA_SRST, (unsigned long)ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	__outb16(ap->ctl, (unsigned long)ioaddr->ctl_addr);
+	ap->last_ctl = ap->ctl;
+
+	/* wait the port to become ready */
+	return pata_pcmcia_ebsa110_wait_after_reset(&ap->link, devmask,
+						    deadline);
+}
+
+static int pata_pcmcia_ebsa110_softreset(struct ata_link *link,
+					 unsigned int *classes,
+					 unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	unsigned int devmask = 0;
+	int rc;
+	u8 err;
+
+	DPRINTK("ENTER\n");
+
+	/* determine if device 0/1 are present */
+	if (pata_pcmcia_ebsa110_devchk(ap, 0))
+		devmask |= (1 << 0);
+	if (slave_possible && pata_pcmcia_ebsa110_devchk(ap, 1))
+		devmask |= (1 << 1);
+
+	/* select device 0 again */
+	ap->ops->sff_dev_select(ap, 0);
+
+	/* issue bus reset */
+	DPRINTK("about to softreset, devmask=%x\n", devmask);
+	rc = pata_pcmcia_ebsa110_bus_softreset(ap, devmask, deadline);
+	/* if link is occupied, -ENODEV too is an error */
+	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
+		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_sff_dev_classify(&link->device[0],
+					  devmask & (1 << 0), &err);
+	if (slave_possible && err != 0x81)
+		classes[1] = ata_sff_dev_classify(&link->device[1],
+						  devmask & (1 << 1), &err);
+
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+static struct ata_port_operations pcmcia_ebsa110_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+	.sff_dev_select		= pmcmia_ebsa110_dev_select,
+	.sff_set_devctl         = pcmcia_ebsa110_set_devctl,
+	.sff_check_status	= pcmcia_ebsa110_check_status,
+	.sff_check_altstatus    = pcmcia_ebsa110_check_altstatus,
+	.sff_tf_load		= pcmcia_ebsa110_tf_load,
+	.sff_tf_read		= pcmcia_ebsa110_tf_read,
+	.sff_exec_command	= pcmcia_ebsa110_exec_command,
+	.sff_data_xfer		= ata_sff_data_xfer_noirq,
+	.softreset		= pata_pcmcia_ebsa110_softreset,
+	.cable_detect		= ata_cable_40wire,
+	.set_mode		= pcmcia_set_mode,
+};
+#include <asm/mach-types.h>
+#endif
 
 static int pcmcia_check_one_config(struct pcmcia_device *pdev, void *priv_data)
 {
@@ -242,9 +522,20 @@ static int pcmcia_init_one(struct pcmcia
 		goto failed;
 
 	/* Success. Disable the IRQ nIEN line, do quirks */
-	iowrite8(0x02, ctl_addr);
-	if (is_kme)
-		iowrite8(0x81, ctl_addr + 0x01);
+#ifdef CONFIG_ARCH_EBSA110
+	if (machine_is_ebsa110()) {
+		ops = &pcmcia_ebsa110_port_ops;
+
+		__outb16(0x02, (unsigned long)ctl_addr);
+		if (is_kme)
+			__outb16(0x81, (unsigned long)ctl_addr + 0x01);
+	} else
+#endif
+	{
+		iowrite8(0x02, ctl_addr);
+		if (is_kme)
+			iowrite8(0x81, ctl_addr + 0x01);
+	}
 
 	/* FIXME: Could be more ports at base + 0x10 but we only deal with
 	   one right now */

