Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEC136671
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657472; cv=none; b=n/D3fvkKbVgtykjx4HW1c0mF5ihy1bAJ3kVpnLheuvq1uGMFliEu0HuenKdB6E2rZxImp0OSpTXXLmiISnUpr0pMBMVlx1VD4+IIvykp6SvVmjDkGdlKMnYnhh3XbguC6Gb5gVHwzSalse6w2hvpTHpDpzfZABMMWZFhVQqxoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657472; c=relaxed/simple;
	bh=pOp3VQtjrm2eHf4OQPtuColveo4cfiRiUSwAvoEyqsw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIdQgBVpvinpeP4+GbaqXhp3tce1wOsF/d4xEl9sHpE4g9jfXZlEN0SavaGmEkBDlS9VPwtadFpH9zGf58zGoMzwfgw0rAg3OkCWdyxOnbP2ntGQH95DzKQM0DduNBfzv3zPeffPR332Llzy3Nas6L5Zc/5hZgfOBJ7BUGHN1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob2T2oI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob2T2oI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F4AC8CDC4;
	Mon, 26 Aug 2024 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724657471;
	bh=pOp3VQtjrm2eHf4OQPtuColveo4cfiRiUSwAvoEyqsw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ob2T2oI4zCtOCqn6dj8/27o3TDdVBNPkf3OEMjuVRhWwtkn6tzvbVsxKT4avQH2b8
	 0R6LHKdO6T37SMfMhFGVaNI4zbQDMJSs43t8zdII2Wky3YEYyytVWT5CDChpPRy9d5
	 jPxtmNAwhsTyVLm6fQ49RTVDOQKqWXYP3hRjk+a2ErWL6igK8ua/SprM9IAfThUOAl
	 uYFyRKh5JzsyrIvrR7BOldipv+1msLfA1tLCrwfel7UjeiEm+RfwOLTa8jTrwXWupy
	 rk6S7osui3dfqtJzabjfamwKMLBaq3Hzq6Rq1rrWFxxTOLTrLAvqrlEpYUDvyIwrb4
	 Kwt8kax7ktWHQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6/7] ata: libata: Move ncq_sense_buf to struct ata_device
Date: Mon, 26 Aug 2024 16:31:05 +0900
Message-ID: <20240826073106.56918-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826073106.56918-1-dlemoal@kernel.org>
References: <20240826073106.56918-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ncq_sense_buf buffer field of struct ata_port is allocated and used
only for devices that support command duration limits. So move this
field out of struct ata_port and into struct ata_device together with
the CDL log buffer.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c      | 11 +++++------
 drivers/ata/libata-sata.c      |  2 +-
 drivers/ata/libata-transport.c |  3 +++
 include/linux/libata.h         |  4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b5a051bbb01f..6a1d300dd1f5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2581,9 +2581,9 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 	 * policy set to 0xD (successful completion with sense data available
 	 * bit set).
 	 */
-	if (!ap->ncq_sense_buf) {
-		ap->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
-		if (!ap->ncq_sense_buf)
+	if (!dev->ncq_sense_buf) {
+		dev->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
+		if (!dev->ncq_sense_buf)
 			goto not_supported;
 	}
 
@@ -2604,8 +2604,8 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 
 not_supported:
 	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
-	kfree(ap->ncq_sense_buf);
-	ap->ncq_sense_buf = NULL;
+	kfree(dev->ncq_sense_buf);
+	dev->ncq_sense_buf = NULL;
 }
 
 static int ata_dev_config_lba(struct ata_device *dev)
@@ -5462,7 +5462,6 @@ void ata_port_free(struct ata_port *ap)
 
 	kfree(ap->pmp_link);
 	kfree(ap->slave_link);
-	kfree(ap->ncq_sense_buf);
 	ida_free(&ata_ida, ap->print_id);
 	kfree(ap);
 }
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 020893da900d..50ea254a213d 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1505,7 +1505,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 {
 	struct ata_device *dev = link->device;
 	struct ata_port *ap = dev->link->ap;
-	u8 *buf = ap->ncq_sense_buf;
+	u8 *buf = dev->ncq_sense_buf;
 	struct ata_queued_cmd *qc;
 	unsigned int err_mask, tag;
 	u8 *sense, sk = 0, asc = 0, ascq = 0;
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 474816a9efa1..14f50c91ceb9 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -671,6 +671,9 @@ static int ata_tdev_match(struct attribute_container *cont,
  */
 static void ata_tdev_free(struct ata_device *dev)
 {
+	kfree(dev->ncq_sense_buf);
+	dev->ncq_sense_buf = NULL;
+
 	transport_destroy_device(&dev->tdev);
 	put_device(&dev->tdev);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e07a9b5d45df..3fb6980c8aa1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -762,7 +762,8 @@ struct ata_device {
 	/* Concurrent positioning ranges */
 	struct ata_cpr_log	*cpr_log;
 
-	/* Command Duration Limits log support */
+	/* Command Duration Limits support */
+	u8			*ncq_sense_buf;
 	u8			cdl[ATA_LOG_CDL_SIZE];
 
 	/* error history */
@@ -915,7 +916,6 @@ struct ata_port {
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
 	/* owned by EH */
-	u8			*ncq_sense_buf;
 	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
 
-- 
2.46.0

