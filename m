Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94419B5B1;
	Sun, 29 Jun 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751225215; cv=none; b=siqQHfUh7urSh4UQJ02IEdvjlVKBK6q7Zu1/lpuiqULaeuib3wgcebLjJBrlgBualv+tj7u97jS8tx2lp+8o+CoJt2u3ij4hB1UPn7OOPR3mY9zJR124Td1M7EttGpWCcATK1lnSCAeQbj3aWkIV4c7t4h+2LRkOLV0fZMmCnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751225215; c=relaxed/simple;
	bh=2lYM8sj+8XK7lv5EkKTD5LNE1sFWZ10CDGlNhb+S6mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Siey6vsuScJd02YAMq3+pb2MKPPkDH/0UBEn49igE0bb+RmwsQWrTOETipgHB4aDIjoPlHAzKYI9rXFuF0MjGiHtJOlhekQzco645m0kt9/oNYzxwC8tnKPP1QrcWKKDelsD3IANWRQm+7Ot/1ZweY6MkKfTM8MOmE9MBI4GQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.speedport.ip (p5b13a6da.dip0.t-ipconnect.de [91.19.166.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8208B61E64787;
	Sun, 29 Jun 2025 21:26:16 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: ahci: Add ALPM power state accounting to the AHCI driver
Date: Sun, 29 Jun 2025 21:24:55 +0200
Message-ID: <20250629192456.3761-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arjan van de Ven <arjan@linux.intel.com>

PowerTOP wants to be able to show the user how effective the ALPM link
power management is for the user. ALPM is worth around 0.5W on a quiet
link; PowerTOP wants to be able to find cases where the "quiet link" isn't
actually quiet.

This patch adds state accounting functionality to the AHCI driver for
PowerTOP to use.

The parts of the patch are

1)  the sysfs logic of exposing the stats for each state in sysfs
2)  the basic accounting logic that gets update on link change interrupts
    (or when the user accesses the info from sysfs)
3)  an "accounting enable" flag; in order to get the accounting to work,
    the driver needs to get phyrdy interrupts on link status changes.
    Normally and currently this is disabled by the driver when ALPM is
    on (to reduce overhead); when PowerTOP is running this will need
    to be on to get usable statistics... hence the sysfs tunable.

The PowerTOP output currently looks like this:

    Recent SATA AHCI link activity statistics
    Active	Partial	Slumber	Device name
      0.5%	 99.5%	  0.0%	host0

(work to resolve "host0" to a more human readable name is in progress)

    [root@dyn-252 host1]# grep ^ ahci_alpm_*
    ahci_alpm_accounting:1
    ahci_alpm_active:1334912
    ahci_alpm_devslp:251547
    ahci_alpm_partial:0
    ahci_alpm_slumber:1020283

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
[rebased from https://raw.github.com/fenrus75/powertop/master/patches/linux-3.3.0-ahci-alpm-accounting.patch]
Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
[rebased from https://lore.kernel.org/all/1364473277.14860.33.camel@i7.infradead.org/
and slightly modify commit message and update David’s email address]
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
See https://lore.kernel.org/all/20091113192429.4dfc9c39@infradead.org/
for the original discussion

 drivers/ata/ahci.h    |  17 ++++
 drivers/ata/libahci.c | 212 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2c10c8f440d1..d02dd726adfd 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -304,6 +304,14 @@ struct ahci_em_priv {
 	struct ata_link *link;
 };
 
+enum ahci_port_states {
+	AHCI_PORT_NOLINK = 0,
+	AHCI_PORT_ACTIVE = 1,
+	AHCI_PORT_PARTIAL = 2,
+	AHCI_PORT_SLUMBER = 3,
+	AHCI_PORT_DEVSLP = 4
+};
+
 struct ahci_port_priv {
 	struct ata_link		*active_link;
 	struct ahci_cmd_hdr	*cmd_slot;
@@ -324,6 +332,15 @@ struct ahci_port_priv {
 	/* enclosure management info per PM slot */
 	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
 	char			*irq_desc;	/* desc in /proc/interrupts */
+
+	/* ALPM accounting state and stats */
+	unsigned int 		accounting_active:1;
+	u64			active_jiffies;
+	u64			partial_jiffies;
+	u64			slumber_jiffies;
+	u64			devslp_jiffies;
+	int			previous_state;
+	int			previous_jiffies;
 };
 
 struct ahci_host_priv {
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4e9c82f36df1..4b787eb246bd 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -85,6 +85,19 @@ static ssize_t ahci_activity_store(struct ata_device *dev,
 				   enum sw_activity val);
 static void ahci_init_sw_activity(struct ata_link *link);
 
+static ssize_t ahci_alpm_show_active(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_slumber(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_devslp(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_partial(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_accounting(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_set_accounting(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count);
 static ssize_t ahci_show_host_caps(struct device *dev,
 				   struct device_attribute *attr, char *buf);
 static ssize_t ahci_show_host_cap2(struct device *dev,
@@ -106,6 +119,13 @@ static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
 static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
 static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+static DEVICE_ATTR(ahci_alpm_active, S_IRUGO, ahci_alpm_show_active, NULL);
+static DEVICE_ATTR(ahci_alpm_partial, S_IRUGO, ahci_alpm_show_partial, NULL);
+static DEVICE_ATTR(ahci_alpm_slumber, S_IRUGO, ahci_alpm_show_slumber, NULL);
+static DEVICE_ATTR(ahci_alpm_devslp, S_IRUGO, ahci_alpm_show_devslp, NULL);
+static DEVICE_ATTR(ahci_alpm_accounting, S_IRUGO | S_IWUSR,
+		ahci_alpm_show_accounting, ahci_alpm_set_accounting);
+
 static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 		   ahci_read_em_buffer, ahci_store_em_buffer);
 static DEVICE_ATTR(em_message_supported, S_IRUGO, ahci_show_em_supported, NULL);
@@ -118,6 +138,11 @@ static struct attribute *ahci_shost_attrs[] = {
 	&dev_attr_ahci_host_cap2.attr,
 	&dev_attr_ahci_host_version.attr,
 	&dev_attr_ahci_port_cmd.attr,
+	&dev_attr_ahci_alpm_active.attr,
+	&dev_attr_ahci_alpm_partial.attr,
+	&dev_attr_ahci_alpm_slumber.attr,
+	&dev_attr_ahci_alpm_devslp.attr,
+	&dev_attr_ahci_alpm_accounting.attr,
 	&dev_attr_em_buffer.attr,
 	&dev_attr_em_message_supported.attr,
 	NULL
@@ -257,6 +282,183 @@ static void ahci_rpm_put_port(struct ata_port *ap)
 	pm_runtime_put(ap->dev);
 }
 
+static int get_current_alpm_state(struct ata_port *ap)
+{
+	u32 status = 0;
+
+	ahci_scr_read(&ap->link, SCR_STATUS, &status);
+
+	/* link status is in bits 11-8 */
+	status = status >> 8;
+	status = status & 0xf;
+
+	if (status == 8)
+		return AHCI_PORT_DEVSLP;
+	if (status == 6)
+		return AHCI_PORT_SLUMBER;
+	if (status == 2)
+		return AHCI_PORT_PARTIAL;
+	if (status == 1)
+		return AHCI_PORT_ACTIVE;
+	return AHCI_PORT_NOLINK;
+}
+
+static void account_alpm_stats(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp;
+
+	int new_state;
+	u64 new_jiffies, jiffies_delta;
+
+	if (ap == NULL)
+		return;
+	pp = ap->private_data;
+
+	if (!pp) return;
+
+	new_state = get_current_alpm_state(ap);
+	new_jiffies = jiffies;
+
+	jiffies_delta = new_jiffies - pp->previous_jiffies;
+
+	switch (pp->previous_state) {
+	case AHCI_PORT_NOLINK:
+		pp->active_jiffies = 0;
+		pp->partial_jiffies = 0;
+		pp->slumber_jiffies = 0;
+		break;
+	case AHCI_PORT_ACTIVE:
+		pp->active_jiffies += jiffies_delta;
+		break;
+	case AHCI_PORT_PARTIAL:
+		pp->partial_jiffies += jiffies_delta;
+		break;
+	case AHCI_PORT_SLUMBER:
+		pp->slumber_jiffies += jiffies_delta;
+		break;
+	case AHCI_PORT_DEVSLP:
+		pp->devslp_jiffies += jiffies_delta;
+		break;
+	default:
+		break;
+	}
+	pp->previous_state = new_state;
+	pp->previous_jiffies = new_jiffies;
+}
+
+static ssize_t ahci_alpm_show_active(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp = ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->active_jiffies));
+}
+
+static ssize_t ahci_alpm_show_partial(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp = ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->partial_jiffies));
+}
+
+static ssize_t ahci_alpm_show_slumber(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp = ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->slumber_jiffies));
+}
+
+static ssize_t ahci_alpm_show_devslp(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp = ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->devslp_jiffies));
+}
+
+static ssize_t ahci_alpm_show_accounting(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp = ap->private_data;
+
+	return sprintf(buf, "%u\n", pp->accounting_active);
+}
+
+static ssize_t ahci_alpm_set_accounting(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	unsigned long flags;
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+	void __iomem *port_mmio;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return 1;
+
+	pp = ap->private_data;
+	port_mmio = ahci_port_base(ap);
+
+	if (!pp)
+		return 1;
+	if (buf[0] == '0')
+		pp->accounting_active = 0;
+	if (buf[0] == '1')
+		pp->accounting_active = 1;
+
+	/* we need to enable the PHYRDY interrupt when we want accounting */
+	if (pp->accounting_active) {
+		spin_lock_irqsave(ap->lock, flags);
+		pp->intr_mask |= PORT_IRQ_PHYRDY;
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	return count;
+}
+
 static ssize_t ahci_show_host_caps(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -821,9 +1023,14 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		 * Disable interrupts on Phy Ready. This keeps us from
 		 * getting woken up due to spurious phy ready
 		 * interrupts.
+		 *
+		 * However, when accounting_active is set, we do want
+		 * the interrupts for accounting purposes.
 		 */
-		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
-		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		if (!pp->accounting_active) {
+			pp->intr_mask &= ~PORT_IRQ_PHYRDY;
+			writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		}
 
 		sata_link_scr_lpm(link, policy, false);
 	}
@@ -1903,6 +2110,7 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 
 	if (sata_lpm_ignore_phy_events(&ap->link)) {
 		status &= ~PORT_IRQ_PHYRDY;
+		account_alpm_stats(ap);
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
 	}
 
-- 
2.50.0

