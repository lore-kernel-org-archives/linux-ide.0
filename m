From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/13] libata-hp: add hotplug flags and flag handling functions
Date: Tue, 11 Apr 2006 23:06:22 +0900
Message-ID: <11447643824116-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:36020 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750841AbWDKOG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:28 -0400
Received: by wproxy.gmail.com with SMTP id i11so930347wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:28 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ap->hotplug_flags field, define ATA_HOTPLUG_*, ATA_DFLAG_DETACH_*
and flag manipulation functions.

As ap->hotplug_flags will be accessed by EH and SCSI hotplug work
simultaneosly, changes should be atomic.  Define functions to
manipulate ap->hostplug_flags - ata_set_hotplug_flags(),
ata_clr_hotplug_flags() and ata_schedule_probe(), which is a shortcut
for setting ATA_HOTPLUG_PROBE, a common operation for LLDDs.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

a0d2a754a788df7a123013480a3295d0c61c0940
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 94f1e9a..2a93c44 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -130,6 +130,9 @@ enum {
 	ATA_DFLAG_FAILED	= (1 << 9), /* device has failed */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
+	ATA_DFLAG_DETACH_ATA	= (1 << 16), /* detach ATA device */
+	ATA_DFLAG_DETACH_SCSI	= (1 << 17), /* detach SCSI device */
+
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
@@ -161,9 +164,15 @@ enum {
 	ATA_FLAG_DISABLED	= (1 << 19), /* port is disabled, ignore it */
 	ATA_FLAG_FROZEN		= (1 << 20), /* port is frozen */
 	ATA_FLAG_SUSPENDED	= (1 << 21), /* port is suspended (power) */
-
 	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
 
+	/* struct ata_port hotplug_flags */
+	ATA_HOTPLUG_RUNNING	= (1 << 0), /* hotplugging online */
+	ATA_HOTPLUG_PROBE	= (1 << 1), /* probe requested */
+	ATA_HOTPLUG_DID_PROBE	= (1 << 2), /* already probed in this run */
+	ATA_HOTPLUG_SCSI_PLUG	= (1 << 3), /* SCSI hotplug scheduled */
+	ATA_HOTPLUG_SCSI_UNPLUG	= (1 << 4), /* SCSI hotunplug scheduled */
+
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
@@ -471,6 +480,8 @@ struct ata_port {
 	u32			msg_enable;
 	struct list_head	eh_done_q;
 
+	unsigned long		hotplug_flags;
+
 	void			*private_data;
 };
 
@@ -800,6 +811,30 @@ static inline unsigned int ata_dev_absen
 	return ata_class_absent(dev->class);
 }
 
+/* hotplug flag manipulation helpers */
+static inline void ata_set_hotplug_flags(struct ata_port *ap,
+					 unsigned int flags)
+{
+	unsigned long old;
+	do {
+		old = ap->hotplug_flags;
+	} while (cmpxchg(&ap->hotplug_flags, old, old | flags) != old);
+}
+
+static inline void ata_clr_hotplug_flags(struct ata_port *ap,
+					 unsigned int flags)
+{
+	unsigned long old;
+	do {
+		old = ap->hotplug_flags;
+	} while (cmpxchg(&ap->hotplug_flags, old, old & ~flags) != old);
+}
+
+static inline void ata_schedule_probe(struct ata_port *ap)
+{
+	ata_set_hotplug_flags(ap, ATA_HOTPLUG_PROBE);
+}
+
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
-- 
1.2.4


