From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata: implement standard reset methods
Date: Sun, 18 Dec 2005 22:40:30 +0900
Message-ID: <20051218134030.GD31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:18833 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932706AbVLRNkf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:40:35 -0500
Received: by zproxy.gmail.com with SMTP id 14so1715080nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:40:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Implement ata_std_softreset_srst, ata_std_softreset_edd,
ata_std_hardreset_sata and ata_std_postreset.  These routines are to
new reset mechanism what sata_phy_reset and ata_bus_reset are to
->phy_reset mechanism.  Most low level drivers should be able to use
these directly or with some wrapping.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-18 20:49:54.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-18 20:50:33.000000000 +0900
@@ -2152,6 +2152,216 @@ err_out:
 }
 
 /**
+ *	ata_std_softreset_srst - reset host port via ATA SRST
+ *	@ap: port to reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset host port using ATA SRST.
+ */
+int ata_std_softreset_srst(struct ata_port *ap, unsigned int *classes)
+{
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	unsigned int devmask = 0;
+	u8 err;
+
+	DPRINTK("ENTER\n");
+
+	/* determine if device 0/1 are present */
+	if (ata_devchk(ap, 0))
+		devmask |= (1 << 0);
+	if (slave_possible && ata_devchk(ap, 1))
+		devmask |= (1 << 1);
+
+	/* devchk reports device presence without actual device on
+	 * most SATA controllers.  Check SStatus and turn devmask off
+	 * if link is offline.  Note that we should continue resetting
+	 * even when it seems like there's no device.
+	 */
+	if (ap->ops->scr_read && !sata_dev_present(ap))
+		devmask = 0;
+
+	/* select device 0 again */
+	ap->ops->dev_select(ap, 0);
+
+	/* issue bus reset */
+	DPRINTK("about to softreset, devmask=%x\n", devmask);
+	if (ata_bus_softreset(ap, devmask)) {
+		DPRINTK("EXIT, softreset failed\n");
+		return -EIO;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_dev_try_classify(ap, 0, &err);
+	if (slave_possible && err != 0x81)
+		classes[1] = ata_dev_try_classify(ap, 1, &err);
+
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+/**
+ *	ata_std_softreset_edd - perform EDD and classify devices
+ *	@ap: port to perform EDD on
+ *	@classes: resulting classes of attached devices
+ *
+ *	This isn't really a softreset method.  It just performs EDD
+ *	and classify devices.  If a controller doesn't support SRST
+ *	and hardreset cannot classify, this function can be used as
+ *	softreset method for classification.
+ */
+int ata_std_softreset_edd(struct ata_port *ap, unsigned int *classes)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	u8 err;
+
+	DPRINTK("ENTER\n");
+
+	/* select device 0 */
+	ap->ops->dev_select(ap, 0);
+
+	/* set up device control */
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
+
+	if (ata_bus_edd(ap)) {
+		DPRINTK("EXIT, edd failed\n");
+		return -EIO;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_dev_try_classify(ap, 0, &err);
+	if (slave_possible && err != 0x81)
+		classes[1] = ata_dev_try_classify(ap, 1, &err);
+
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+/**
+ *	ata_std_hardreset_sata - reset host port via SATA phy reset
+ *	@ap: port to reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	SATA phy-reset host port using DET bits of SControl register.
+ */
+int ata_std_hardreset_sata(struct ata_port *ap, unsigned int *classes)
+{
+	u32 sstatus;
+	unsigned long timeout = jiffies + (HZ * 5);
+
+	DPRINTK("ENTER\n");
+
+	/* issue phy wake/reset */
+	scr_write_flush(ap, SCR_CONTROL, 0x301);
+
+	/* Couldn't find anything in SATA I/II specs, but
+	 * AHCI-1.1 10.4.2 says at least 1 ms.
+	 */
+	msleep(1);
+
+	scr_write_flush(ap, SCR_CONTROL, 0x300);
+
+	/* wait for phy to become ready, if necessary */
+	do {
+		msleep(200);
+		sstatus = scr_read(ap, SCR_STATUS);
+		if ((sstatus & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (!sata_dev_present(ap)) {
+		classes[0] = ATA_DEV_NONE;
+		DPRINTK("EXIT, link offline\n");
+		return 0;
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		DPRINTK("EXIT, device not ready\n");
+		return -EIO;
+	}
+
+	classes[0] = ata_dev_try_classify(ap, 0, NULL);
+
+	DPRINTK("EXIT, class=%u\n", classes[0]);
+	return 0;
+}
+
+static void ata_sata_print_link_status(struct ata_port *ap)
+{
+	u32 sstatus, tmp;
+	const char *speed;
+
+	if (!ap->ops->scr_read)
+		return;
+
+	sstatus = scr_read(ap, SCR_STATUS);
+
+	if (sata_dev_present(ap)) {
+		tmp = (sstatus >> 4) & 0xf;
+		if (tmp & (1 << 0))
+			speed = "1.5";
+		else if (tmp & (1 << 1))
+			speed = "3.0";
+		else
+			speed = "<unknown>";
+		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
+		       ap->id, speed, sstatus);
+	} else {
+		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
+		       ap->id, sstatus);
+	}
+}
+
+/**
+ *	ata_std_postreset - standard postreset method
+ *	@ap: the target ata_port
+ *	@classes: classes of attached devices
+ *
+ *	post_reset method is invoked after a successful reset.  Note
+ *	that the device might have been reset more than once using
+ *	different reset methods before post_reset is invoked.
+ *	post_reset is reponsible for setting cable type.
+ *
+ *	ata_std_postreset() is the standard post_reset method.  It
+ *	sets cable type according to ATA_FLAG_SATA and performs other
+ *	standard choirs.
+ */
+void ata_std_postreset(struct ata_port *ap, const unsigned int *classes)
+{
+	DPRINTK("ENTER\n");
+
+	/* set cable type */
+	if (ap->cbl == ATA_CBL_NONE && ap->flags & ATA_FLAG_SATA)
+		ap->cbl = ATA_CBL_SATA;
+
+	/* print link status */
+	if (ap->cbl == ATA_CBL_SATA)
+		ata_sata_print_link_status(ap);
+
+	/* bail out if no device is present */
+	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
+		DPRINTK("EXIT, no device\n");
+		return;
+	}
+
+	/* is double-select really necessary? */
+	if (classes[0] != ATA_DEV_NONE)
+		ap->ops->dev_select(ap, 1);
+	if (classes[1] != ATA_DEV_NONE)
+		ap->ops->dev_select(ap, 0);
+
+	/* re-enable interrupts & set up device control */
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
+
+	DPRINTK("EXIT\n");
+}
+
+/**
  *	ata_reset - reset host port and associated ATA channel
  *	@ap: port to reset
  *	@flags: ATA_RESET_* flags
@@ -5093,6 +5303,10 @@ EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
+EXPORT_SYMBOL_GPL(ata_std_hardreset_sata);
+EXPORT_SYMBOL_GPL(ata_std_softreset_srst);
+EXPORT_SYMBOL_GPL(ata_std_softreset_edd);
+EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_host_stop);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-12-18 20:49:54.000000000 +0900
+++ work/include/linux/libata.h	2005-12-18 20:50:33.000000000 +0900
@@ -470,6 +470,10 @@ extern void ata_std_dev_select (struct a
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
+extern int ata_std_softreset_srst(struct ata_port *ap, unsigned int *classes);
+extern int ata_std_softreset_edd(struct ata_port *ap, unsigned int *classes);
+extern int ata_std_hardreset_sata(struct ata_port *ap, unsigned int *classes);
+extern void ata_std_postreset(struct ata_port *ap, const unsigned int *classes);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern void ata_host_stop (struct ata_host_set *host_set);
