From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata: implement standard reset component operations and ->probe_reset
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <1138089922407-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:8856 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030361AbWAXIFh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:37 -0500
Received: by zproxy.gmail.com with SMTP id n1so1283671nzf
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:36 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Implement SRST, COMRESET and standard postreset component operations
for ata_drive_probe_reset(), and use these three functions to
implement ata_std_probe_reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  206 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    6 +
 2 files changed, 212 insertions(+), 0 deletions(-)

254523d00d03d4948a7452b0cbf04af7cb11f4fe
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 48aa57e..f6511bd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2280,6 +2280,208 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
+/**
+ *	ata_std_softreset - reset host port via ATA SRST
+ *	@ap: port to reset
+ *	@verbose: fail verbosely
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset host port using ATA SRST.  This function is to be used
+ *	as standard callback for ata_drive_*_reset() functions.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_std_softreset(struct ata_port *ap, int verbose, unsigned int *classes)
+{
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	unsigned int devmask = 0, err_mask;
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
+	err_mask = ata_bus_softreset(ap, devmask);
+	if (err_mask) {
+		if (verbose)
+			printk(KERN_ERR "ata%u: SRST failed (err_mask=0x%x)\n",
+			       ap->id, err_mask);
+		else
+			DPRINTK("EXIT, softreset failed (err_mask=0x%x)\n",
+				err_mask);
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
+ *	sata_std_hardreset - reset host port via SATA phy reset
+ *	@ap: port to reset
+ *	@verbose: fail verbosely
+ *	@class: resulting class of attached device
+ *
+ *	SATA phy-reset host port using DET bits of SControl register.
+ *	This function is to be used as standard callback for
+ *	ata_drive_*_reset().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_std_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
+{
+	u32 sstatus, serror;
+	unsigned long timeout = jiffies + (HZ * 5);
+
+	DPRINTK("ENTER\n");
+
+	/* Issue phy wake/reset */
+	scr_write_flush(ap, SCR_CONTROL, 0x301);
+
+	/*
+	 * Couldn't find anything in SATA I/II specs, but AHCI-1.1
+	 * 10.4.2 says at least 1 ms.
+	 */
+	msleep(1);
+
+	scr_write_flush(ap, SCR_CONTROL, 0x300);
+
+	/* Wait for phy to become ready, if necessary. */
+	do {
+		msleep(200);
+		sstatus = scr_read(ap, SCR_STATUS);
+		if ((sstatus & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* Clear SError */
+	serror = scr_read(ap, SCR_ERROR);
+	scr_write(ap, SCR_ERROR, serror);
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (!sata_dev_present(ap)) {
+		*class = ATA_DEV_NONE;
+		DPRINTK("EXIT, link offline\n");
+		return 0;
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		if (verbose)
+			printk(KERN_ERR "ata%u: COMRESET failed "
+			       "(device not ready)\n", ap->id);
+		else
+			DPRINTK("EXIT, device not ready\n");
+		return -EIO;
+	}
+
+	*class = ata_dev_try_classify(ap, 0, NULL);
+
+	DPRINTK("EXIT, class=%u\n", *class);
+	return 0;
+}
+
+/**
+ *	ata_std_postreset - standard postreset callback
+ *	@ap: the target ata_port
+ *	@classes: classes of attached devices
+ *
+ *	This function is invoked after a successful reset.  Note that
+ *	the device might have been reset more than once using
+ *	different reset methods before postreset is invoked.
+ *	postreset is also reponsible for setting cable type.
+ *
+ *	This function is to be used as standard callback for
+ *	ata_drive_*_reset().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_std_postreset(struct ata_port *ap, unsigned int *classes)
+{
+	DPRINTK("ENTER\n");
+
+	/* set cable type */
+	if (ap->cbl == ATA_CBL_NONE && ap->flags & ATA_FLAG_SATA)
+		ap->cbl = ATA_CBL_SATA;
+
+	/* print link status */
+	if (ap->cbl == ATA_CBL_SATA)
+		sata_print_link_status(ap);
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
+ *	ata_std_probe_reset - standard probe reset method
+ *	@ap: prot to perform probe-reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	The stock off-the-shelf ->probe_reset method.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_std_probe_reset(struct ata_port *ap, unsigned int *classes)
+{
+	ata_reset_fn_t hardreset;
+
+	hardreset = NULL;
+	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read)
+		hardreset = sata_std_hardreset;
+
+	return ata_drive_probe_reset(ap, ata_std_softreset, hardreset,
+				     ata_std_postreset, classes);
+}
+
 static int do_probe_reset(struct ata_port *ap, ata_reset_fn_t reset,
 			  ata_postreset_fn_t postreset,
 			  unsigned int *classes)
@@ -5308,6 +5510,10 @@ EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(ata_std_softreset);
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
+EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(ata_std_probe_reset);
 EXPORT_SYMBOL_GPL(ata_drive_probe_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d7392e..f4cd1eb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -486,6 +486,11 @@ extern void ata_bus_reset(struct ata_por
 extern int ata_drive_probe_reset(struct ata_port *ap,
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset, unsigned int *classes);
+extern int ata_std_softreset(struct ata_port *ap, int verbose,
+			     unsigned int *classes);
+extern int sata_std_hardreset(struct ata_port *ap, int verbose,
+			      unsigned int *class);
+extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
@@ -526,6 +531,7 @@ extern void ata_std_dev_select (struct a
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
+extern int ata_std_probe_reset(struct ata_port *ap, unsigned int *classes);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern void ata_host_stop (struct ata_host_set *host_set);
-- 
1.1.3


