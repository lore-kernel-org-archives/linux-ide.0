From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] libata: implement slave_link
Date: Thu, 31 Jul 2008 17:02:43 +0900
Message-ID: <1217491364-19725-5-git-send-email-tj@kernel.org>
References: <1217491364-19725-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39909 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbYGaIE0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 04:04:26 -0400
In-Reply-To: <1217491364-19725-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, JosephChan@via.com.tw
Cc: Tejun Heo <tj@kernel.org>

Explanation taken from the comment of ata_slave_link_init().

 In libata, a port contains links and a link contains devices.  There
 is single host link but if a PMP is attached to it, there can be
 multiple fan-out links.  On SATA, there's usually a single device
 connected to a link but PATA and SATA controllers emulating TF based
 interface can have two - master and slave.

 However, there are a few controllers which don't fit into this
 abstraction too well - SATA controllers which emulate TF interface
 with both master and slave devices but also have separate SCR
 register sets for each device.  These controllers need separate links
 for physical link handling (e.g. onlineness, link speed) but should
 be treated like a traditional M/S controller for everything else
 (e.g. command issue, softreset).

 slave_link is libata's way of handling this class of controllers
 without impacting core layer too much.  For anything other than
 physical link handling, the default host link is used for both master
 and slave.  For physical link handling, separate @ap->slave_link is
 used.  All dirty details are implemented inside libata core layer.
 From LLD's POV, the only difference is that prereset, hardreset and
 postreset are called once more for the slave link, so the reset
 sequence looks like the following.

 prereset(M) -> prereset(S) -> hardreset(M) -> hardreset(S) ->
 softreset(M) -> postreset(M) -> postreset(S)

 Note that softreset is called only for the master.  Softreset resets
 both M/S by definition, so SRST on master should handle both (the
 standard method will work just fine).

As slave_link excludes PMP support and only code paths which deal with
the attributes of physical link are affected, all the changes are
localized to libata.h, libata-core.c and libata-eh.c.

 * ata_is_host_link() updated so that slave_link is considered as host
   link too.

 * iterator extended to iterate over the slave_link when using the
   underbarred version.

 * force param handling updated such that devno 16 is mapped to the
   slave link/device.

 * ata_link_on/offline() updated to return the combined result from
   master and slave link.  ata_phys_link_on/offline() are the direct
   versions.

 * EH autopsy and report are performed separately for master slave
   links.  Reset is udpated to implement the above described reset
   sequence.

Except for reset update, most changes are minor, many of them just
modifying dev->link to ata_dev_phys_link(dev) or using phys online
test instead.

After this update, LLDs can take full advantage of per-dev SCR
registers by simply turning on slave link.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |  202 +++++++++++++++++++++++++++++++++++++++-----
 drivers/ata/libata-eh.c   |  142 ++++++++++++++++++++++++++------
 drivers/ata/libata.h      |    3 +
 include/linux/libata.h    |    8 +-
 4 files changed, 303 insertions(+), 52 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c303e6..3e4cd31 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -178,13 +178,20 @@ struct ata_link *__ata_port_next_link(struct ata_port *ap,
 		return &ap->link;
 	}
 
-	/* we just iterated over the host link, what's next? */
-	if (ata_is_host_link(link)) {
-		if (!sata_pmp_attached(ap))
+	/* we just iterated over the host master link, what's next? */
+	if (link == &ap->link) {
+		if (!sata_pmp_attached(ap)) {
+			if (unlikely(ap->slave_link) && !dev_only)
+				return ap->slave_link;
 			return NULL;
+		}
 		return ap->pmp_link;
 	}
 
+	/* slave_link excludes PMP */
+	if (unlikely(link == ap->slave_link))
+		return NULL;
+
 	/* iterate to the next PMP link */
 	if (++link < ap->pmp_link + ap->nr_pmp_links)
 		return link;
@@ -192,6 +199,31 @@ struct ata_link *__ata_port_next_link(struct ata_port *ap,
 }
 
 /**
+ *	ata_dev_phys_link - find physical link for a device
+ *	@dev: ATA device to look up physical link for
+ *
+ *	Look up physical link which @dev is attached to.  Note that
+ *	this is different from @dev->link only when @dev is on slave
+ *	link.  For all other cases, it's the same as @dev->link.
+ *
+ *	LOCKING:
+ *	Don't care.
+ *
+ *	RETURNS:
+ *	Pointer to the found physical link.
+ */
+struct ata_link *ata_dev_phys_link(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+
+	if (!ap->slave_link)
+		return dev->link;
+	if (!dev->devno)
+		return &ap->link;
+	return ap->slave_link;
+}
+
+/**
  *	ata_force_cbl - force cable type according to libata.force
  *	@ap: ATA port of interest
  *
@@ -234,19 +266,19 @@ void ata_force_cbl(struct ata_port *ap)
  *	fan-out ports connected via PMP.  If the device part is
  *	specified as 0 (e.g. 1.00:), it specifies the first fan-out
  *	link not the host link.  Device number 15 always points to the
- *	host link whether PMP is attached or not.
+ *	host link whether PMP is attached or not.  If the controller
+ *	has slave link, device number 16 points to it.
  *
  *	LOCKING:
  *	EH context.
  */
 static void ata_force_spd_limit(struct ata_link *link)
 {
-	int linkno, i;
+	int linkno = link->pmp;
+	int i;
 
 	if (ata_is_host_link(link))
-		linkno = 15;
-	else
-		linkno = link->pmp;
+		linkno += 15;
 
 	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
 		const struct ata_force_ent *fe = &ata_force_tbl[i];
@@ -284,9 +316,9 @@ static void ata_force_xfermask(struct ata_device *dev)
 	int alt_devno = devno;
 	int i;
 
-	/* allow n.15 for the first device attached to host port */
-	if (ata_is_host_link(dev->link) && devno == 0)
-		alt_devno = 15;
+	/* allow n.15/16 for devices attached to host port */
+	if (ata_is_host_link(dev->link))
+		alt_devno += 15;
 
 	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
 		const struct ata_force_ent *fe = &ata_force_tbl[i];
@@ -338,9 +370,9 @@ static void ata_force_horkage(struct ata_device *dev)
 	int alt_devno = devno;
 	int i;
 
-	/* allow n.15 for the first device attached to host port */
-	if (ata_is_host_link(dev->link) && devno == 0)
-		alt_devno = 15;
+	/* allow n.15/16 for devices attached to host port */
+	if (ata_is_host_link(dev->link))
+		alt_devno += 15;
 
 	for (i = 0; i < ata_force_tbl_size; i++) {
 		const struct ata_force_ent *fe = &ata_force_tbl[i];
@@ -2669,7 +2701,7 @@ static void sata_print_link_status(struct ata_link *link)
 		return;
 	sata_scr_read(link, SCR_CONTROL, &scontrol);
 
-	if (ata_link_online(link)) {
+	if (ata_phys_link_online(link)) {
 		tmp = (sstatus >> 4) & 0xf;
 		ata_link_printk(link, KERN_INFO,
 				"SATA link up %s (SStatus %X SControl %X)\n",
@@ -3360,6 +3392,12 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 	unsigned long nodev_deadline = ata_deadline(start, ATA_TMOUT_FF_WAIT);
 	int warned = 0;
 
+	/* Slave readiness can't be tested separately from master.  On
+	 * M/S emulation configuration, this function should be called
+	 * only on the master and it will handle both master and slave.
+	 */
+	WARN_ON(link == link->ap->slave_link);
+
 	if (time_after(nodev_deadline, deadline))
 		nodev_deadline = deadline;
 
@@ -3581,7 +3619,7 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 	}
 
 	/* no point in trying softreset on offline link */
-	if (ata_link_offline(link))
+	if (ata_phys_link_offline(link))
 		ehc->i.action &= ~ATA_EH_SOFTRESET;
 
 	return 0;
@@ -3659,7 +3697,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	if (rc)
 		goto out;
 	/* if link is offline nothing more to do */
-	if (ata_link_offline(link))
+	if (ata_phys_link_offline(link))
 		goto out;
 
 	/* Link is online.  From this point, -ENODEV too is an error. */
@@ -4924,7 +4962,7 @@ int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 }
 
 /**
- *	ata_link_online - test whether the given link is online
+ *	ata_phys_link_online - test whether the given link is online
  *	@link: ATA link to test
  *
  *	Test whether @link is online.  Note that this function returns
@@ -4937,7 +4975,7 @@ int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
  *	RETURNS:
  *	True if the port online status is available and online.
  */
-bool ata_link_online(struct ata_link *link)
+bool ata_phys_link_online(struct ata_link *link)
 {
 	u32 sstatus;
 
@@ -4948,7 +4986,7 @@ bool ata_link_online(struct ata_link *link)
 }
 
 /**
- *	ata_link_offline - test whether the given link is offline
+ *	ata_phys_link_offline - test whether the given link is offline
  *	@link: ATA link to test
  *
  *	Test whether @link is offline.  Note that this function
@@ -4961,7 +4999,7 @@ bool ata_link_online(struct ata_link *link)
  *	RETURNS:
  *	True if the port offline status is available and offline.
  */
-bool ata_link_offline(struct ata_link *link)
+bool ata_phys_link_offline(struct ata_link *link)
 {
 	u32 sstatus;
 
@@ -4971,6 +5009,58 @@ bool ata_link_offline(struct ata_link *link)
 	return false;
 }
 
+/**
+ *	ata_link_online - test whether the given link is online
+ *	@link: ATA link to test
+ *
+ *	Test whether @link is online.  This is identical to
+ *	ata_phys_link_online() when there's no slave link.  When
+ *	there's a slave link, this function should only be called on
+ *	the master link and will return true if any of M/S links is
+ *	online.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	True if the port online status is available and online.
+ */
+bool ata_link_online(struct ata_link *link)
+{
+	struct ata_link *slave = link->ap->slave_link;
+
+	WARN_ON(link == slave);	/* shouldn't be called on slave link */
+
+	return ata_phys_link_online(link) ||
+		(slave && ata_phys_link_online(slave));
+}
+
+/**
+ *	ata_link_offline - test whether the given link is offline
+ *	@link: ATA link to test
+ *
+ *	Test whether @link is offline.  This is identical to
+ *	ata_phys_link_offline() when there's no slave link.  When
+ *	there's a slave link, this function should only be called on
+ *	the master link and will return true if both M/S links are
+ *	offline.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	True if the port offline status is available and offline.
+ */
+bool ata_link_offline(struct ata_link *link)
+{
+	struct ata_link *slave = link->ap->slave_link;
+
+	WARN_ON(link == slave);	/* shouldn't be called on slave link */
+
+	return ata_phys_link_offline(link) &&
+		(!slave || ata_phys_link_offline(slave));
+}
+
 #ifdef CONFIG_PM
 static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 			       unsigned int action, unsigned int ehi_flags,
@@ -5110,11 +5200,11 @@ int ata_port_start(struct ata_port *ap)
  */
 void ata_dev_init(struct ata_device *dev)
 {
-	struct ata_link *link = dev->link;
+	struct ata_link *link = ata_dev_phys_link(dev);
 	struct ata_port *ap = link->ap;
 	unsigned long flags;
 
-	/* SATA spd limit is bound to the first device */
+	/* SATA spd limit is bound to the attached device, reset together */
 	link->sata_spd_limit = link->hw_sata_spd_limit;
 	link->sata_spd = 0;
 
@@ -5277,6 +5367,7 @@ static void ata_host_release(struct device *gendev, void *res)
 			scsi_host_put(ap->scsi_host);
 
 		kfree(ap->pmp_link);
+		kfree(ap->slave_link);
 		kfree(ap);
 		host->ports[i] = NULL;
 	}
@@ -5397,6 +5488,68 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 	return host;
 }
 
+/**
+ *	ata_slave_link_init - initialize slave link
+ *	@ap: port to initialize slave link for
+ *
+ *	Create and initialize slave link for @ap.  This enables slave
+ *	link handling on the port.
+ *
+ *	In libata, a port contains links and a link contains devices.
+ *	There is single host link but if a PMP is attached to it,
+ *	there can be multiple fan-out links.  On SATA, there's usually
+ *	a single device connected to a link but PATA and SATA
+ *	controllers emulating TF based interface can have two - master
+ *	and slave.
+ *
+ *	However, there are a few controllers which don't fit into this
+ *	abstraction too well - SATA controllers which emulate TF
+ *	interface with both master and slave devices but also have
+ *	separate SCR register sets for each device.  These controllers
+ *	need separate links for physical link handling
+ *	(e.g. onlineness, link speed) but should be treated like a
+ *	traditional M/S controller for everything else (e.g. command
+ *	issue, softreset).
+ *
+ *	slave_link is libata's way of handling this class of
+ *	controllers without impacting core layer too much.  For
+ *	anything other than physical link handling, the default host
+ *	link is used for both master and slave.  For physical link
+ *	handling, separate @ap->slave_link is used.  All dirty details
+ *	are implemented inside libata core layer.  From LLD's POV, the
+ *	only difference is that prereset, hardreset and postreset are
+ *	called once more for the slave link, so the reset sequence
+ *	looks like the following.
+ *
+ *	prereset(M) -> prereset(S) -> hardreset(M) -> hardreset(S) ->
+ *	softreset(M) -> postreset(M) -> postreset(S)
+ *
+ *	Note that softreset is called only for the master.  Softreset
+ *	resets both M/S by definition, so SRST on master should handle
+ *	both (the standard method will work just fine).
+ *
+ *	LOCKING:
+ *	Should be called before host is registered.
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_slave_link_init(struct ata_port *ap)
+{
+	struct ata_link *link;
+
+	WARN_ON(ap->slave_link);
+	WARN_ON(ap->flags & ATA_FLAG_PMP);
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	ata_link_init(ap, link, 1);
+	ap->slave_link = link;
+	return 0;
+}
+
 static void ata_host_stop(struct device *gendev, void *res)
 {
 	struct ata_host *host = dev_get_drvdata(gendev);
@@ -5623,6 +5776,8 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 		/* init sata_spd_limit to the current value */
 		sata_link_init_spd(&ap->link);
+		if (ap->slave_link)
+			sata_link_init_spd(ap->slave_link);
 
 		/* print per-port info to dmesg */
 		xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
@@ -6241,6 +6396,7 @@ EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
+EXPORT_SYMBOL_GPL(ata_slave_link_init);
 EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_host_register);
 EXPORT_SYMBOL_GPL(ata_host_activate);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5de0bf3..94022d4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1756,7 +1756,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
 static unsigned int ata_eh_speed_down(struct ata_device *dev,
 				unsigned int eflags, unsigned int err_mask)
 {
-	struct ata_link *link = dev->link;
+	struct ata_link *link = ata_dev_phys_link(dev);
 	int xfer_ok = 0;
 	unsigned int verdict;
 	unsigned int action = 0;
@@ -1880,7 +1880,8 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
+		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		    ata_dev_phys_link(qc->dev) != link)
 			continue;
 
 		/* inherit upper level err_mask */
@@ -1967,6 +1968,23 @@ void ata_eh_autopsy(struct ata_port *ap)
 	ata_port_for_each_link(link, ap)
 		ata_eh_link_autopsy(link);
 
+	/* Handle the frigging slave link.  Autopsy is done similarly
+	 * but actions and flags are transferred over to the master
+	 * link and handled from there.
+	 */
+	if (ap->slave_link) {
+		struct ata_eh_context *mehc = &ap->link.eh_context;
+		struct ata_eh_context *sehc = &ap->slave_link->eh_context;
+
+		ata_eh_link_autopsy(ap->slave_link);
+
+		ata_eh_about_to_do(ap->slave_link, NULL, ATA_EH_ALL_ACTIONS);
+		mehc->i.action		|= sehc->i.action;
+		mehc->i.dev_action[1]	|= sehc->i.dev_action[1];
+		mehc->i.flags		|= sehc->i.flags;
+		ata_eh_done(ap->slave_link, NULL, ATA_EH_ALL_ACTIONS);
+	}
+
 	/* Autopsy of fanout ports can affect host link autopsy.
 	 * Perform host link autopsy last.
 	 */
@@ -2001,7 +2019,8 @@ static void ata_eh_link_report(struct ata_link *link)
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link ||
+		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
+		    ata_dev_phys_link(qc->dev) != link ||
 		    ((qc->flags & ATA_QCFLAG_QUIET) &&
 		     qc->err_mask == AC_ERR_DEV))
 			continue;
@@ -2068,7 +2087,7 @@ static void ata_eh_link_report(struct ata_link *link)
 		char cdb_buf[70] = "";
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
-		    qc->dev->link != link || !qc->err_mask)
+		    ata_dev_phys_link(qc->dev) != link || !qc->err_mask)
 			continue;
 
 		if (qc->dma_dir != DMA_NONE) {
@@ -2160,12 +2179,14 @@ void ata_eh_report(struct ata_port *ap)
 }
 
 static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
-			unsigned int *classes, unsigned long deadline)
+			unsigned int *classes, unsigned long deadline,
+			bool clear_classes)
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link)
-		classes[dev->devno] = ATA_DEV_UNKNOWN;
+	if (clear_classes)
+		ata_link_for_each_dev(dev, link)
+			classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	return reset(link, classes, deadline);
 }
@@ -2187,17 +2208,20 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
 	struct ata_port *ap = link->ap;
+	struct ata_link *slave = ap->slave_link;
 	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_eh_context *sehc = &slave->eh_context;
 	unsigned int *classes = ehc->classes;
 	unsigned int lflags = link->flags;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	int max_tries = 0, try = 0;
+	struct ata_link *failed_link;
 	struct ata_device *dev;
 	unsigned long deadline, now;
 	ata_reset_fn_t reset;
 	unsigned long flags;
 	u32 sstatus;
-	int nr_known, rc;
+	int nr_unknown, rc;
 
 	/*
 	 * Prepare to reset
@@ -2248,8 +2272,30 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	}
 
 	if (prereset) {
-		rc = prereset(link,
-			      ata_deadline(jiffies, ATA_EH_PRERESET_TIMEOUT));
+		unsigned long deadline = ata_deadline(jiffies,
+						      ATA_EH_PRERESET_TIMEOUT);
+
+		if (slave) {
+			sehc->i.action &= ~ATA_EH_RESET;
+			sehc->i.action |= ehc->i.action;
+		}
+
+		rc = prereset(link, deadline);
+
+		/* If present, do prereset on slave link too.  Reset
+		 * is skipped iff both master and slave links report
+		 * -ENOENT or clear ATA_EH_RESET.
+		 */
+		if (slave && (rc == 0 || rc == -ENOENT)) {
+			int tmp;
+
+			tmp = prereset(slave, deadline);
+			if (tmp != -ENOENT)
+				rc = tmp;
+
+			ehc->i.action |= sehc->i.action;
+		}
+
 		if (rc) {
 			if (rc == -ENOENT) {
 				ata_link_printk(link, KERN_DEBUG,
@@ -2298,25 +2344,51 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		else
 			ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
 
-		rc = ata_do_reset(link, reset, classes, deadline);
-		if (rc && rc != -EAGAIN)
+		rc = ata_do_reset(link, reset, classes, deadline, true);
+		if (rc && rc != -EAGAIN) {
+			failed_link = link;
 			goto fail;
+		}
+
+		/* hardreset slave link if existent */
+		if (slave && reset == hardreset) {
+			int tmp;
+
+			if (verbose)
+				ata_link_printk(slave, KERN_INFO,
+						"hard resetting link\n");
 
+			ata_eh_about_to_do(slave, NULL, ATA_EH_RESET);
+			tmp = ata_do_reset(slave, reset, classes, deadline,
+					   false);
+			switch (tmp) {
+			case -EAGAIN:
+				rc = -EAGAIN;
+			case 0:
+				break;
+			default:
+				failed_link = slave;
+				rc = tmp;
+				goto fail;
+			}
+		}
+
+		/* perform follow-up SRST if necessary */
 		if (reset == hardreset &&
 		    ata_eh_followup_srst_needed(link, rc, classes)) {
-			/* okay, let's do follow-up softreset */
 			reset = softreset;
 
 			if (!reset) {
 				ata_link_printk(link, KERN_ERR,
 						"follow-up softreset required "
 						"but no softreset avaliable\n");
+				failed_link = link;
 				rc = -EINVAL;
 				goto fail;
 			}
 
 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
-			rc = ata_do_reset(link, reset, classes, deadline);
+			rc = ata_do_reset(link, reset, classes, deadline, true);
 		}
 	} else {
 		if (verbose)
@@ -2337,7 +2409,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		dev->pio_mode = XFER_PIO_0;
 		dev->flags &= ~ATA_DFLAG_SLEEPING;
 
-		if (ata_link_offline(link))
+		if (ata_phys_link_offline(ata_dev_phys_link(dev)))
 			continue;
 
 		/* apply class override */
@@ -2350,6 +2422,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/* record current link speed */
 	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0)
 		link->sata_spd = (sstatus >> 4) & 0xf;
+	if (slave && sata_scr_read(slave, SCR_STATUS, &sstatus) == 0)
+		slave->sata_spd = (sstatus >> 4) & 0xf;
 
 	/* thaw the port */
 	if (ata_is_host_link(link))
@@ -2362,12 +2436,17 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 * reset and here.  This race is mediated by cross checking
 	 * link onlineness and classification result later.
 	 */
-	if (postreset)
+	if (postreset) {
 		postreset(link, classes);
+		if (slave)
+			postreset(slave, classes);
+	}
 
 	/* clear cached SError */
 	spin_lock_irqsave(link->ap->lock, flags);
 	link->eh_info.serror = 0;
+	if (slave)
+		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
 	/* Make sure onlineness and classification result correspond.
@@ -2377,19 +2456,21 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 * link onlineness and classification result, those conditions
 	 * can be reliably detected and retried.
 	 */
-	nr_known = 0;
+	nr_unknown = 0;
 	ata_link_for_each_dev(dev, link) {
 		/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
-		if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+		if (classes[dev->devno] == ATA_DEV_UNKNOWN) {
 			classes[dev->devno] = ATA_DEV_NONE;
-		else
-			nr_known++;
+			if (ata_phys_link_online(ata_dev_phys_link(dev)))
+				nr_unknown++;
+		}
 	}
 
-	if (classify && !nr_known && ata_link_online(link)) {
+	if (classify && nr_unknown) {
 		if (try < max_tries) {
 			ata_link_printk(link, KERN_WARNING, "link online but "
 				       "device misclassified, retrying\n");
+			failed_link = link;
 			rc = -EAGAIN;
 			goto fail;
 		}
@@ -2400,6 +2481,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 
 	/* reset successful, schedule revalidation */
 	ata_eh_done(link, NULL, ATA_EH_RESET);
+	if (slave)
+		ata_eh_done(slave, NULL, ATA_EH_RESET);
 	ehc->last_reset = jiffies;
 	ehc->i.action |= ATA_EH_REVALIDATE;
 
@@ -2407,6 +2490,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
  out:
 	/* clear hotplug flag */
 	ehc->i.flags &= ~ATA_EHI_HOTPLUGGED;
+	if (slave)
+		sehc->i.flags &= ~ATA_EHI_HOTPLUGGED;
 
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags &= ~ATA_PFLAG_RESETTING;
@@ -2427,7 +2512,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (time_before(now, deadline)) {
 		unsigned long delta = deadline - now;
 
-		ata_link_printk(link, KERN_WARNING,
+		ata_link_printk(failed_link, KERN_WARNING,
 			"reset failed (errno=%d), retrying in %u secs\n",
 			rc, DIV_ROUND_UP(jiffies_to_msecs(delta), 1000));
 
@@ -2435,8 +2520,13 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			delta = schedule_timeout_uninterruptible(delta);
 	}
 
-	if (rc == -EPIPE || try == max_tries - 1)
+	if (try == max_tries - 1) {
 		sata_down_spd_limit(link);
+		if (slave)
+			sata_down_spd_limit(slave);
+	} else if (rc == -EPIPE)
+		sata_down_spd_limit(failed_link);
+
 	if (hardreset)
 		reset = hardreset;
 	goto retry;
@@ -2468,7 +2558,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
 
-			if (ata_link_offline(link)) {
+			if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
 				rc = -EIO;
 				goto err;
 			}
@@ -2693,7 +2783,7 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 			/* This is the last chance, better to slow
 			 * down than lose it.
 			 */
-			sata_down_spd_limit(dev->link);
+			sata_down_spd_limit(ata_dev_phys_link(dev));
 			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
 		}
 	}
@@ -2703,7 +2793,7 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 		ata_dev_disable(dev);
 
 		/* detach if offline */
-		if (ata_link_offline(dev->link))
+		if (ata_phys_link_offline(ata_dev_phys_link(dev)))
 			ata_eh_detach_dev(dev);
 
 		/* schedule probe if necessary */
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index f6f9c28..e2cffe7 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -71,6 +71,7 @@ extern int atapi_passthru16;
 extern int libata_fua;
 extern int libata_noacpi;
 extern int libata_allow_tpm;
+extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
 extern void ata_force_cbl(struct ata_port *ap);
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
@@ -108,6 +109,8 @@ extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern bool ata_phys_link_online(struct ata_link *link);
+extern bool ata_phys_link_offline(struct ata_link *link);
 extern void ata_dev_init(struct ata_device *dev);
 extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
 extern int sata_link_init_spd(struct ata_link *link);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 67640ce..35333d8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -689,7 +689,8 @@ struct ata_port {
 	unsigned int		qc_active;
 	int			nr_active_links; /* #links with active qcs */
 
-	struct ata_link		link;	/* host default link */
+	struct ata_link		link;		/* host default link */
+	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
 
 	int			nr_pmp_links;	/* nr of available PMP links */
 	struct ata_link		*pmp_link;	/* array of PMP links */
@@ -895,6 +896,7 @@ extern void ata_port_disable(struct ata_port *);
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
+extern int ata_slave_link_init(struct ata_port *ap);
 extern int ata_host_start(struct ata_host *host);
 extern int ata_host_register(struct ata_host *host,
 			     struct scsi_host_template *sht);
@@ -1132,7 +1134,7 @@ static inline bool sata_pmp_attached(struct ata_port *ap)
 
 static inline int ata_is_host_link(const struct ata_link *link)
 {
-	return link == &link->ap->link;
+	return link == &link->ap->link || link == link->ap->slave_link;
 }
 #else /* CONFIG_SATA_PMP */
 static inline bool sata_pmp_supported(struct ata_port *ap)
@@ -1165,7 +1167,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
 	printk("%sata%u: "fmt, lv, (ap)->print_id , ##args)
 
 #define ata_link_printk(link, lv, fmt, args...) do { \
-	if (sata_pmp_attached((link)->ap)) \
+	if (sata_pmp_attached((link)->ap) || (link)->ap->slave_link)	\
 		printk("%sata%u.%02u: "fmt, lv, (link)->ap->print_id,	\
 		       (link)->pmp , ##args); \
 	else \
-- 
1.5.4.5

