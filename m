Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2D2264A3
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010858; cv=none; b=KDlx3OosH3It2BhOQ7Bk8UJwX8d6dvZ2YJOUYYlRaEIyeMuO0XD9+8AYub/NzYPD44fKhe2OB9ntYyw4Q6ioK0aBkSS7xiUTaSzOy0XOCrrsUOxybGP92KxVjJqhCMqu8S6VvQeWifITAsdvbIfAmDaIPtNAuk3yf64JsR2i4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010858; c=relaxed/simple;
	bh=aHfoKr/Jz+LWxQNgCiQHnsuVZ6cZI6hPbUUzdA3nfxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O78yuy25isRUoDqXoIJa5qV2/7i2cggd2XylW7WsGq2LMOspIXmSSW2KdmuuEJfIdHA2pBF48Fy/F0IACkTFDl6APxa92q5L9Lf/DO9EibkTkK65vZ7gpcYy5iKYBWKf/itV+bDhjL/ETp056kI1AK8PAABPvDaqkR4ECzW9kLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxSdl4hb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxSdl4hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FF6C4CEE3;
	Fri, 27 Jun 2025 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010857;
	bh=aHfoKr/Jz+LWxQNgCiQHnsuVZ6cZI6hPbUUzdA3nfxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxSdl4hbzPwtxQ2Qvy3IvCte7dafDWdfac9XxFjoEUhM6NsZahPCpj3jaANwolYnv
	 ArprkMPM40c/3r7UECJ+o/GQlkbCKlA7nw183MrIwmONBDd0rDnTf2zTCd8s/YnCoA
	 1MuTD1Wxj4R9GMnQKkEwPH/go6xuB3SGbcCXZuc/x8t1lX1WQdVaPa6v5NEs2rDOr7
	 s5FwYYw215/0shqyPzsJnqiqiIr5lfB6yX7oAQ2S3Mg+t6rLTQCEqpWKZAxVT3IxkR
	 9FZ8oEcpbdJEt4KHRntzrChPwuNfzFvnRhv6tRN9ofPb5IseoXXT/26FIc55p3J2fz
	 KFcw4Wr6imu7A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 2/6] ata: libata-scsi: Cleanup ata_scsi_offline_dev()
Date: Fri, 27 Jun 2025 16:52:03 +0900
Message-ID: <20250627075207.23969-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627075207.23969-1-dlemoal@kernel.org>
References: <20250627075207.23969-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the function ata_scsi_offline_dev() to return a bool and change
this function kdoc comment to have the correct mention of its call site.
No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 15 +++++++--------
 drivers/ata/libata.h      |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ccd7651710be..b502b123008a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4633,24 +4633,23 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
  *	ata_scsi_offline_dev - offline attached SCSI device
  *	@dev: ATA device to offline attached SCSI device for
  *
- *	This function is called from ata_eh_hotplug() and responsible
- *	for taking the SCSI device attached to @dev offline.  This
- *	function is called with host lock which protects dev->sdev
- *	against clearing.
+ *	This function is called from ata_eh_detach_dev() and is responsible for
+ *	taking the SCSI device attached to @dev offline.  This function is
+ *	called with host lock which protects dev->sdev against clearing.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  *
  *	RETURNS:
- *	1 if attached SCSI device exists, 0 otherwise.
+ *	true if attached SCSI device exists, false otherwise.
  */
-int ata_scsi_offline_dev(struct ata_device *dev)
+bool ata_scsi_offline_dev(struct ata_device *dev)
 {
 	if (dev->sdev) {
 		scsi_device_set_state(dev->sdev, SDEV_OFFLINE);
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /**
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 48ee7acb87af..8e68f4556962 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -144,7 +144,7 @@ extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      const struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
-extern int ata_scsi_offline_dev(struct ata_device *dev);
+extern bool ata_scsi_offline_dev(struct ata_device *dev);
 extern bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq);
 extern void ata_scsi_set_sense(struct ata_device *dev,
 			       struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
-- 
2.50.0

