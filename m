From: Mark Lord <liml@rtr.ca>
Subject: Re: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Fri, 29 Jun 2007 11:04:05 -0400
Message-ID: <46851F65.5070400@rtr.ca>
References: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>	 <4683F340.2020905@rtr.ca> <cd98e0260706290439n475dc02cw552e47fdd953b575@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3423 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbXF2PD2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 11:03:28 -0400
In-Reply-To: <cd98e0260706290439n475dc02cw552e47fdd953b575@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johny Mail list <maillist.johny@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Johny Mail list wrote:
> 2007/6/28, Mark Lord <liml@rtr.ca>:
>> I have an ugly (but working) hack for the ICH5 ata_piix driver
>> to support hot insertion/removal of drives, but I don't know if/when
>> I'll be pushing it upstream.
>
> Yes it hang permanently there, after this messages i generally reboot
> the server.
> Yes it not support SATA drive hot insertion/removal, but i have make
> the same test on windows. I unplug one disk when i'm logged and the
> system don't stop. The drive is removed from the devices list.
> 
> If you can give me the patch for testing it... I would give you my
> returns about the good/bad functioning in my case.

Okay, Here is a working patch for a very specific variant of ICH5.
If your PCI IDs don't match what the patch is looking for,
then it should have no effect -- you may need to patch the patch
to contain the correct PCI IDs (from lspci -n).
* * *

Implement ICH5 chipset handling for drive hot insertion/removal.
This cannot go upstream, as it conflicts with a more generic
polled-hotplug framework that is currently in development.

Hot-inserted drives are automatically detected within a second or two,
and are ready-to-use within 30 seconds or so.  This could be even faster,
but the 2.6.18.8 libata implementation of error-handling is what slows
us down here.

Hot-removed drives are *not* noticed by the kernel until the next
time they are accessed.  If you want this to happen quickly,
then just launch a script like this from /etc/inittab at boot time:

   #!/bin/bash
   ( while ( /bin/true ) ; do /sbin/hdparm -C /dev/sd[a-z] ; sleep 5 ; done ) &>/dev/null &

This hack is not ready for mainline -- it's awaiting Tejun's hp-poll patches,
with which it will eventually be integrated.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/scsi/ata_piix.c linux/drivers/scsi/ata_piix.c
--- old/drivers/scsi/ata_piix.c	2007-04-20 14:08:46.000000000 -0400
+++ linux/drivers/scsi/ata_piix.c	2007-06-26 07:23:21.000000000 -0400
@@ -106,6 +106,8 @@
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
+	PIIX_HOTPLUG_POLL_TM	= (2 * (HZ)),	/* polling interval for hotplug */
+
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
 	 */
@@ -150,6 +152,171 @@
 	const struct piix_map_db *map_db;
 };
 
+struct piix_port_priv {
+	int pcs_hotplug_supported;
+	struct timer_list hotplug_timer;
+	u16 old_pcs;
+};
+
+static u32 ich_scr_read (struct ata_port *ap, unsigned int reg)
+{
+	u32 scr = 0;
+
+	if (reg == SCR_STATUS) {
+		struct piix_port_priv *pp = ap->private_data;
+		if (pp && pp->pcs_hotplug_supported) {
+			u16 pcs, port_bit = (1 << ap->hard_port_no);
+			struct pci_dev *pdev = to_pci_dev(ap->dev);
+
+			pci_read_config_word(pdev, ICH5_PCS, &pcs);
+			if (pcs & (port_bit << 4))
+				scr = 0x113;
+		}
+	}
+	return scr;
+}
+
+static int ich_port_offline (struct ata_port *ap)
+{
+	struct pci_dev *pdev;
+	u16 pcs, port_bit = (1 << ap->hard_port_no);
+	struct piix_port_priv *pp = ap->private_data;
+	u8 ostatus;
+	unsigned int offline;
+
+	if (!pp || !pp->pcs_hotplug_supported) {
+		u32 sstatus;
+		if (!sata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
+			return 1;
+		return 0;
+	}
+
+	/*
+	 * ICH5 with a mostly good/working PCS register.
+	 * The only flaw is, it doesn't seem to detect *removed* drives
+	 * unless we toggle the enable line before checking.
+	 */
+	ostatus = ata_altstatus(ap);
+	pdev = to_pci_dev(ap->dev);
+	pci_read_config_word(pdev, ICH5_PCS, &pcs);
+	offline = ((pcs & (port_bit << 4)) == 0);
+
+	if (!offline) {
+		unsigned int usecs;
+
+		/* Cycle PCS register to force it to redetect devices: */
+		pci_write_config_word(pdev, ICH5_PCS, pcs & ~port_bit);
+		udelay(1);
+		pci_write_config_word(pdev, ICH5_PCS, 0x0003);
+
+		/* Wait for SATA PHY to sync up; typically 5->6 usecs */
+		for (usecs = 0; usecs < 100; ++usecs) {
+			pci_read_config_word(pdev,  ICH5_PCS, &pcs);
+			offline = ((pcs & (port_bit << 4)) == 0);
+			if (!offline)
+				break;
+			udelay(1);
+		}
+		if (!offline) {
+			unsigned int msecs;
+			/* Wait for drive to become not-BUSY, typically 10->62 msecs */
+			for (msecs = 1; msecs < 150; msecs += 3) {
+				u8 status;
+				msleep(3);
+				status = ata_altstatus(ap);
+				if (status && !(status & ATA_BUSY))
+					break;
+			}
+			usecs += msecs * 1000;
+		}
+		printk("ata%u (port %u): status=%02x pcs=0x%04x offline=%u delay=%u usecs\n",
+			ap->id, ap->hard_port_no, ostatus, pcs, offline, usecs);
+	}
+	if (offline)
+		ata_port_disable(ap);
+	return offline;
+}
+
+static void pcs_hotplug_poll (unsigned long data)
+{
+	struct ata_port *ap = (void *)data;
+	struct pci_dev *pdev = to_pci_dev(ap->dev);
+	u16 old, new, port_bit = ((1 << ap->hard_port_no) << 4);
+	struct piix_port_priv *pp = ap->private_data;
+	int check_hotplug = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	if (!ap->qc_active) {
+		pci_read_config_word(pdev, ICH5_PCS, &new);
+		old = pp->old_pcs;
+		pp->old_pcs = new;
+
+		//printk("pcs_hotplug_poll(%d.%d) old=%04x new=%04x\n", ap->id, ap->hard_port_no, old, new);
+
+		if ((new & port_bit) != (old & port_bit)) {
+			check_hotplug = 1;
+		} else if (old & port_bit) {
+			//if (ap->hard_port_no == 1)	//FIXME FIXME FIXME
+			//	check_hotplug = 1;
+		}
+
+		if (check_hotplug) {
+			struct ata_eh_info *ehi = &ap->eh_info;
+
+			ata_port_printk(ap, KERN_INFO, "pcs_hotplug_poll: old=%04x new=%04x\n", old, new);
+			ata_ehi_clear_desc(ehi);
+			ata_ehi_hotplugged(ehi);
+			ata_ehi_push_desc(ehi, "hotplug event");
+			ata_port_freeze(ap);
+		}
+	}
+	if (pp->pcs_hotplug_supported)
+		mod_timer(&pp->hotplug_timer, jiffies + PIIX_HOTPLUG_POLL_TM);
+	spin_unlock_irqrestore(ap->lock, flags);
+}
+
+static int ich_port_start (struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->dev);
+	int rc;
+
+	rc = ata_port_start(ap);
+	if (rc == 0) {
+		if (pdev->vendor == 0x8086 && pdev->device == 0x24d1) {
+			struct piix_port_priv *pp;
+			pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+			if (pp) {
+				pp->pcs_hotplug_supported = 1;
+				if (ap->private_data)
+					printk(KERN_ERR "port_start: huh? private_data=%p instead of NULL\n", ap->private_data);
+				ap->private_data = pp;
+				setup_timer(&pp->hotplug_timer, pcs_hotplug_poll, (unsigned long)ap);
+				pp->hotplug_timer.expires = jiffies + PIIX_HOTPLUG_POLL_TM;
+				add_timer(&pp->hotplug_timer);
+			} else {
+				printk(KERN_ERR "ich_port_start: failed to alloc %d bytes for port_priv\n", sizeof(*pp));
+			}
+		}
+	} else {
+		printk(KERN_ERR "ich_port_start: ata_port_start failed, rc=%d\n", rc);
+	}
+	return rc;
+}
+
+static void ich_port_stop (struct ata_port *ap)
+{
+	struct piix_port_priv *pp = ap->private_data;
+
+	if (pp) {
+		pp->pcs_hotplug_supported = 0;
+		del_timer_sync(&pp->hotplug_timer);
+		ap->private_data = NULL;
+		kfree(pp);
+	}
+}
+
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 static void piix_host_stop(struct ata_host_set *host_set);
@@ -289,8 +456,11 @@
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
+	.scr_read		= ich_scr_read,
+
+	.port_offline		= ich_port_offline,
+	.port_start		= ich_port_start,
+	.port_stop		= ich_port_stop,
 	.host_stop		= piix_host_stop,
 };
 
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/scsi/libata-core.c linux/drivers/scsi/libata-core.c
--- old/drivers/scsi/libata-core.c	2007-04-20 14:08:45.000000000 -0400
+++ linux/drivers/scsi/libata-core.c	2007-06-26 07:22:19.000000000 -0400
@@ -4914,7 +4914,7 @@
  */
 int sata_scr_write(struct ata_port *ap, int reg, u32 val)
 {
-	if (sata_scr_valid(ap)) {
+	if (sata_scr_valid(ap) && ap->ops->scr_write) {
 		ap->ops->scr_write(ap, reg, val);
 		return 0;
 	}
@@ -4987,6 +4987,8 @@
 {
 	u32 sstatus;
 
+	if (ap->ops->port_offline)
+		return ap->ops->port_offline(ap);
 	if (!sata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
 		return 1;
 	return 0;
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/include/linux/libata.h linux/include/linux/libata.h
--- old/include/linux/libata.h	2007-06-26 07:22:26.000000000 -0400
+++ linux/include/linux/libata.h	2007-06-26 07:22:19.000000000 -0400
@@ -614,6 +614,7 @@
 
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
+	int (*port_offline) (struct ata_port *ap);
 
 	void (*host_stop) (struct ata_host_set *host_set);
 
