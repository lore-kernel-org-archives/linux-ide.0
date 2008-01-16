From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] libata: add enclosure management support
Date: Tue, 15 Jan 2008 16:44:17 -0800
Message-ID: <20080115164417.4a5e2789@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15833 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbYAPAtW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jan 2008 19:49:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Add Enclosure Management support to libata and ahci.

This patch adds support for the LED protocol, as defined in the AHCI spec.
It adds a generic em_message and em_type sysfs entry per host.  It also adds
a sw_activity field per existing drive.

The em_message field can be used by the driver to take enclosure management
commands from userspace.  In the case of the LED protocol, writes and reads
from em_message correspond to the LED message format as defined in the 
AHCI spec.

em_message type is a read only file that displays the current enclosure
management protocol that is used by the driver.

sw_activity is used by drivers which support software controlled activity LEDs.
It has the following valid values:

0	OFF - the LED is not activated on activity
1	BLINK_ON - the LED blinks on every 10ms when activity is detected.
2	BLINK_OFF - the LED is on when idle, and blinks off every 10ms when
		    activity is detected.

It's important to note that the user must turn sw_activity OFF it they wish
to control the activity LED via the em_message file.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
I'm concerned about my locking, cause I usually suck at figuring out when I
need it.  If you could review that really carefully, I'd appreciate it.
Thanks!

 drivers/ata/ahci.c        |  321 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-scsi.c |   77 +++++++++++
 include/linux/libata.h    |   22 +++
 3 files changed, 418 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/ahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.c	2007-12-19 16:10:50.000000000 -0800
+++ linux-2.6/drivers/ata/ahci.c	2008-01-15 16:34:30.000000000 -0800
@@ -52,6 +52,12 @@
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
+static ssize_t ahci_led_show(struct ata_port *ap, char *buf);
+static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
+			      size_t size);
+static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
+					ssize_t size);
+#define MAX_SLOTS 8
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -92,6 +98,8 @@ enum {
 	HOST_IRQ_STAT		= 0x08, /* interrupt status */
 	HOST_PORTS_IMPL		= 0x0c, /* bitmap of implemented ports */
 	HOST_VERSION		= 0x10, /* AHCI spec. version compliancy */
+	HOST_EM_LOC		= 0x1c, /* Enclosure Management location */
+	HOST_EM_CTL		= 0x20, /* Enclosure Management Control */
 
 	/* HOST_CTL bits */
 	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
@@ -99,6 +107,7 @@ enum {
 	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
+	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
 	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
@@ -195,6 +204,11 @@ enum {
 	AHCI_LFLAG_COMMON		= ATA_LFLAG_SKIP_D2H_BSY,
 
 	ICH_MAP				= 0x90, /* ICH MAP register */
+
+	/* em_ctl bits */
+	EM_CTL_RST			= (1 << 9), /* Reset */
+	EM_CTL_TM			= (1 << 8), /* Transmit Message */
+	EM_CTL_ALHD			= (1 << 26), /* Activity LED */
 };
 
 struct ahci_cmd_hdr {
@@ -212,12 +226,21 @@ struct ahci_sg {
 	u32			flags_size;
 };
 
+struct ahci_em_priv {
+	enum sw_activity blink_policy;
+	struct timer_list timer;
+	unsigned long saved_activity;
+	unsigned long activity;
+	unsigned long led_state;
+};
+
 struct ahci_host_priv {
 	unsigned int		flags;		/* AHCI_HFLAG_* */
 	u32			cap;		/* cap to use */
 	u32			port_map;	/* port map to use */
 	u32			saved_cap;	/* saved initial cap */
 	u32			saved_port_map;	/* saved initial port_map */
+	u32 			em_loc; /* enclosure management location */
 };
 
 struct ahci_port_priv {
@@ -233,6 +256,8 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_dmas:1;
 	unsigned int		ncq_saw_sdb:1;
 	u32 			intr_mask;	/* interrupts to enable */
+	struct ahci_em_priv	em_priv[MAX_SLOTS];/* enclosure management info
+					 	 * per PM slot */
 };
 
 static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
@@ -262,9 +287,20 @@ static int ahci_port_suspend(struct ata_
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int ahci_pci_device_resume(struct pci_dev *pdev);
 #endif
+static ssize_t ahci_activity_show(struct ata_device *dev, char *buf);
+static ssize_t ahci_activity_store(struct ata_device *dev,
+				   enum sw_activity val);
+static void ahci_init_sw_activity(struct ata_link *link);
 
 static struct class_device_attribute *ahci_shost_attrs[] = {
 	&class_device_attr_link_power_management_policy,
+	&class_device_attr_em_message_type,
+	&class_device_attr_em_message,
+	NULL
+};
+
+static struct device_attribute *ahci_sdev_attrs[] = {
+	&dev_attr_sw_activity,
 	NULL
 };
 
@@ -286,6 +322,7 @@ static struct scsi_host_template ahci_sh
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 	.shost_attrs		= ahci_shost_attrs,
+	.sdev_attrs		= ahci_sdev_attrs,
 };
 
 static const struct ata_port_operations ahci_ops = {
@@ -320,6 +357,11 @@ static const struct ata_port_operations 
 	.enable_pm		= ahci_enable_alpm,
 	.disable_pm		= ahci_disable_alpm,
 
+	.em_show		= ahci_led_show,
+	.em_store		= ahci_led_store,
+	.sw_activity_show	= ahci_activity_show,
+	.sw_activity_store	= ahci_activity_store,
+
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 };
@@ -578,6 +620,11 @@ static struct pci_driver ahci_pci_driver
 #endif
 };
 
+static int ahci_em_messages = 1;
+module_param(ahci_em_messages, int, 0444);
+/* add other LED protocol types when they become supported */
+MODULE_PARM_DESC(ahci_em_messages,
+	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");
 
 static inline int ahci_nr_ports(u32 cap)
 {
@@ -1005,11 +1052,28 @@ static void ahci_power_down(struct ata_p
 
 static void ahci_start_port(struct ata_port *ap)
 {
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ata_link *link;
+	struct ahci_em_priv *emp;
+
 	/* enable FIS reception */
 	ahci_start_fis_rx(ap);
 
 	/* enable DMA */
 	ahci_start_engine(ap);
+
+	/* turn on LEDs */
+	if (ap->flags & ATA_FLAG_EM) {
+		ata_port_for_each_link(link, ap) {
+			emp = &pp->em_priv[link->pmp];
+			ahci_transmit_led_message(ap, emp->led_state, 4);
+		}
+	}
+
+	if (ap->flags & ATA_FLAG_SW_ACTIVITY)
+		ata_port_for_each_link(link, ap)
+			ahci_init_sw_activity(link);
+
 }
 
 static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
@@ -1085,6 +1149,230 @@ static int ahci_reset_controller(struct 
 	return 0;
 }
 
+static void ahci_sw_activity(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+
+	if (!(link->flags & ATA_LFLAG_SW_ACTIVITY))
+		return;
+
+	emp->activity++;
+	if (!timer_pending(&emp->timer))
+		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(10));
+}
+
+static void ahci_sw_activity_blink(unsigned long arg)
+{
+	struct ata_link *link = (struct ata_link *)arg;
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+	unsigned long led_message = emp->led_state;
+	u32 activity_led_state;
+
+	led_message &= 0xffff0000;
+	led_message |= ap->port_no | (link->pmp << 8);
+
+	/* check to see if we've had activity.  If so,
+	 * toggle state of LED and reset timer.  If not,
+	 * turn LED to desired idle state.
+	 */
+	if (emp->saved_activity != emp->activity) {
+		emp->saved_activity = emp->activity;
+		/* get the current LED state */
+		activity_led_state = led_message & 0x00010000;
+
+		if (activity_led_state)
+			activity_led_state = 0;
+		else
+			activity_led_state = 1;
+
+		/* clear old state */
+		led_message &= 0xfff8ffff;
+
+		/* toggle state */
+		led_message |= (activity_led_state << 16);
+		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(100));
+	} else {
+		/* switch to idle */
+		led_message &= 0xfff8ffff;
+		if (emp->blink_policy == BLINK_OFF)
+			led_message |= (1 << 16);
+	}
+	ahci_transmit_led_message(ap, led_message, 4);
+}
+
+static void ahci_init_sw_activity(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+
+	/* init activity stats, setup timer */
+	emp->saved_activity = emp->activity = 0;
+	setup_timer(&emp->timer, ahci_sw_activity_blink, (unsigned long)link);
+
+	/* check our blink policy and set flag for link if it's enabled */
+	if (emp->blink_policy)
+		link->flags |= ATA_LFLAG_SW_ACTIVITY;
+}
+
+static int ahci_reset_em(struct ata_host *host)
+{
+	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
+	u32 em_ctl;
+
+	em_ctl = readl(mmio + HOST_EM_CTL);
+	if ((em_ctl & EM_CTL_TM) || (em_ctl & EM_CTL_RST))
+		return -EINVAL;
+
+	writel(em_ctl | EM_CTL_RST, mmio + HOST_EM_CTL);
+	return 0;
+}
+
+static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
+					ssize_t size)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+	u32 em_ctl;
+	u32 message[] = {0, 0};
+	unsigned int flags;
+	int pmp;
+	struct ahci_em_priv *emp;
+
+	/* get the slot number from the message */
+	pmp = (state & 0x0000ff00) >> 8;
+	if (pmp < MAX_SLOTS)
+		emp = &pp->em_priv[pmp];
+	else
+		return -EINVAL;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * if we are still busy transmitting a previous message,
+	 * do not allow
+	 */
+	em_ctl = readl(mmio + HOST_EM_CTL);
+	if (em_ctl & EM_CTL_TM) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return -EINVAL;
+	}
+
+	/*
+	 * create message header - this is all zero except for
+	 * the message size, which is 4 bytes.
+	 */
+	message[0] |= (4 << 8);
+
+	/* ignore 0:4 of byte zero, fill in port info yourself */
+	message[1] = ((state & 0xfffffff0) | ap->port_no);
+
+	/* write message to EM_LOC */
+	writel(message[0], mmio + hpriv->em_loc);
+	writel(message[1], mmio + hpriv->em_loc+4);
+
+	/* save off new led state for port/slot */
+	emp->led_state = message[1];
+
+	/*
+	 * tell hardware to transmit the message
+	 */
+	writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+	return size;
+}
+
+static ssize_t ahci_led_show(struct ata_port *ap, char *buf)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ata_link *link;
+	struct ahci_em_priv *emp;
+	int rc = 0;
+
+	ata_port_for_each_link(link, ap) {
+		emp = &pp->em_priv[link->pmp];
+		rc += sprintf(buf, "%lx\n", emp->led_state);
+	}
+	return rc;
+}
+
+static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
+				size_t size)
+{
+	int state;
+	int pmp;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_em_priv *emp;
+
+	state = simple_strtoul(buf, NULL, 0);
+
+	/* get the slot number from the message */
+	pmp = (state & 0x0000ff00) >> 8;
+	if (pmp < MAX_SLOTS)
+		emp = &pp->em_priv[pmp];
+	else
+		return -EINVAL;
+
+	/* mask off the activity bits if we are in sw_activity
+	 * mode, user should turn off sw_activity before setting
+	 * activity led through em_message
+	 */
+	if (emp->blink_policy)
+		state &= 0xfff8ffff;
+
+	return ahci_transmit_led_message(ap, state, size);
+}
+
+static ssize_t ahci_activity_store(struct ata_device *dev, enum sw_activity val)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+	u32 port_led_state = emp->led_state;
+
+	/* save the desired Activity LED behavior */
+	if (val == OFF) {
+		/* clear LFLAG */
+		link->flags &= ~(ATA_LFLAG_SW_ACTIVITY);
+
+		/* set the LED to OFF */
+		port_led_state &= 0xfff80000;
+		port_led_state |= (ap->port_no | (link->pmp << 8));
+		ahci_transmit_led_message(ap, port_led_state, 4);
+	} else {
+		link->flags |= ATA_LFLAG_SW_ACTIVITY;
+		if (val == BLINK_OFF) {
+			/* set LED to ON for idle */
+			port_led_state &= 0xfff80000;
+			port_led_state |= (ap->port_no | (link->pmp << 8));
+			port_led_state |= 0x00010000; /* check this */
+			ahci_transmit_led_message(ap, port_led_state, 4);
+		}
+	}
+	emp->blink_policy = val;
+	return 0;
+}
+
+static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
+{
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+
+	/* display the saved value of activity behavior for this
+	 * disk.
+	 */
+	return sprintf(buf, "%d\n", emp->blink_policy);
+}
+
 static void ahci_port_init(struct pci_dev *pdev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1781,6 +2069,8 @@ static unsigned int ahci_qc_issue(struct
 	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
+	ahci_sw_activity(qc->dev->link);
+
 	return 0;
 }
 
@@ -2113,7 +2403,8 @@ static void ahci_print_info(struct ata_h
 	dev_printk(KERN_INFO, &pdev->dev,
 		"flags: "
 		"%s%s%s%s%s%s%s"
-		"%s%s%s%s%s%s%s\n"
+		"%s%s%s%s%s%s%s"
+		"%s\n"
 		,
 
 		cap & (1 << 31) ? "64bit " : "",
@@ -2130,7 +2421,8 @@ static void ahci_print_info(struct ata_h
 		cap & (1 << 17) ? "pmp " : "",
 		cap & (1 << 15) ? "pio " : "",
 		cap & (1 << 14) ? "slum " : "",
-		cap & (1 << 13) ? "part " : ""
+		cap & (1 << 13) ? "part " : "",
+		cap & (1 << 6) ? "ems ": ""
 		);
 }
 
@@ -2241,12 +2533,33 @@ static int ahci_init_one(struct pci_dev 
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
 
+	if (ahci_em_messages && (hpriv->cap & HOST_CAP_EMS)) {
+		u8 messages;
+		void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
+		u32 em_loc = readl(mmio + HOST_EM_LOC);
+		u32 em_ctl = readl(mmio + HOST_EM_CTL);
+
+		messages = (em_ctl & 0x000f0000) >> 16;
+
+		/* we only support LED message type right now */
+		if ((messages & 0x01) && (ahci_em_messages == 1)) {
+			/* store em_loc */
+			hpriv->em_loc = ((em_loc >> 16) * 4);
+			pi.flags |= ATA_FLAG_EM;
+			if (!(em_ctl & EM_CTL_ALHD))
+				pi.flags |= ATA_FLAG_SW_ACTIVITY;
+		}
+	}
+
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
 	if (!host)
 		return -ENOMEM;
 	host->iomap = pcim_iomap_table(pdev);
 	host->private_data = hpriv;
 
+	if (pi.flags & ATA_FLAG_EM)
+		ahci_reset_em(host);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		void __iomem *port_mmio = ahci_port_base(ap);
@@ -2258,6 +2571,10 @@ static int ahci_init_one(struct pci_dev 
 		/* set initial link pm policy */
 		ap->pm_policy = NOT_AVAILABLE;
 
+		/* set enclosure management message type */
+		if (ap->flags & ATA_FLAG_EM)
+			ap->em_message_type = ahci_em_messages;
+
 		/* standard SATA port setup */
 		if (hpriv->port_map & (1 << i))
 			ap->ioaddr.cmd_addr = port_mmio;
Index: linux-2.6/drivers/ata/libata-scsi.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-scsi.c	2008-01-15 13:32:27.000000000 -0800
+++ linux-2.6/drivers/ata/libata-scsi.c	2008-01-15 15:02:25.000000000 -0800
@@ -178,6 +178,83 @@ CLASS_DEVICE_ATTR(link_power_management_
 		ata_scsi_lpm_show, ata_scsi_lpm_put);
 EXPORT_SYMBOL_GPL(class_device_attr_link_power_management_policy);
 
+static ssize_t
+ata_scsi_em_message_store(struct class_device *class_dev, const char *buf,
+				size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	if (ap->ops->em_store && (ap->flags & ATA_FLAG_EM))
+		return ap->ops->em_store(ap, buf, count);
+	return -EINVAL;
+}
+
+static ssize_t
+ata_scsi_em_message_show(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	if (ap->ops->em_show && (ap->flags & ATA_FLAG_EM))
+		return ap->ops->em_show(ap, buf);
+	return -EINVAL;
+}
+CLASS_DEVICE_ATTR(em_message, S_IRUGO | S_IWUGO,
+		ata_scsi_em_message_show, ata_scsi_em_message_store);
+EXPORT_SYMBOL_GPL(class_device_attr_em_message);
+
+static ssize_t
+ata_scsi_em_message_type_show(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	return snprintf(buf, 23, "%d\n", ap->em_message_type);
+}
+CLASS_DEVICE_ATTR(em_message_type, S_IRUGO,
+		  ata_scsi_em_message_type_show, NULL);
+EXPORT_SYMBOL_GPL(class_device_attr_em_message_type);
+
+static ssize_t
+ata_scsi_activity_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *atadev = ata_scsi_find_dev(ap, sdev);
+
+	if (ap->ops->sw_activity_show && (ap->flags & ATA_FLAG_SW_ACTIVITY))
+		return ap->ops->sw_activity_show(atadev, buf);
+	return -EINVAL;
+}
+
+static ssize_t
+ata_scsi_activity_store(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *atadev = ata_scsi_find_dev(ap, sdev);
+	enum sw_activity val;
+	int rc;
+
+	if (ap->ops->sw_activity_store && (ap->flags & ATA_FLAG_SW_ACTIVITY)) {
+		val = simple_strtoul(buf, NULL, 0);
+		switch (val) {
+		case OFF: case BLINK_ON: case BLINK_OFF:
+			rc = ap->ops->sw_activity_store(atadev, val);
+			if (!rc)
+				return count;
+			else
+				return rc;
+		}
+	}
+	return -EINVAL;
+}
+DEVICE_ATTR(sw_activity, S_IWUGO | S_IRUGO, ata_scsi_activity_show,
+			ata_scsi_activity_store);
+EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
+
 static void ata_scsi_invalid_field(struct scsi_cmnd *cmd,
 				   void (*done)(struct scsi_cmnd *))
 {
Index: linux-2.6/include/linux/libata.h
===================================================================
--- linux-2.6.orig/include/linux/libata.h	2007-12-19 16:11:01.000000000 -0800
+++ linux-2.6/include/linux/libata.h	2008-01-15 15:02:25.000000000 -0800
@@ -169,6 +169,7 @@ enum {
 	ATA_LFLAG_ASSUME_CLASS	= ATA_LFLAG_ASSUME_ATA | ATA_LFLAG_ASSUME_SEMB,
 	ATA_LFLAG_NO_RETRY	= (1 << 5), /* don't retry this link */
 	ATA_LFLAG_DISABLED	= (1 << 6), /* link is disabled */
+	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -191,6 +192,10 @@ enum {
 	ATA_FLAG_AN		= (1 << 18), /* controller supports AN */
 	ATA_FLAG_PMP		= (1 << 19), /* controller supports PMP */
 	ATA_FLAG_IPM		= (1 << 20), /* driver can handle IPM */
+	ATA_FLAG_EM		= (1 << 21), /* driver supports enclosure
+					      * management */
+	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
+					      * led */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -398,7 +403,17 @@ enum link_pm {
 	MAX_PERFORMANCE,
 	MEDIUM_POWER,
 };
+
+enum sw_activity {
+	OFF,
+	BLINK_ON,
+	BLINK_OFF,
+};
+
 extern struct class_device_attribute class_device_attr_link_power_management_policy;
+extern struct class_device_attribute class_device_attr_em_message_type;
+extern struct class_device_attribute class_device_attr_em_message;
+extern struct device_attribute dev_attr_sw_activity;
 
 struct ata_ioports {
 	void __iomem		*cmd_addr;
@@ -652,6 +667,7 @@ struct ata_port {
 	struct timer_list	fastdrain_timer;
 	unsigned long		fastdrain_cnt;
 
+	int			em_message_type;
 	void			*private_data;
 
 #ifdef CONFIG_ATA_ACPI
@@ -724,6 +740,12 @@ struct ata_port_operations {
 
 	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
+	ssize_t (*em_show)(struct ata_port *ap, char *buf);
+	ssize_t (*em_store)(struct ata_port *ap, const char *message,
+			    size_t size);
+	ssize_t (*sw_activity_show)(struct ata_device *dev, char *buf);
+	ssize_t (*sw_activity_store)(struct ata_device *dev,
+				     enum sw_activity val);
 };
 
 struct ata_port_info {
