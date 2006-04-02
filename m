From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/15] libata: rename ATA_FLAG_PORT_DISABLED to ATA_FLAG_DISABLED
Date: Sun, 2 Apr 2006 18:51:52 +0900
Message-ID: <11439715123616-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:48058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932312AbWDBJwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:05 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447005nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:05 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Rename ATA_FLAG_PORT_DISABLED to ATA_FLAG_DISABLED for consistency.
(ATA_FLAG_* are always about ports).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c  |   18 +++++++++---------
 drivers/scsi/libata-scsi.c  |    2 +-
 drivers/scsi/pdc_adma.c     |    4 ++--
 drivers/scsi/sata_mv.c      |    2 +-
 drivers/scsi/sata_nv.c      |    2 +-
 drivers/scsi/sata_promise.c |    2 +-
 drivers/scsi/sata_qstor.c   |    4 ++--
 drivers/scsi/sata_sil24.c   |    2 +-
 drivers/scsi/sata_sx4.c     |    2 +-
 drivers/scsi/sata_vsc.c     |    2 +-
 include/linux/libata.h      |    2 +-
 11 files changed, 21 insertions(+), 21 deletions(-)

2b19632cea54d24625d42ff36b87e89ff36ffe05
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 120f9cd..3a5eb5e 100644
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
@@ -2251,7 +2251,7 @@ static unsigned int ata_bus_softreset(st
  *	Obtains host_set lock.
  *
  *	SIDE EFFECTS:
- *	Sets ATA_FLAG_PORT_DISABLED if bus reset fails.
+ *	Sets ATA_FLAG_DISABLED if bus reset fails.
  */
 
 void ata_bus_reset(struct ata_port *ap)
@@ -4463,7 +4463,7 @@ irqreturn_t ata_interrupt (int irq, void
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -4684,7 +4684,7 @@ static void ata_host_init(struct ata_por
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
index b7488a3..890262f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -150,7 +150,7 @@ enum {
 	ATA_FLAG_DEBUGMSG	= (1 << 17),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 18), /* flush port task */
 
-	ATA_FLAG_PORT_DISABLED	= (1 << 19), /* port is disabled, ignore it */
+	ATA_FLAG_DISABLED	= (1 << 19), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 20), /* port is suspended */
 
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
-- 
1.2.4


