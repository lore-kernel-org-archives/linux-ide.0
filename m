Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3D186287
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318442; cv=none; b=R6Ml2+Vx+VHlIqKkcTbcKv4chTKtouiujWiZarGQ4QvGKTbIYR/mDEsrNdh7ANSWl6zrNJ7iUN4kihL+N0wG4hCslgdyDnD9u+SkU5vOxCl/Xr26VFY4BEzEeu0W7TEZpf4/cZcK8i9Usckk1DKeUwiEtUhFo5shQRsSHxbFRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318442; c=relaxed/simple;
	bh=zODZT3gNeoqazju4ylpzD7kQ49rvQ7Cs33MWlubEqak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFQp9XtB1h7wVa+aETk8lKZampzD3ijyKSuYxoztFUmY8syK8ipvb+ePQReOnyeTINzxY27yHMbtA7qkJYSvYaNwPqKc2WMj/C4NpxadPf6l49ly/GQsYyPXQwiWhgeV9PH0/texF461F7G3o6N0hJiVKrMm78ydfEf8YDdHQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHQRIrjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHQRIrjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82818C4CEC6;
	Mon,  2 Sep 2024 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318441;
	bh=zODZT3gNeoqazju4ylpzD7kQ49rvQ7Cs33MWlubEqak=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SHQRIrjqSVpkYWhfUqjFpY89c/Qh1VV4fgcMCjpIjDlOatp/Nw0pmXwNCh1c8O5BM
	 T4H94nLCBnk+pp608rpHOJs0zEqfHENn/q2clxKMFv5Iq5wO01YQOfov36mRi46Wy3
	 sZWSF4kcXmR3etavf+quuqObHwAAvPBOqldNqMY2piiPl8342EJQQ5y7SgUVlfZ7WK
	 yJ3FSqTP0xQxh6H7rm9AkpaUfGyryrYwraOQpZLoBgZwnL2FUffL2s9XMA3jGYmKPV
	 fbzAbrfvDOuOZi4BxFt3zzySqQF6Vl3vUn7vRBQdOHVKBknx9PXC+hTJkQDVnAHvGp
	 WFlxd1RxJNO6w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 7/7] ata: libata: Improve CDL resource management
Date: Tue,  3 Sep 2024 08:07:15 +0900
Message-ID: <20240902230715.176522-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902230715.176522-1-dlemoal@kernel.org>
References: <20240902230715.176522-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ncq_sense_buf buffer field of struct ata_port is allocated and used
only for devices that support the Command Duration Limits (CDL) feature.
However, the cdl buffer of struct ata_device, which is used to cache the
command duration limits log page for devices supporting CDL is always
allocated as part of struct ata_device, which is wasteful of memory for
devices that do not support this feature.

Clean this up by defining both buffers as part of the new ata_cdl
structure and allocating this structure only for devices that support
the CDL feature. This new structure is attached to struct ata_device
using the cdl pointer.

The functions ata_dev_init_cdl_resources() and
ata_dev_cleanup_cdl_resources() are defined to manage this new structure
allocation, initialization and cleanup when a port is removed or a
device disabled. ata_dev_init_cdl_resources() is called from
ata_dev_config_cdl() only for devices that support CDL.
ata_dev_cleanup_cdl_resources() is called from ata_port_free() and
ata_eh_dev_disable() to free the ata_cdl structure when a device is
being disabled by EH or its port being removed.

Note that the name of the former cdl log buffer of struct ata_device is
changed to desc_log_buf to make it clearer that it is a buffer for the
limit descriptors log page.

This change reduces the size of struct ata_device, thus reducing memory
usage for ATA devices that do not support the CDL feature.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 73 ++++++++++++++++++++++++++-------------
 drivers/ata/libata-eh.c   |  2 ++
 drivers/ata/libata-sata.c |  2 +-
 drivers/ata/libata-scsi.c |  2 +-
 drivers/ata/libata.h      |  1 +
 include/linux/libata.h    | 21 ++++++++---
 6 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 32325a1c07af..afc245b2f7cc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2464,12 +2464,40 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_TRUSTED;
 }
 
+static int ata_dev_init_cdl_resources(struct ata_device *dev)
+{
+	struct ata_cdl *cdl = dev->cdl;
+	unsigned int err_mask;
+
+	if (!cdl) {
+		cdl = kzalloc(sizeof(*cdl), GFP_KERNEL);
+		if (!cdl)
+			return -ENOMEM;
+		dev->cdl = cdl;
+	}
+
+	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, cdl->desc_log_buf,
+				     ATA_LOG_CDL_SIZE / ATA_SECT_SIZE);
+	if (err_mask) {
+		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
+{
+	kfree(dev->cdl);
+	dev->cdl = NULL;
+}
+
 static void ata_dev_config_cdl(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->link->ap;
 	unsigned int err_mask;
 	bool cdl_enabled;
 	u64 val;
+	int ret;
 
 	if (ata_id_major_version(dev->id) < 11)
 		goto not_supported;
@@ -2564,37 +2592,20 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 		}
 	}
 
-	/*
-	 * Allocate a buffer to handle reading the sense data for successful
-	 * NCQ Commands log page for commands using a CDL with one of the limit
-	 * policy set to 0xD (successful completion with sense data available
-	 * bit set).
-	 */
-	if (!ap->ncq_sense_buf) {
-		ap->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
-		if (!ap->ncq_sense_buf)
-			goto not_supported;
-	}
-
-	/*
-	 * Command duration limits is supported: cache the CDL log page 18h
-	 * (command duration descriptors).
-	 */
-	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, dev->sector_buf, 1);
-	if (err_mask) {
-		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
+	/* CDL is supported: allocate and initialize needed resources. */
+	ret = ata_dev_init_cdl_resources(dev);
+	if (ret) {
+		ata_dev_warn(dev, "Initialize CDL resources failed\n");
 		goto not_supported;
 	}
 
-	memcpy(dev->cdl, dev->sector_buf, ATA_LOG_CDL_SIZE);
 	dev->flags |= ATA_DFLAG_CDL;
 
 	return;
 
 not_supported:
 	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
-	kfree(ap->ncq_sense_buf);
-	ap->ncq_sense_buf = NULL;
+	ata_dev_cleanup_cdl_resources(dev);
 }
 
 static int ata_dev_config_lba(struct ata_device *dev)
@@ -5446,12 +5457,19 @@ EXPORT_SYMBOL_GPL(ata_port_alloc);
 
 void ata_port_free(struct ata_port *ap)
 {
+	struct ata_device *dev;
+	struct ata_link *link;
+
 	if (!ap)
 		return;
 
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ALL)
+			ata_dev_cleanup_cdl_resources(dev);
+	}
+
 	kfree(ap->pmp_link);
 	kfree(ap->slave_link);
-	kfree(ap->ncq_sense_buf);
 	ida_free(&ata_ida, ap->print_id);
 	kfree(ap);
 }
@@ -6000,6 +6018,13 @@ static void ata_port_detach(struct ata_port *ap)
 	ata_port_wait_eh(ap);
 
 	mutex_lock(&ap->scsi_scan_mutex);
+
+	/* Cleanup CDL device resources */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ALL)
+			ata_dev_cleanup_cdl_resources(dev);
+	}
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	/* Remove scsi devices */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ed535e1b4225..41f1bee0b434 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -500,6 +500,8 @@ static void ata_eh_dev_disable(struct ata_device *dev)
 	ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 | ATA_DNXFER_QUIET);
 	dev->class++;
 
+	ata_dev_cleanup_cdl_resources(dev);
+
 	/* From now till the next successful probe, ering is used to
 	 * track probe failures.  Clear accumulated device error info.
 	 */
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 498430db86f7..c8b119a06bb2 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1505,7 +1505,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 {
 	struct ata_device *dev = link->device;
 	struct ata_port *ap = dev->link->ap;
-	u8 *buf = ap->ncq_sense_buf;
+	u8 *buf = dev->cdl->ncq_sense_log_buf;
 	struct ata_queued_cmd *qc;
 	unsigned int err_mask, tag;
 	u8 *sense, sk = 0, asc = 0, ascq = 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a3ffce4b218d..7fed924d6561 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2259,7 +2259,7 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
 static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
 					     u8 spg)
 {
-	u8 *b, *cdl = dev->cdl, *desc;
+	u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
 	u32 policy;
 	int i;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2a9d1bbf2482..0f4c6e26fe50 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -89,6 +89,7 @@ extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern const char *sata_spd_string(unsigned int spd);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
+void ata_dev_cleanup_cdl_resources(struct ata_device *dev);
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index aac38dcd2230..9b4a6ff03235 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -700,6 +700,21 @@ struct ata_cpr_log {
 	struct ata_cpr		cpr[] __counted_by(nr_cpr);
 };
 
+struct ata_cdl {
+	/*
+	 * Buffer to cache the CDL log page 18h (command duration descriptors)
+	 * for SCSI-ATA translation.
+	 */
+	u8			desc_log_buf[ATA_LOG_CDL_SIZE];
+
+	/*
+	 * Buffer to handle reading the sense data for successful NCQ Commands
+	 * log page for commands using a CDL with one of the limits policy set
+	 * to 0xD (successful completion with sense data available bit set).
+	 */
+	u8			ncq_sense_log_buf[ATA_LOG_SENSE_NCQ_SIZE];
+};
+
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
@@ -762,8 +777,8 @@ struct ata_device {
 	/* Concurrent positioning ranges */
 	struct ata_cpr_log	*cpr_log;
 
-	/* Command Duration Limits log support */
-	u8			cdl[ATA_LOG_CDL_SIZE];
+	/* Command Duration Limits support */
+	struct ata_cdl		*cdl;
 
 	/* error history */
 	int			spdn_cnt;
@@ -917,8 +932,6 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
-	/* owned by EH */
-	u8			*ncq_sense_buf;
 };
 
 /* The following initializer overrides a method to NULL whether one of
-- 
2.46.0

