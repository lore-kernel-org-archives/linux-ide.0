From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata-hp-prep: implement sata_phy_debounce()
Date: Wed, 31 May 2006 20:05:42 +0900
Message-ID: <11490735421080-git-send-email-htejun@gmail.com>
References: <1149073540186-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:58797 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964974AbWEaLF4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:05:56 -0400
Received: by nz-out-0102.google.com with SMTP id s18so5549nze
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:05:56 -0700 (PDT)
In-Reply-To: <1149073540186-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With hotplug, PHY always needs to be debounced before a reset as any
reset might find new devices.  Extract PHY waiting code from
sata_phy_resume() and extend it to include SStatus debouncing.  Note
that sata_phy_debounce() is superset of what used to be done inside
sata_phy_resume().

Three default debounce timing parameters are defined to be used by
hot/boot plug.  As resume failure during probing will be properly
handled as errors, timeout doesn't have to be long as before.
probeinit() uses the same timeout to retain the original behavior.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  107 ++++++++++++++++++++++++++++++++++++++------
 include/linux/libata.h     |    6 ++
 2 files changed, 99 insertions(+), 14 deletions(-)

d7bb4cc7575929a60b0a718daa1bce87bea9a9cc
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a9f79b4..4823ece 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,6 +61,11 @@ #include <asm/byteorder.h>
 
 #include "libata.h"
 
+/* debounce timing parameters in msecs { interval, duration, timeout } */
+const unsigned long sata_deb_timing_boot[]		= {   5,  100, 2000 };
+const unsigned long sata_deb_timing_eh[]		= {  25,  500, 2000 };
+const unsigned long sata_deb_timing_before_fsrst[]	= { 100, 2000, 5000 };
+
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
@@ -2427,10 +2432,81 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
-static int sata_phy_resume(struct ata_port *ap)
+/**
+ *	sata_phy_debounce - debounce SATA phy status
+ *	@ap: ATA port to debounce SATA phy status for
+ *	@params: timing parameters { interval, duratinon, timeout } in msec
+ *
+ *	Make sure SStatus of @ap reaches stable state, determined by
+ *	holding the same value where DET is not 1 for @duration polled
+ *	every @interval, before @timeout.  Timeout constraints the
+ *	beginning of the stable state.  Because, after hot unplugging,
+ *	DET gets stuck at 1 on some controllers, this functions waits
+ *	until timeout then returns 0 if DET is stable at 1.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
 {
-	unsigned long timeout = jiffies + (HZ * 5);
-	u32 scontrol, sstatus;
+	unsigned long interval_msec = params[0];
+	unsigned long duration = params[1] * HZ / 1000;
+	unsigned long timeout = jiffies + params[2] * HZ / 1000;
+	unsigned long last_jiffies;
+	u32 last, cur;
+	int rc;
+
+	if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
+		return rc;
+	cur &= 0xf;
+
+	last = cur;
+	last_jiffies = jiffies;
+
+	while (1) {
+		msleep(interval_msec);
+		if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
+			return rc;
+		cur &= 0xf;
+
+		/* DET stable? */
+		if (cur == last) {
+			if (cur == 1 && time_before(jiffies, timeout))
+				continue;
+			if (time_after(jiffies, last_jiffies + duration))
+				return 0;
+			continue;
+		}
+
+		/* unstable, start over */
+		last = cur;
+		last_jiffies = jiffies;
+
+		/* check timeout */
+		if (time_after(jiffies, timeout))
+			return -EBUSY;
+	}
+}
+
+/**
+ *	sata_phy_resume - resume SATA phy
+ *	@ap: ATA port to resume SATA phy for
+ *	@params: timing parameters { interval, duratinon, timeout } in msec
+ *
+ *	Resume SATA phy of @ap and debounce it.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_phy_resume(struct ata_port *ap, const unsigned long *params)
+{
+	u32 scontrol;
 	int rc;
 
 	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
@@ -2441,16 +2517,12 @@ static int sata_phy_resume(struct ata_po
 	if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
 		return rc;
 
-	/* Wait for phy to become ready, if necessary. */
-	do {
-		msleep(200);
-		if ((rc = sata_scr_read(ap, SCR_STATUS, &sstatus)))
-			return rc;
-		if ((sstatus & 0xf) != 1)
-			return 0;
-	} while (time_before(jiffies, timeout));
+	/* Some PHYs react badly if SStatus is pounded immediately
+	 * after resuming.  Delay 200ms before debouncing.
+	 */
+	msleep(200);
 
-	return -EBUSY;
+	return sata_phy_debounce(ap, params);
 }
 
 /**
@@ -2468,8 +2540,10 @@ static int sata_phy_resume(struct ata_po
  */
 void ata_std_probeinit(struct ata_port *ap)
 {
+	static const unsigned long deb_timing[] = { 5, 100, 5000 };
+
 	/* resume link */
-	sata_phy_resume(ap);
+	sata_phy_resume(ap, deb_timing);
 
 	/* wait for device */
 	if (ata_port_online(ap))
@@ -2585,7 +2659,7 @@ int sata_std_hardreset(struct ata_port *
 	msleep(1);
 
 	/* bring phy back */
-	sata_phy_resume(ap);
+	sata_phy_resume(ap, sata_deb_timing_eh);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
@@ -5718,6 +5792,9 @@ u32 ata_wait_register(void __iomem *reg,
  * Do not depend on ABI/API stability.
  */
 
+EXPORT_SYMBOL_GPL(sata_deb_timing_boot);
+EXPORT_SYMBOL_GPL(sata_deb_timing_eh);
+EXPORT_SYMBOL_GPL(sata_deb_timing_before_fsrst);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
@@ -5757,6 +5834,8 @@ EXPORT_SYMBOL_GPL(ata_bmdma_error_handle
 EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_set_spd);
+EXPORT_SYMBOL_GPL(sata_phy_debounce);
+EXPORT_SYMBOL_GPL(sata_phy_resume);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c0513c7..1c167f7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -607,11 +607,17 @@ struct ata_timing {
 
 #define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
 
+extern const unsigned long sata_deb_timing_boot[];
+extern const unsigned long sata_deb_timing_eh[];
+extern const unsigned long sata_deb_timing_before_fsrst[];
+
 extern void ata_port_probe(struct ata_port *);
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 extern int sata_set_spd(struct ata_port *ap);
+extern int sata_phy_debounce(struct ata_port *ap, const unsigned long *param);
+extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
 extern int ata_drive_probe_reset(struct ata_port *ap,
 			ata_probeinit_fn_t probeinit,
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
1.3.2


