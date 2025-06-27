Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CA18027
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986842; cv=none; b=cbOc88IZTep4Uzb8ZgGm4ICMjmnGlEgD8x1xKtrk6tSYKAi1JG2VNpWNdEtdTA1VehQied7AZeVckhiScKPJl0WAWmC44oVM0atGuLrFh8zehz12jqQ7AxoGDFeDmx+LsnO0yU+N6nKLf3Q4Fu55HHbf+xdGoHdc0iYHnOqydPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986842; c=relaxed/simple;
	bh=ctqJZtjxzbGbnJwbx3l5nKZKVvi3j2FrkZPj86+8xGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSFOmklWk+zppu6J0Cjs/7m+XIiEagMEMeCsnZGl4EDUyfBrSq7m2fpBhFBRNAYv2TDmFqYJiAkwaemgZpmN+y0Gi28rSmDOwDSIW2vihqYncp46ejTolYO0D5Qx/g6Lh7A8y+RW1+pEas9cnStK6LKRqA6vn4POzab/xFq0mhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwCDme4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwCDme4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2F5C4CEEB;
	Fri, 27 Jun 2025 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986841;
	bh=ctqJZtjxzbGbnJwbx3l5nKZKVvi3j2FrkZPj86+8xGU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HwCDme4lXf/OSL/PQu+/2L1CeN4dbGv+TowY6+6l0YCD87v1fZg2677AwHHlP4Ds+
	 FKAz0bfDgGZ2xkR70gEd6Qsli+g635upz4q8yh1lzu+1Vf81O4m7wv0I8Lp5qLHOK5
	 8uyI6W8jbrW3brpj27vvLV2qI44CqA0UG2qbj1Nqmw+WlkqFG9MUzeRMZSNRr7Zxhp
	 RxOFMTzXPd/bvMm5OGY8vvDhWyB+cmS0YounaQ5sNOJYN4ispLniblOibHiz4NHYi1
	 YSH5+vtCxRA2Luz4O/RuR39VZNNiEKqr6xr6u4KU5V7oeYmrbsc66zLImkddJteChz
	 EoME3mgw0dnFw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/6] ata: libata-scsi: Cleanup ata_scsi_offline_dev()
Date: Fri, 27 Jun 2025 10:11:51 +0900
Message-ID: <20250627011155.701125-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627011155.701125-1-dlemoal@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
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
2.49.0

