From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 10:42:01 -0800
Message-ID: <20091115104201.3dec642b@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<20091115103636.0039910e@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44971 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZKOSkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 13:40:19 -0500
In-Reply-To: <20091115103636.0039910e@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, akpm@linux-foundation.org

On Sun, 15 Nov 2009 10:36:36 -0800
Arjan van de Ven <arjan@infradead.org> wrote:

> On Sun, 15 Nov 2009 17:05:51 +0900
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Most of logic seems to belong to libata generic part rather than in
> > ahci itself.  Wouldn't it be better to implement the thing as
> > generic libata feature which ahci uses?
> 
> ok how about this?

was missing an EXPORT_SYMBOL_GPL on the accounting function; v3 below

>From 4958476e83d317eaafd424f61fa8d9c7daf31a33 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 15 Nov 2009 10:33:46 -0800
Subject: [PATCH v3] libata: Add ALPM power state accounting to the AHCI driver

PowerTOP wants to be able to show the user how effective the ALPM link
power management is for the user. ALPM is worth around 0.5W on a quiet
link; PowerTOP wants to be able to find cases where the "quiet link" isn't
actually quiet.

This patch adds state accounting functionality to the AHCI driver and
libata layer for PowerTOP to use.
The parts of the patch are
1) the sysfs logic of exposing the stats for each state in sysfs [libata]
2) the basic accounting logic that gets called on link change interrupts
   (or when the user accesses the info from sysfs) [libata]
3) the interrupt logic to call accounting on power state change [ahci]
4) a "accounting enable" flag; in order to get the accounting to work,
   the driver needs to get phyrdy interrupts on link status changes.
   Normally and currently this is disabled by the driver when ALPM is
   on (to reduce overhead); when PowerTOP is running this will need
   to be on to get usable statistics... hence the sysfs tunable. [ahci]

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ata/ahci.c        |   62 ++++++++++++++++++++++++++++-
 drivers/ata/libata-core.c |   97 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |   24 +++++++++++
 3 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a3241a1..d8f2145 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -72,6 +72,14 @@ MODULE_PARM_DESC(ignore_sss, "Ignore staggered spinup flag (0=don't ignore, 1=ig
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
+
+static ssize_t ahci_alpm_show_accounting(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+
+static ssize_t ahci_alpm_set_accounting(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count);
+
 static ssize_t ahci_led_show(struct ata_port *ap, char *buf);
 static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 			      size_t size);
@@ -304,6 +312,8 @@ struct ahci_port_priv {
 	u32 			intr_mask;	/* interrupts to enable */
 	/* enclosure management info per PM slot */
 	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
+
+	unsigned int		alpm_accounting_active:1;
 };
 
 static int ahci_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
@@ -359,6 +369,9 @@ DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
 DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
 DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
 
+DEVICE_ATTR(ahci_alpm_accounting, S_IRUGO | S_IWUSR,
+		ahci_alpm_show_accounting, ahci_alpm_set_accounting);
+
 static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
 	&dev_attr_em_message_type,
@@ -367,6 +380,10 @@ static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_ahci_host_cap2,
 	&dev_attr_ahci_host_version,
 	&dev_attr_ahci_port_cmd,
+	&dev_attr_ata_alpm_active,
+	&dev_attr_ata_alpm_partial,
+	&dev_attr_ata_alpm_slumber,
+	&dev_attr_ahci_alpm_accounting,
 	NULL
 };
 
@@ -1165,9 +1182,14 @@ static int ahci_enable_alpm(struct ata_port *ap,
  	 * getting woken up due to spurious phy ready interrupts
 	 * TBD - Hot plug should be done via polling now, is
 	 * that even supported?
+	 *
+	 * However, when accounting_active is set, we do want
+	 * the interrupts for accounting purposes.
  	 */
-	pp->intr_mask &= ~PORT_IRQ_PHYRDY;
-	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+	if (!pp->alpm_accounting_active) {
+		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+	}
 
 	/*
  	 * Set a flag to indicate that we should ignore all PhyRdy
@@ -2157,6 +2179,41 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		ata_port_abort(ap);
 }
 
+static ssize_t ahci_alpm_show_accounting(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp = ap->private_data;
+
+	return sprintf(buf, "%u\n", pp->alpm_accounting_active);
+}
+
+static ssize_t ahci_alpm_set_accounting(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	unsigned long flags;
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+
+	if (buf[0] == '0')
+		pp->alpm_accounting_active = 0;
+	if (buf[0] == '1')
+		pp->alpm_accounting_active = 1;
+
+	/* we need to enable the PHYRDY interrupt when we want accounting */
+	if (pp->alpm_accounting_active) {
+		spin_lock_irqsave(ap->lock, flags);
+		pp->intr_mask |= PORT_IRQ_PHYRDY;
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+	return count;
+}
+
 static void ahci_port_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
@@ -2182,6 +2239,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	if ((hpriv->flags & AHCI_HFLAG_NO_HOTPLUG) &&
 		(status & PORT_IRQ_PHYRDY)) {
 		status &= ~PORT_IRQ_PHYRDY;
+		ata_account_alpm_stats(ap);
 		ahci_scr_write(&ap->link, SCR_ERROR, ((1 << 16) | (1 << 18)));
 	}
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc72690..385d7f7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6733,6 +6733,103 @@ const struct ata_port_info ata_dummy_port_info = {
 	.port_ops		= &ata_dummy_port_ops,
 };
 
+/* ALPM state accounting helpers */
+static int get_current_alpm_state(struct ata_port *ap)
+{
+	u32 status = 0;
+
+	sata_scr_read(&ap->link, SCR_STATUS, &status);
+
+	/* link status is in bits 11-8 */
+	status = status >> 8;
+	status = status & 0x7;
+
+	if (status == 6)
+		return ALPM_PORT_SLUMBER;
+	if (status == 2)
+		return ALPM_PORT_PARTIAL;
+	if (status == 1)
+		return ALPM_PORT_ACTIVE;
+	return ALPM_PORT_NOLINK;
+}
+
+void ata_account_alpm_stats(struct ata_port *ap)
+{
+	int new_state;
+	u64 new_jiffies, jiffies_delta;
+
+	new_state = get_current_alpm_state(ap);
+	new_jiffies = jiffies;
+
+	jiffies_delta = new_jiffies - ap->link.ata_link_stats.previous_jiffies;
+
+	switch (ap->link.ata_link_stats.previous_state) {
+	case ALPM_PORT_NOLINK:
+		ap->link.ata_link_stats.active_jiffies = 0;
+		ap->link.ata_link_stats.partial_jiffies = 0;
+		ap->link.ata_link_stats.slumber_jiffies = 0;
+		break;
+	case ALPM_PORT_ACTIVE:
+		ap->link.ata_link_stats.active_jiffies += jiffies_delta;
+		break;
+	case ALPM_PORT_PARTIAL:
+		ap->link.ata_link_stats.partial_jiffies += jiffies_delta;
+		break;
+	case ALPM_PORT_SLUMBER:
+		ap->link.ata_link_stats.slumber_jiffies += jiffies_delta;
+		break;
+	default:
+		break;
+	}
+	ap->link.ata_link_stats.previous_state = new_state;
+	ap->link.ata_link_stats.previous_jiffies = new_jiffies;
+}
+EXPORT_SYMBOL_GPL(ata_account_alpm_stats);
+
+static ssize_t ata_alpm_show_active(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	ata_account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n",
+		jiffies_to_msecs(ap->link.ata_link_stats.active_jiffies));
+}
+
+static ssize_t ata_alpm_show_partial(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	ata_account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n",
+		jiffies_to_msecs(ap->link.ata_link_stats.partial_jiffies));
+}
+
+static ssize_t ata_alpm_show_slumber(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	ata_account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n",
+		jiffies_to_msecs(ap->link.ata_link_stats.slumber_jiffies));
+}
+
+DEVICE_ATTR(ata_alpm_active, S_IRUGO, ata_alpm_show_active, NULL);
+DEVICE_ATTR(ata_alpm_partial, S_IRUGO, ata_alpm_show_partial, NULL);
+DEVICE_ATTR(ata_alpm_slumber, S_IRUGO, ata_alpm_show_slumber, NULL);
+EXPORT_SYMBOL_GPL(dev_attr_ata_alpm_active);
+EXPORT_SYMBOL_GPL(dev_attr_ata_alpm_partial);
+EXPORT_SYMBOL_GPL(dev_attr_ata_alpm_slumber);
+
+
 /*
  * libata is essentially a library of internal helper functions for
  * low-level ATA host controller drivers.  As such, the API/ABI is
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8769864..f38f4f9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -682,6 +682,22 @@ struct ata_acpi_gtm {
 	u32 flags;
 } __packed;
 
+/* ALPM accounting state and stats */
+enum alpm_port_states {
+	ALPM_PORT_NOLINK  = 0,
+	ALPM_PORT_ACTIVE  = 1,
+	ALPM_PORT_PARTIAL = 2,
+	ALPM_PORT_SLUMBER = 3
+};
+
+struct ata_link_stats {
+	u64			active_jiffies;
+	u64			partial_jiffies;
+	u64			slumber_jiffies;
+	int			previous_state;
+	int			previous_jiffies;
+};
+
 struct ata_link {
 	struct ata_port		*ap;
 	int			pmp;		/* port multiplier port # */
@@ -702,6 +718,8 @@ struct ata_link {
 	struct ata_eh_context	eh_context;
 
 	struct ata_device	device[ATA_MAX_DEVICES];
+
+	struct ata_link_stats	ata_link_stats;
 };
 
 struct ata_port {
@@ -1046,6 +1064,12 @@ extern void ata_timing_merge(const struct ata_timing *,
 			     unsigned int);
 extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
 
+/* alpm accounting helpers */
+extern void ata_account_alpm_stats(struct ata_port *ap);
+extern struct device_attribute dev_attr_ata_alpm_active;
+extern struct device_attribute dev_attr_ata_alpm_partial;
+extern struct device_attribute dev_attr_ata_alpm_slumber;
+
 /* PCI */
 #ifdef CONFIG_PCI
 struct pci_dev;
-- 
1.6.2.5



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
