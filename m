From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/10] libata-pm: implement Port Multiplier support
Date: Fri, 12 May 2006 01:43:42 +0900
Message-ID: <11473658222205-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:21914 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030343AbWEKQnu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:50 -0400
Received: by wr-out-0506.google.com with SMTP id i12so408534wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:49 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement Port Multiplier support.  To support PM, a LLDD has to
supply ops->pm_read() and pm_write().  If non-null, pm_attach() and
pm_detach() are called on PM attach and detach, respectively.

pm_read/write() can be called while the port is frozen, so they must
be implemented by polling.  This patch supplies several helpers to
ease pm_read/write() implementation.

Also, irq_handler() and error_handler() must be PM aware.  Most part
of PM EH can be done by calling ata_pm_do_eh() with appropriate
methods.  PM EH uses separate set of reset methods and this patch
implements standard prereset, hardreset and postreset methods.

This patch only implements PM support.  The next patch will integrate
PM into the rest of libata and enable it.

---

 drivers/scsi/Makefile      |    3 
 drivers/scsi/libata-core.c |    8 
 drivers/scsi/libata-pm.c   |  994 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    6 
 include/linux/libata.h     |   18 +
 5 files changed, 1028 insertions(+), 1 deletions(-)
 create mode 100644 drivers/scsi/libata-pm.c

4b9ab70e0d3c56ce962ade99cd94b2a82f4b1e25
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 669ff6b..0f5592f 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -164,7 +164,8 @@ ncr53c8xx-flags-$(CONFIG_SCSI_ZALON) \
 CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-y) $(ncr53c8xx-flags-m)
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
-libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o
+libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o \
+		   libata-pm.o
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 148d84d..133a6e6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5949,6 +5949,14 @@ EXPORT_SYMBOL_GPL(ata_device_resume);
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
+EXPORT_SYMBOL_GPL(ata_pm_read_init_tf);
+EXPORT_SYMBOL_GPL(ata_pm_read_val);
+EXPORT_SYMBOL_GPL(ata_pm_write_init_tf);
+EXPORT_SYMBOL_GPL(ata_pm_std_prereset);
+EXPORT_SYMBOL_GPL(ata_pm_std_hardreset);
+EXPORT_SYMBOL_GPL(ata_pm_std_postreset);
+EXPORT_SYMBOL_GPL(ata_pm_do_eh);
+
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_link_abort);
diff --git a/drivers/scsi/libata-pm.c b/drivers/scsi/libata-pm.c
new file mode 100644
index 0000000..002d8b2
--- /dev/null
+++ b/drivers/scsi/libata-pm.c
@@ -0,0 +1,994 @@
+/*
+ *  libata-pm.c - libata port multiplier support
+ *
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
+ *
+ *  Copyright 2006 Tejun Heo <htejun@gmail.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ *  USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available from http://www.t13.org/ and
+ *  http://www.sata-io.org/
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+
+#include <linux/libata.h>
+
+#include "libata.h"
+
+/**
+ *	ata_pm_read_init_tf - initialize TF for PM read
+ *	@tf: taskfile to initialize
+ *	@dev: PM dev
+ *	@pmp: port multiplier port number
+ *	@reg: register to read
+ *
+ *	Initialize @tf for PM read command.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_pm_read_init_tf(struct ata_taskfile *tf,
+			 struct ata_device *dev, int pmp, int reg)
+{
+	ata_tf_init(dev, tf);
+	tf->command = ATA_CMD_PM_READ;
+	tf->protocol = ATA_PROT_NODATA;
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->feature = reg;
+	tf->device = pmp;
+}
+
+/**
+ *	ata_pm_read_val - extract PM read result from TF
+ *	@tf: target TF
+ *
+ *	Determine PM read result from @tf.
+ *
+ *	LOCKING:
+ *	None.
+ */
+u32 ata_pm_read_val(const struct ata_taskfile *tf)
+{
+	return tf->nsect | tf->lbal << 8 | tf->lbam << 16 | tf->lbah << 24;
+}
+
+/**
+ *	ata_pm_read_init_tf - initialize TF for PM write
+ *	@tf: taskfile to initialize
+ *	@dev: PM dev
+ *	@pmp: port multiplier port number
+ *	@reg: register to read
+ *	@val: value to write
+ *
+ *	Initialize @tf for PM write command.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_pm_write_init_tf(struct ata_taskfile *tf,
+			  struct ata_device *dev, int pmp, int reg, u32 val)
+{
+	ata_tf_init(dev, tf);
+	tf->command = ATA_CMD_PM_WRITE;
+	tf->protocol = ATA_PROT_NODATA;
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->feature = reg;
+	tf->device = pmp;
+	tf->nsect = val & 0xff;
+	tf->lbal = (val >> 8) & 0xff;
+	tf->lbam = (val >> 16) & 0xff;
+	tf->lbah = (val >> 24) & 0xff;
+}
+
+/**
+ *	ata_pm_scr_read - read PSCR
+ *	@link: ATA link to read PSCR for
+ *	@reg: PSCR to read
+ *	@r_val: resulting value
+ *
+ *	Read PSCR @reg into @r_val for @link, to be called from
+ *	ata_scr_read().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_pm_scr_read(struct ata_link *link, int reg, u32 *r_val)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_device *pm_dev = ap->link.device;
+
+	might_sleep();
+
+	if (reg > ATA_PM_PSCR_CONTROL)
+		return -EINVAL;
+
+	return ap->ops->pm_read(pm_dev, link->pmp, reg, r_val);
+}
+
+/**
+ *	ata_pm_scr_write - write PSCR
+ *	@link: ATA link to write PSCR for
+ *	@reg: PSCR to write
+ *	@val: value to be written
+ *
+ *	Write @val to PSCR @reg for @link, to be called from
+ *	ata_scr_write() and ata_scr_write_flush().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_pm_scr_write(struct ata_link *link, int reg, u32 val)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_device *pm_dev = ap->link.device;
+
+	might_sleep();
+
+	if (reg > ATA_PM_PSCR_CONTROL)
+		return -EINVAL;
+
+	return ap->ops->pm_write(pm_dev, link->pmp, reg, val);
+}
+
+/**
+ *	ata_pm_std_prereset - prepare PM link for reset
+ *	@link: link to be reset
+ *
+ *	@link is about to be reset.  Initialize it.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pm_std_prereset(struct ata_link *link)
+{
+	int rc;
+
+	/* if we're about to do hardreset, don't bother */
+	if (link->eh_context.i.action & ATA_EH_HARDRESET)
+		return 0;
+
+	/* resume link */
+	rc = sata_link_resume(link, 1);
+	if (rc) {
+		/* phy resume failed */
+		ata_link_printk(link, KERN_WARNING, "failed to resume link "
+				"for reset (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* clear SError bits including .X which blocks the port when set */
+	rc = ata_scr_write(link, SCR_ERROR, 0xffffffff);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"failed to clear SError (errno=%d)\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_pm_std_hardreset - standard hardreset method for PM link
+ *	@link: link to be reset
+ *
+ *	Hardreset PM port @link.  Note that this function doesn't wait
+ *	for BSY clearance.  There simply isn't a generic way to wait
+ *	the event.  Instead, this function return -EAGAIN thus telling
+ *	libata-EH to followup with softreset.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pm_std_hardreset(struct ata_link *link, unsigned int *class)
+{
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* reset */
+	rc = sata_link_hardreset(link);
+	if (rc)
+		goto out;
+
+	/* clear SError bits including .X which blocks the port when set */
+	rc = ata_scr_write(link, SCR_ERROR, 0xffffffff);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR, "failed to clear SError "
+				"during hardreset (errno=%d)\n", rc);
+		goto out;
+	}
+
+	/* follow up with softreset so that we can wait for !BSY */
+	rc = -EAGAIN;
+ out:
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+
+/**
+ *	ata_std_postreset - standard postreset method for PM link
+ *	@link: the target ata_link
+ *	@classes: classes of attached devices
+ *
+ *	This function is invoked after a successful reset.  Note that
+ *	the device might have been reset more than once using
+ *	different reset methods before postreset is invoked.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_pm_std_postreset(struct ata_link *link, unsigned int *class)
+{
+	u32 serror;
+
+	DPRINTK("ENTER\n");
+
+	/* clear SError */
+	if (ata_scr_read(link, SCR_ERROR, &serror) == 0)
+		ata_scr_write(link, SCR_ERROR, serror);
+
+	/* print link status */
+	sata_print_link_status(link);
+
+	DPRINTK("EXIT\n");
+}
+
+/**
+ *	ata_pm_read_gscr - read GSCR block of SATA PM
+ *	@dev: PM device
+ *	@gscr: buffer to read GSCR block into
+ *
+ *	Read selected PM GSCRs from the PM at @dev.  This will serve
+ *	as configuration and identification info for the PM.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int ata_pm_read_gscr(struct ata_device *dev, u32 *gscr)
+{
+	static const int gscr_to_read[] = { 0, 1, 2, 32, 33, 64, 96 };
+	struct ata_port *ap = dev->link->ap;
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(gscr_to_read); i++) {
+		int reg = gscr_to_read[i];
+
+		rc = ap->ops->pm_read(dev, ATA_PM_CTRL_PORT, reg, &gscr[reg]);
+		if (rc) {
+			ata_dev_printk(dev, KERN_ERR, "failed to read "
+				       "PM GSCR[%d] (errno=%d)\n", reg, rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static const char *ata_pm_spec_rev_str(const u32 *gscr)
+{
+	u32 rev = gscr[ATA_PM_GSCR_REV];
+
+	if (rev & (1 << 2))
+		return "1.1";
+	if (rev & (1 << 1))
+		return "1.0";
+	return "<unknown>";
+}
+
+static void ata_pm_quirks(u32 *gscr, int *nr_ports, unsigned int *link_flags)
+{
+	u16 vendor = ata_pm_gscr_vendor(gscr);
+	u16 devid = ata_pm_gscr_devid(gscr);
+
+	/* Sil4726 reports two extra ports for configuration and
+	 * enclosure processor, both of which are ignored ATM.  Also,
+	 * it requires hardreset to resume PM links.
+	 */
+	if (vendor == 0x1095 && devid == 0x4726) {
+		*nr_ports -= 2;
+		*link_flags |= ATA_LFLAG_HRST_TO_RESUME;
+	}
+}
+
+static int ata_pm_configure(struct ata_device *dev, int *r_nr_ports,
+			    unsigned int *r_link_flags, int print_info)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	u32 *gscr = dev->gscr;
+	unsigned int link_flags;
+	const char *reason;
+	int nr_ports, rc;
+
+	nr_ports = ata_pm_gscr_ports(gscr);
+	link_flags = 0;
+
+	ata_pm_quirks(gscr, &nr_ports, &link_flags);
+
+	if (nr_ports <= 0 || nr_ports > ATA_PM_MAX_PORTS) {
+		rc = -EINVAL;
+		reason = "invalid nr_ports";
+		goto fail;
+	}
+
+	rc = ap->ops->pm_write(dev, link->pmp, ATA_PM_GSCR_ERROR_EN,
+			       SERR_PHYRDY_CHG | SERR_DEV_XCHG);
+	if (rc) {
+		reason = "failed to write GSCR_ERROR_EN";
+		goto fail;
+	}
+
+	if (ap->flags & ATA_FLAG_SDB_NOTIFY &&
+	    gscr[ATA_PM_GSCR_FEAT] & ATA_PM_FEAT_NOTIFY) {
+		gscr[ATA_PM_GSCR_FEAT_EN] |= ATA_PM_FEAT_NOTIFY;
+
+		rc = ap->ops->pm_write(dev, link->pmp, ATA_PM_GSCR_FEAT_EN,
+				       gscr[ATA_PM_GSCR_FEAT_EN]);
+		if (rc) {
+			reason = "failed to write GSCR_FEAT_EN";
+			goto fail;
+		}
+	}
+
+	if (print_info)
+		ata_dev_printk(dev, KERN_INFO, "Port Multiplier %s, "
+			       "0x%04x:0x%04x r%d, %d ports, feat 0x%x/0x%x\n",
+			       ata_pm_spec_rev_str(gscr),
+			       ata_pm_gscr_vendor(gscr),
+			       ata_pm_gscr_devid(gscr), ata_pm_gscr_rev(gscr),
+			       nr_ports, gscr[ATA_PM_GSCR_FEAT_EN],
+			       gscr[ATA_PM_GSCR_FEAT]);
+
+	*r_nr_ports = nr_ports;
+	*r_link_flags = link_flags;
+	return 0;
+
+ fail:
+	ata_dev_printk(dev, KERN_ERR,
+		       "failed to configure Port Multiplier (%s)\n", reason);
+	return rc;
+}
+
+static int ata_pm_init_links(struct ata_port *ap, int nr_ports,
+			     unsigned int link_flags)
+{
+	struct ata_link *pm_link = ap->pm_link;
+	int i;
+
+	if (!pm_link) {
+		pm_link = kzalloc(sizeof(pm_link[0]) * ATA_PM_MAX_PORTS,
+				  GFP_NOIO);
+		if (!pm_link)
+			return -ENOMEM;
+
+		for (i = 0; i < ATA_PM_MAX_PORTS; i++)
+			ata_link_init(ap, &pm_link[i], i);
+
+		ap->pm_link = pm_link;
+	}
+
+	for (i = 0; i < nr_ports; i++) {
+		struct ata_link *link = &pm_link[i];
+		link->flags |= link_flags;
+		link->reset_tries = ATA_EH_PM_RESET_TRIES;
+		ata_link_init_probe(link);
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_pm_attach - attach a SATA PM device
+ *	@dev: SATA PM device to attach
+ *
+ *	Configure and attach SATA PM device @dev.  This function is
+ *	also responsible for allocating and initializing PM links.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_pm_attach(struct ata_device *dev)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	unsigned int link_flags;
+	unsigned long flags;
+	struct ata_link *tlink;
+	int nr_ports, rc;
+
+	/* is it haging off the right place? */
+	if (!(ap->flags & ATA_FLAG_PM)) {
+		ata_dev_printk(dev, KERN_ERR,
+			       "host does not support Port Multiplier\n");
+		return -EINVAL;
+	}
+
+	if (!ata_is_host_link(link)) {
+		ata_dev_printk(dev, KERN_ERR,
+			       "Port Multipliers cannot be nested\n");
+		return -EINVAL;
+	}
+
+	if (dev->devno) {
+		ata_dev_printk(dev, KERN_ERR,
+			       "Port Multiplier must be the first device\n");
+		return -EINVAL;
+	}
+
+	WARN_ON(link->pmp != 0);
+	link->pmp = ATA_PM_CTRL_PORT;
+
+	/* read GSCR block */
+	rc = ata_pm_read_gscr(dev, dev->gscr);
+	if (rc)
+		goto fail;
+
+	/* config PM */
+	rc = ata_pm_configure(dev, &nr_ports, &link_flags, 1);
+	if (rc)
+		goto fail;
+
+	rc = ata_pm_init_links(ap, nr_ports, link_flags);
+	if (rc) {
+		ata_dev_printk(dev, KERN_INFO,
+			       "failed to initialize PM links\n");
+		goto fail;
+	}
+
+	/* attach it */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	WARN_ON(ap->nr_pm_links);
+	ap->nr_pm_links = nr_ports;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (ap->ops->pm_attach)
+		ap->ops->pm_attach(ap);
+
+	ata_port_for_each_link(tlink, ap)
+		ata_link_init_sata_spd_limit(tlink);
+
+	return 0;
+
+ fail:
+	link->pmp = 0;
+	return rc;
+}
+
+/**
+ *	ata_pm_detach - detach a SATA PM device
+ *	@dev: SATA PM device to detach
+ *
+ *	Detach SATA PM device @dev.  This function is also responsible
+ *	for deconfiguring PM links.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_pm_detach(struct ata_device *dev)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	struct ata_link *tlink;
+	unsigned long flags;
+
+	ata_dev_printk(dev, KERN_INFO, "Port Multiplier detaching\n");
+
+	WARN_ON(!ata_is_host_link(link) || dev->devno ||
+		link->pmp != ATA_PM_CTRL_PORT);
+
+	if (ap->ops->pm_detach)
+		ap->ops->pm_detach(ap);
+
+	ata_port_for_each_link(tlink, ap)
+		ata_eh_detach_dev(tlink->device);
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->nr_pm_links = 0;
+	link->pmp = 0;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
+ *	ata_pm_same_pm - determine whether new GSCR matches the configured PM
+ *	@dev: PM device to compare against
+ *	@new_gscr: GSCR block of the new device
+ *
+ *	Compare @new_gscr against @dev and determine whether @dev is
+ *	the PM described by @new_gscr.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if @dev matches @new_gscr, 0 otherwise.
+ */
+static int ata_pm_same_pm(struct ata_device *dev, const u32 *new_gscr)
+{
+	const u32 *old_gscr = dev->gscr;
+	u16 old_vendor, new_vendor, old_devid, new_devid;
+	int old_nr_ports, new_nr_ports;
+
+	old_vendor = ata_pm_gscr_vendor(old_gscr);
+	new_vendor = ata_pm_gscr_vendor(new_gscr);
+	old_devid = ata_pm_gscr_devid(old_gscr);
+	new_devid = ata_pm_gscr_devid(new_gscr);
+	old_nr_ports = ata_pm_gscr_ports(old_gscr);
+	new_nr_ports = ata_pm_gscr_ports(new_gscr);
+
+	if (old_vendor != new_vendor) {
+		ata_dev_printk(dev, KERN_INFO, "Port Multiplier "
+			       "vendor mismatch '0x%x' != '0x%x'\n",
+			       old_vendor, new_vendor);
+		return 0;
+	}
+
+	if (old_devid != new_devid) {
+		ata_dev_printk(dev, KERN_INFO, "Port Multiplier "
+			       "device ID mismatch '0x%x' != '0x%x'\n",
+			       old_devid, new_devid);
+		return 0;
+	}
+
+	if (old_nr_ports != new_nr_ports) {
+		ata_dev_printk(dev, KERN_INFO, "Port Multiplier "
+			       "nr_ports mismatch '0x%x' != '0x%x'\n",
+			       old_nr_ports, new_nr_ports);
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ *	ata_pm_revalidate - revalidate SATA PM
+ *	@dev: PM device to revalidate
+ *	@new_class: new class code
+ *
+ *	Re-read GSCR block and make sure @dev is still attached to the
+ *	port and properly configured.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_pm_revalidate(struct ata_device *dev, unsigned int new_class)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	u32 *gscr = (void *)ap->sector_buf;
+	unsigned int link_flags;
+	int nr_ports, rc;
+
+	DPRINTK("ENTER\n");
+
+	ata_eh_about_to_do(link, ATA_EH_REVALIDATE);
+
+	if (!ata_dev_enabled(dev)) {
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	/* sometimes wrong class is reported, let it retry */
+	if (ata_class_enabled(new_class) && new_class != ATA_DEV_PM) {
+		rc = -EIO;
+		goto fail;
+	}
+
+	/* read GSCR */
+	rc = ata_pm_read_gscr(dev, gscr);
+	if (rc)
+		goto fail;
+
+	/* is the pm still there? */
+	if (!ata_pm_same_pm(dev, gscr)) {
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	memcpy(dev->gscr, gscr, sizeof(gscr[0]) * ATA_PM_GSCR_DWORDS);
+
+	rc = ata_pm_configure(dev, &nr_ports, &link_flags, 0);
+	if (rc)
+		goto fail;
+
+	if (nr_ports != ap->nr_pm_links) {
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	link->eh_context.i.action &= ~ATA_EH_REVALIDATE;
+
+	DPRINTK("EXIT, rc=0\n");
+	return 0;
+
+ fail:
+	ata_dev_printk(dev, KERN_ERR,
+		       "PM revalidation failed (errno=%d)\n", rc);
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+
+/**
+ *	ata_pm_revalidate_quick - revalidate SATA PM quickly
+ *	@dev: PM device to revalidate
+ *
+ *	Make sure the attached PM is accessible.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_pm_revalidate_quick(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	u32 prod_id;
+	int rc;
+
+	rc = ap->ops->pm_read(dev, ATA_PM_CTRL_PORT, ATA_PM_GSCR_PROD_ID,
+			      &prod_id);
+	if (rc) {
+		ata_dev_printk(dev, KERN_ERR, "failed to read PM product ID\n");
+		return rc;
+	}
+
+	if (prod_id != dev->gscr[ATA_PM_GSCR_PROD_ID]) {
+		ata_dev_printk(dev, KERN_ERR, "PM product ID mismatch\n");
+		/* something weird is going on, request full PM recovery */
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_pm_eh_recover_pm - recover PM
+ *	@ap: ATA port PM is attached to
+ *	@prereset: prereset method (can be NULL)
+ *	@softreset: softreset method
+ *	@hardreset: hardreset method
+ *	@postreset: postreset method (can be NULL)
+ *	@link_tries: link tries left
+ *
+ *	Recover PM attached to @ap.  Recovery procedure is somewhat
+ *	similar to that of ata_eh_recover() except that reset should
+ *	always be performed in hard->soft sequence and recovery
+ *	failure results in PM detachment.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int ata_pm_eh_recover_pm(struct ata_port *ap, ata_prereset_fn_t prereset,
+				ata_reset_fn_t softreset,
+				ata_reset_fn_t hardreset,
+				ata_postreset_fn_t postreset, int *link_tries)
+{
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev = link->device;
+	int tries = link->reset_tries;
+	int detach = 0, probe = 0, rc = 0;
+
+	DPRINTK("ENTER\n");
+
+	if (dev->flags & ATA_DFLAG_DETACH) {
+		detach = 1;
+		goto fail;
+	}
+
+ retry:
+	ehc->classes[0] = ATA_DEV_UNKNOWN;
+
+	if (ehc->i.action & ATA_EH_RESET_MASK) {
+		struct ata_link *tlink;
+
+		ata_eh_freeze_port(ap);
+
+		/* reset */
+		ehc->i.action = ATA_EH_HARDRESET;
+		rc = ata_eh_reset(link, 0, prereset, softreset, hardreset,
+				  postreset);
+		if (rc) {
+			ata_link_printk(link, KERN_ERR,
+					"failed to reset PM, giving up\n");
+			goto fail;
+		}
+
+		ata_eh_thaw_port(ap);
+
+		ata_port_for_each_link(tlink, ap) {
+			struct ata_eh_context *tehc = &tlink->eh_context;
+
+			if (link_tries[tlink->pmp])
+				tehc->i.action = ata_link_resume_action(tlink);
+			else
+				tehc->i.action = 0;
+		}
+	}
+
+	/* If revalidation is requested, revalidate and reconfigure;
+	 * otherwise, do quick revalidation.
+	 */
+	if (ehc->i.action & ATA_EH_REVALIDATE)
+		rc = ata_pm_revalidate(dev, ehc->classes[0]);
+	else
+		rc = ata_pm_revalidate_quick(dev);
+
+	if (rc == -ENODEV) {
+		probe = 1;
+		goto fail;
+	} else if (rc) {
+		if (--tries) {
+			int sleep = ehc->flags & ATA_EHC_DID_RESET;
+
+			ata_dev_printk(dev, KERN_WARNING,
+				       "retrying hardreset%s\n",
+				       sleep ? " in 5 secs" : "");
+			if (sleep)
+				ssleep(5);
+			ehc->i.action |= ATA_EH_HARDRESET;
+			goto retry;
+		} else {
+			ata_dev_printk(dev, KERN_ERR, "failed to recover PM "
+				       "after %d resets, giving up\n",
+				       link->reset_tries);
+			goto fail;
+		}
+	}
+
+	/* okay, PM resurrected */
+	ehc->flags &= ~ATA_EHC_DID_RESET;
+	ehc->i.action = 0;
+
+	DPRINTK("EXIT, rc=0\n");
+	return 0;
+
+ fail:
+	ata_pm_detach(dev);
+	if (probe || detach) {
+		ata_eh_detach_dev(dev);
+		if (probe)
+			ehc->i.probe_mask |= 1;
+	} else
+		ata_dev_disable(dev);
+
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+
+/**
+ *	ata_pm_eh_recover - recover PM-enabled port
+ *	@ap: ATA port to recover
+ *	@prereset: prereset method (can be NULL)
+ *	@softreset: softreset method
+ *	@hardreset: hardreset method
+ *	@postreset: postreset method (can be NULL)
+ *	@pm_prereset: PM prereset method (can be NULL)
+ *	@pm_softreset: PM softreset method (can be NULL)
+ *	@pm_hardreset: PM hardreset method (can be NULL)
+ *	@pm_postreset: PM postreset method (can be NULL)
+ *
+ *	Drive EH recovery operation for PM enable port @ap.  This
+ *	function recovers host and PM ports with proper retrials and
+ *	fallbacks.  Actual recovery operations are performed using
+ *	ata_eh_recover() and ata_pm_eh_recover_pm().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int ata_pm_eh_recover(struct ata_port *ap,
+		ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
+		ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
+		ata_prereset_fn_t pm_prereset, ata_reset_fn_t pm_softreset,
+		ata_reset_fn_t pm_hardreset, ata_postreset_fn_t pm_postreset)
+{
+	int pm_tries, link_tries[ATA_PM_MAX_PORTS];
+	struct ata_link *pm_link = &ap->link;
+	struct ata_device *pm_dev = pm_link->device;
+	struct ata_eh_info *pm_ehi = &pm_link->eh_context.i;
+	struct ata_link *link;
+	struct ata_device *dev;
+	u32 gscr_error;
+	int cnt, rc;
+
+	pm_tries = ATA_EH_PM_TRIES;
+	ata_port_for_each_link(link, ap)
+		link_tries[link->pmp] = ATA_EH_PM_LINK_TRIES;
+
+ retry:
+	/* PM attached? */
+	if (!ap->nr_pm_links) {
+		rc = ata_eh_recover(ap, prereset, softreset, hardreset,
+				    postreset, NULL);
+		if (rc) {
+			ata_link_for_each_dev(dev, &ap->link)
+				ata_dev_disable(dev);
+			return rc;
+		}
+
+		if (pm_dev->class != ATA_DEV_PM)
+			return 0;
+
+		/* new PM online */
+		ata_port_for_each_link(link, ap)
+			link_tries[link->pmp] = ATA_EH_PM_LINK_TRIES;
+
+		/* fall through */
+	}
+
+	/* recover pm */
+	rc = ata_pm_eh_recover_pm(ap, prereset, softreset, hardreset, postreset,
+				  link_tries);
+	if (rc)
+		goto pm_retry;
+
+	/* recover links */
+	rc = ata_eh_recover(ap, pm_prereset, pm_softreset, pm_hardreset,
+			    pm_postreset, &link);
+	if (rc)
+		goto link_retry;
+
+	/* Connection status might have changed while resetting other
+	 * links, check ATA_PM_GSCR_ERROR before returning.
+	 */
+
+	/* clear snotification */
+	ata_scr_write(pm_link, SCR_NOTIFICATION, (1 << ap->nr_pm_links) - 1);
+
+	/* check GSCR_ERROR */
+	rc = ap->ops->pm_read(pm_dev, pm_link->pmp, ATA_PM_GSCR_ERROR,
+			      &gscr_error);
+	if (rc) {
+		ata_dev_printk(pm_dev, KERN_ERR,
+			       "failed to read PM_GSCR_ERROR\n");
+		goto pm_retry;
+	}
+
+	cnt = 0;
+	ata_port_for_each_link(link, ap) {
+		struct ata_eh_info *ehi = &link->eh_context.i;
+
+		if (gscr_error & (1 << link->pmp) &&
+		    link_tries[link->pmp] && --link_tries[link->pmp]) {
+			ehi->probe_mask |= 1;
+			ehi->action = ata_link_resume_action(link);
+			cnt++;
+		}
+	}
+
+	if (cnt) {
+		ata_port_printk(ap, KERN_INFO, "PM SError.N/X set for some "
+				"ports, repeating recovery\n");
+		goto retry;
+	}
+
+	return 0;
+
+ link_retry:
+	if (link_tries[link->pmp] && --link_tries[link->pmp]) {
+		ata_link_printk(link, KERN_WARNING,
+				"failed to recover link, resetting PM\n");
+		pm_ehi->action |= ATA_EH_HARDRESET;
+		goto retry;
+	}
+
+	/* give up this link */
+	ata_link_printk(link, KERN_ERR,
+			"failed to recover link after %d tries, giving up\n",
+			ATA_EH_PM_LINK_TRIES);
+	ata_dev_disable(link->device);
+	link->eh_context.i.action = 0;
+
+	/* fall through */
+ pm_retry:
+	/* Control always ends up here after detaching PM.  Shut up
+	 * and return if we're unloading.
+	 */
+	if (ap->flags & ATA_FLAG_UNLOADING)
+		return rc;
+
+	if (!ap->nr_pm_links)
+		goto retry;
+
+	if (--pm_tries) {
+		ata_port_printk(ap, KERN_WARNING,
+				"failed to recover PM, retrying in 5 secs\n");
+		pm_ehi->action |= ATA_EH_HARDRESET;
+		ssleep(5);
+		goto retry;
+	}
+
+	ata_port_printk(ap, KERN_ERR,
+			"failed to recover PM after %d tries, giving up\n",
+			ATA_EH_PM_TRIES);
+	ata_pm_detach(pm_dev);
+
+	return rc;
+}
+
+/**
+ *	ata_pm_do_eh - do standard error handling for PM-enabled host
+ *	@ap: host port to handle error for
+ *	@prereset: prereset method (can be NULL)
+ *	@softreset: softreset method
+ *	@hardreset: hardreset method
+ *	@postreset: postreset method (can be NULL)
+ *	@pm_prereset: PM prereset method (can be NULL)
+ *	@pm_softreset: PM softreset method (can be NULL)
+ *	@pm_hardreset: PM hardreset method (can be NULL)
+ *	@pm_postreset: PM postreset method (can be NULL)
+ *
+ *	Perform standard error handling sequence for PM-enabled host
+ *	@ap.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_pm_do_eh(struct ata_port *ap,
+		  ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
+		  ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
+		  ata_prereset_fn_t pm_prereset, ata_reset_fn_t pm_softreset,
+		  ata_reset_fn_t pm_hardreset, ata_postreset_fn_t pm_postreset)
+{
+	if (!(ap->flags & (ATA_FLAG_LOADING | ATA_FLAG_UNLOADING))) {
+		ata_eh_autopsy(ap);
+		ata_eh_report(ap);
+	}
+
+	ata_pm_eh_recover(ap, prereset, softreset, hardreset, postreset,
+			  pm_prereset, pm_softreset, pm_hardreset,
+			  pm_postreset);
+
+	ata_eh_finish(ap);
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 0f3cefe..7210c87 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -110,6 +110,12 @@ extern void ata_scsi_rbuf_fill(struct at
                                            u8 *rbuf, unsigned int buflen));
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 
+/* libata-pm.c */
+extern int ata_pm_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int ata_pm_scr_write(struct ata_link *link, int reg, u32 val);
+extern int ata_pm_attach(struct ata_device *dev);
+extern void ata_pm_detach(struct ata_device *dev);
+
 /* libata-eh.c */
 extern void ata_ering_init(struct ata_ering *ering, int size);
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c25d8d2..5772797 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -809,6 +809,24 @@ extern unsigned long ata_pci_default_fil
 #endif /* CONFIG_PCI */
 
 /*
+ * PM
+ */
+extern void ata_pm_read_init_tf(struct ata_taskfile *tf,
+				struct ata_device *dev, int pmp, int reg);
+extern u32 ata_pm_read_val(const struct ata_taskfile *tf);
+extern void ata_pm_write_init_tf(struct ata_taskfile *tf,
+				 struct ata_device *dev,
+				 int pmp, int reg, u32 val);
+extern int ata_pm_std_prereset(struct ata_link *link);
+extern int ata_pm_std_hardreset(struct ata_link *link, unsigned int *class);
+extern void ata_pm_std_postreset(struct ata_link *link, unsigned int *class);
+extern void ata_pm_do_eh(struct ata_port *ap,
+		ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
+		ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
+		ata_prereset_fn_t pm_prereset, ata_reset_fn_t pm_softreset,
+		ata_reset_fn_t pm_hardreset, ata_postreset_fn_t pm_postreset);
+
+/*
  * EH
  */
 extern void ata_eng_timeout(struct ata_port *ap);
-- 
1.2.4


