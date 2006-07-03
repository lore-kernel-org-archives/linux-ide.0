From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/11] libata: clean up debounce parameters and improve parameter selection
Date: Mon, 3 Jul 2006 16:07:26 +0900
Message-ID: <11519104461358-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:16620 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750922AbWGCHGu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:50 -0400
Received: by wr-out-0506.google.com with SMTP id 71so571501wri
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:50 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The names of predefined debounce timing parameters didn't exactly
match their usages.  Rename to more generic names and implement param
selection helper sata_ehc_deb_timing() which uses EHI_HOTPLUGGED to
select params.

Combined with the previous EHI_RESUME_LINK differentiation, this makes
parameter selection accurate.  e.g. user scan resumes link but normal
deb param is used instead of hotplug param.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   25 +++++++++++--------------
 drivers/scsi/sata_sil24.c  |    2 +-
 include/linux/libata.h     |   15 ++++++++++++---
 3 files changed, 24 insertions(+), 18 deletions(-)

c392a0ecdc783060afead43fef27bb8a939c02d3
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3d6e41b..988f385 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -62,9 +62,9 @@ #include <asm/byteorder.h>
 #include "libata.h"
 
 /* debounce timing parameters in msecs { interval, duration, timeout } */
-const unsigned long sata_deb_timing_boot[]		= {   5,  100, 2000 };
-const unsigned long sata_deb_timing_eh[]		= {  25,  500, 2000 };
-const unsigned long sata_deb_timing_before_fsrst[]	= { 100, 2000, 5000 };
+const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
+const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
+const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
@@ -2580,7 +2580,7 @@ static void ata_wait_spinup(struct ata_p
 
 	/* first, debounce phy if SATA */
 	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_debounce(ap, sata_deb_timing_eh);
+		rc = sata_phy_debounce(ap, sata_deb_timing_hotplug);
 
 		/* if debounced successfully and offline, no need to wait */
 		if ((rc == 0 || rc == -EOPNOTSUPP) && ata_port_offline(ap))
@@ -2616,7 +2616,7 @@ static void ata_wait_spinup(struct ata_p
 int ata_std_prereset(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
-	const unsigned long *timing;
+	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
 	/* handle link resume & hotplug spinup */
@@ -2634,11 +2634,6 @@ int ata_std_prereset(struct ata_port *ap
 
 	/* if SATA, resume phy */
 	if (ap->cbl == ATA_CBL_SATA) {
-		if (ap->pflags & ATA_PFLAG_LOADING)
-			timing = sata_deb_timing_boot;
-		else
-			timing = sata_deb_timing_eh;
-
 		rc = sata_phy_resume(ap, timing);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
@@ -2726,6 +2721,8 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
+	struct ata_eh_context *ehc = &ap->eh_context;
+	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	u32 scontrol;
 	int rc;
 
@@ -2763,7 +2760,7 @@ int sata_std_hardreset(struct ata_port *
 	msleep(1);
 
 	/* bring phy back */
-	sata_phy_resume(ap, sata_deb_timing_eh);
+	sata_phy_resume(ap, timing);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
@@ -5844,9 +5841,9 @@ u32 ata_wait_register(void __iomem *reg,
  * Do not depend on ABI/API stability.
  */
 
-EXPORT_SYMBOL_GPL(sata_deb_timing_boot);
-EXPORT_SYMBOL_GPL(sata_deb_timing_eh);
-EXPORT_SYMBOL_GPL(sata_deb_timing_before_fsrst);
+EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
+EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
+EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index b5f8fa9..fa3268d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -607,7 +607,7 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_phy_debounce(ap, sata_deb_timing_before_fsrst);
+	rc = sata_phy_debounce(ap, sata_deb_timing_long);
 	if (rc) {
 		reason = "PHY debouncing failed";
 		goto err;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4d4ed2c..2f7bbfc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -629,9 +629,18 @@ struct ata_timing {
 
 #define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
 
-extern const unsigned long sata_deb_timing_boot[];
-extern const unsigned long sata_deb_timing_eh[];
-extern const unsigned long sata_deb_timing_before_fsrst[];
+extern const unsigned long sata_deb_timing_normal[];
+extern const unsigned long sata_deb_timing_hotplug[];
+extern const unsigned long sata_deb_timing_long[];
+
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
+		return sata_deb_timing_hotplug;
+	else
+		return sata_deb_timing_normal;
+}
 
 extern void ata_port_probe(struct ata_port *);
 extern void __sata_phy_reset(struct ata_port *ap);
-- 
1.3.2


