From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata: clean up constants
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885161447-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:54728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751350AbWDAKsm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:42 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210246nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:42 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* Reorder ATA_DFLAG_* such that feature flags determined by
  ata_dev_configure() are on lower bits.  Reserve lower eight bits
  for this purpose and allocate dynamic flags from bit 8.

* Reorder ATA_FLAG_* such that feature flags determined during driver
  initiailization are on bits 0:15, dynamic flags on 16:23 and LLDD
  specific flags on 24:31.

* Rename ATA_FLAG_PORT_DISABLED to ATA_FLAG_DISABLED for consistency.
  (ATA_FLAG_* are always about ports).

* Kill trailing white space and lower-case an one line comment for
  consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c  |   18 ++++++------
 drivers/scsi/libata-scsi.c  |    2 +
 drivers/scsi/pdc_adma.c     |    4 +--
 drivers/scsi/sata_mv.c      |    2 +
 drivers/scsi/sata_nv.c      |    2 +
 drivers/scsi/sata_promise.c |    2 +
 drivers/scsi/sata_qstor.c   |    4 +--
 drivers/scsi/sata_sil24.c   |    2 +
 drivers/scsi/sata_sx4.c     |    2 +
 drivers/scsi/sata_vsc.c     |    2 +
 include/linux/libata.h      |   62 +++++++++++++++++++++++--------------------
 11 files changed, 53 insertions(+), 49 deletions(-)

100a767c9b63a902301def9c45f9f258f382223a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 402c0e4..0df994d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1045,7 +1045,7 @@ ata_exec_internal(struct ata_port *ap, s
 	 *
 	 * Kill the following code as soon as those drivers are fixed.
 	 */
-	if (ap->flags & ATA_FLAG_PORT_DISABLED) {
+	if (ap->flags & ATA_FLAG_DISABLED) {
 		err_mask |= AC_ERR_SYSTEM;
 		ata_port_probe(ap);
 	}
@@ -1395,7 +1395,7 @@ static int ata_bus_probe(struct ata_port
 	} else {
 		ap->ops->phy_reset(ap);
 
-		if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
+		if (!(ap->flags & ATA_FLAG_DISABLED))
 			for (i = 0; i < ATA_MAX_DEVICES; i++)
 				classes[i] = ap->device[i].class;
 
@@ -1491,7 +1491,7 @@ static int ata_bus_probe(struct ata_port
 
 void ata_port_probe(struct ata_port *ap)
 {
-	ap->flags &= ~ATA_FLAG_PORT_DISABLED;
+	ap->flags &= ~ATA_FLAG_DISABLED;
 }
 
 /**
@@ -1565,7 +1565,7 @@ void __sata_phy_reset(struct ata_port *a
 	else
 		ata_port_disable(ap);
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
@@ -1590,7 +1590,7 @@ void __sata_phy_reset(struct ata_port *a
 void sata_phy_reset(struct ata_port *ap)
 {
 	__sata_phy_reset(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 	ata_bus_reset(ap);
 }
@@ -1629,7 +1629,7 @@ void ata_port_disable(struct ata_port *a
 {
 	ap->device[0].class = ATA_DEV_NONE;
 	ap->device[1].class = ATA_DEV_NONE;
-	ap->flags |= ATA_FLAG_PORT_DISABLED;
+	ap->flags |= ATA_FLAG_DISABLED;
 }
 
 /**
@@ -2262,7 +2262,7 @@ static unsigned int ata_bus_softreset(st
  *	Obtains host_set lock.
  *
  *	SIDE EFFECTS:
- *	Sets ATA_FLAG_PORT_DISABLED if bus reset fails.
+ *	Sets ATA_FLAG_DISABLED if bus reset fails.
  */
 
 void ata_bus_reset(struct ata_port *ap)
@@ -4457,7 +4457,7 @@ irqreturn_t ata_interrupt (int irq, void
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -4678,7 +4678,7 @@ static void ata_host_init(struct ata_por
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
 
-	ap->flags = ATA_FLAG_PORT_DISABLED;
+	ap->flags = ATA_FLAG_DISABLED;
 	ap->id = host->unique_id;
 	ap->host = host;
 	ap->ctl = ATA_DEVCTL_OBS;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index bcbf71e..096bdff 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2728,7 +2728,7 @@ void ata_scsi_scan_host(struct ata_port 
 	struct ata_device *dev;
 	unsigned int i;
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 3c85c4b..d64073d 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -456,7 +456,7 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		handled = 1;
 		adma_enter_reg_mode(ap);
-		if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))
+		if (ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))
 			continue;
 		pp = ap->private_data;
 		if (!pp || pp->state != adma_state_pkt)
@@ -481,7 +481,7 @@ static inline unsigned int adma_intr_mmi
 	for (port_no = 0; port_no < host_set->n_ports; ++port_no) {
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
-		if (ap && (!(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)))) {
+		if (ap && (!(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR)))) {
 			struct ata_queued_cmd *qc;
 			struct adma_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != adma_state_mmio)
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 0f7d334..e9152f8 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1397,7 +1397,7 @@ static void mv_host_intr(struct ata_host
 			}
 		}
 
-		if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))
+		if (ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))
 			continue;
 
 		err_mask = ac_err_mask(ata_status);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index f77bf18..72721ac 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -280,7 +280,7 @@ static irqreturn_t nv_interrupt (int irq
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index cc928c6..9557c7a 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -534,7 +534,7 @@ static irqreturn_t pdc_interrupt (int ir
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
 		if (tmp && ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 9ffe1ef..8ef042a 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -396,7 +396,7 @@ static inline unsigned int qs_intr_pkt(s
 					sff1, sff0, port_no, sHST, sDST);
 			handled = 1;
 			if (ap && !(ap->flags &
-				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
+				    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
@@ -429,7 +429,7 @@ static inline unsigned int qs_intr_mmio(
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 068c98a..c34f6da 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -770,7 +770,7 @@ static irqreturn_t sil24_interrupt(int i
 	for (i = 0; i < host_set->n_ports; i++)
 		if (status & (1 << i)) {
 			struct ata_port *ap = host_set->ports[i];
-			if (ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
+			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 				sil24_host_intr(host_set->ports[i]);
 				handled++;
 			} else
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index ae70f60..3af28ef 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -834,7 +834,7 @@ static irqreturn_t pdc20621_interrupt (i
 		tmp = mask & (1 << i);
 		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
 		if (tmp && ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 836bbbb..cecc1f7 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -222,7 +222,7 @@ static irqreturn_t vsc_sata_interrupt (i
 			ap = host_set->ports[i];
 
 			if (ap && !(ap->flags &
-				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
+				    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 036b737..9f942d4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -120,9 +120,11 @@ enum {
 	ATA_SHT_USE_CLUSTERING	= 1,
 
 	/* struct ata_device stuff */
-	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
-	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
+	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
+	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
+
+	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -132,32 +134,34 @@ enum {
 	ATA_DEV_NONE		= 5,	/* no device */
 
 	/* struct ata_port flags */
-	ATA_FLAG_SLAVE_POSS	= (1 << 1), /* host supports slave dev */
+	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
-	ATA_FLAG_PORT_DISABLED	= (1 << 2), /* port is disabled, ignore it */
-	ATA_FLAG_SATA		= (1 << 3),
-	ATA_FLAG_NO_LEGACY	= (1 << 4), /* no legacy mode check */
-	ATA_FLAG_SRST		= (1 << 5), /* (obsolete) use ATA SRST, not E.D.D. */
-	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
-	ATA_FLAG_SATA_RESET	= (1 << 7), /* (obsolete) use COMRESET */
-	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
-	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
-					     * proper HSM is in place. */
-	ATA_FLAG_DEBUGMSG	= (1 << 10),
-	ATA_FLAG_NO_ATAPI	= (1 << 11), /* No ATAPI support */
-
-	ATA_FLAG_SUSPENDED	= (1 << 12), /* port is suspended */
-
-	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
-	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
-
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* Flush port task */
-
-	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
-	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
-	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
+	ATA_FLAG_SATA		= (1 << 1),
+	ATA_FLAG_NO_LEGACY	= (1 << 2), /* no legacy mode check */
+	ATA_FLAG_MMIO		= (1 << 3), /* use MMIO, not PIO */
+	ATA_FLAG_SRST		= (1 << 4), /* (obsolete) use ATA SRST, not E.D.D. */
+	ATA_FLAG_SATA_RESET	= (1 << 5), /* (obsolete) use COMRESET */
+	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
+	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
+	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
+	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
+
+	ATA_FLAG_NOINTR		= (1 << 16), /* FIXME: Remove this once
+					      * proper HSM is in place. */
+	ATA_FLAG_DEBUGMSG	= (1 << 17),
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 18), /* flush port task */
+
+	ATA_FLAG_DISABLED	= (1 << 19), /* port is disabled, ignore it */
+	ATA_FLAG_SUSPENDED	= (1 << 20), /* port is suspended */
+
+	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
+
+	/* struct ata_queued_cmd flags */
+	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
+	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
+	ATA_QCFLAG_SINGLE	= (1 << 2), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
-	ATA_QCFLAG_EH_SCHEDULED = (1 << 5), /* EH scheduled */
+	ATA_QCFLAG_EH_SCHEDULED = (1 << 3), /* EH scheduled */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
@@ -206,8 +210,8 @@ enum {
 	/* size of buffer to pad xfers ending on unaligned boundaries */
 	ATA_DMA_PAD_SZ		= 4,
 	ATA_DMA_PAD_BUF_SZ	= ATA_DMA_PAD_SZ * ATA_MAX_QUEUE,
-	
-	/* Masks for port functions */
+
+	/* masks for port functions */
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
-- 
1.2.4


