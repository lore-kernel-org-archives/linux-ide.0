Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC821CD1F
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527073; cv=none; b=h6n2e5y6I6xpgqIpm4AUt/nawRPdiqA2JTbPmcAWjog6ypwZM3e7bLZMX95cEZI1fNbbK7SXq4xx0omtU2E5DYcdc7XkdUAnnFELUbUxUeFvt03s0kYcpZx76tRWtCm/8BqSF9z1w8UpnEvJm+aVVKH896ho8gedSw37mS3p4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527073; c=relaxed/simple;
	bh=GsZ5hMCr8wj+Z//AY9u093jGVMu2+w+RblHTYRmoW54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8PkLjoGann1CPnFKyuo4LIm/exbPDLaUEwvoj/XASGNquxXsp9Oy+NM4ix2o6XkxaSaWXdtsbTsc7Jcb97Na4sT9SMOVTQETuq0v0bQl58GKQGEQuHdirOpEqMzLA9sPCul36jGRcbFdLren2dGIQ4McNI3q/8JCc1QNSJdRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+JzojL4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+JzojL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0ABC4CEE3;
	Thu,  3 Jul 2025 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751527073;
	bh=GsZ5hMCr8wj+Z//AY9u093jGVMu2+w+RblHTYRmoW54=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g+JzojL4UN/dh82hUC0r5s3fr6LjSfxfY7UXWeSp6YIOQt/VwTZSQHY7G+Qkk3Vtk
	 n4pOQpQ+Q2lPOUB8S/Z2YlFodmvD43Lk4s1KcZ7oCbSftgqYS/fY/82+5IT9K3Pzgc
	 fS1loV0xCYSUmlxAbEWEDR3XK09MW7kcyubYkwiyWzJktYhVWt9Z+ULegRn1NA+eMN
	 pqqzeFgF6H/U9kBTyOWSd5PyMAeb4eMd9MV7+Ioo1mDCa+SnMl6JeFAELV3AG5/jmf
	 dW+DTt/2As1tCm5y7SqMr3YG3LNZkBeyY1WEufkFYJ+yw8Evb7BshX9LCE7fBS9tjP
	 zvOjis4CnHxrQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/3] ata: libata-eh: Rename and make ata_set_mode() static
Date: Thu,  3 Jul 2025 16:15:41 +0900
Message-ID: <20250703071541.278243-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703071541.278243-1-dlemoal@kernel.org>
References: <20250703071541.278243-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ata_set_mode() is defined and used only in libata-eh.c.
Make this function static to libata-eh.c and rename it
ata_eh_set_mode() to make it clear where its definition is. This
renaming allows renaming ata_do_set_mode() to the simpler name
ata_set_mode().

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c   |  6 +++---
 drivers/ata/libata-eh.c     | 11 ++++++-----
 drivers/ata/libata.h        |  1 -
 drivers/ata/pata_optidma.c  |  4 +++-
 drivers/ata/pata_pcmcia.c   |  4 ++--
 drivers/ata/pata_pdc2027x.c |  2 +-
 drivers/ata/sata_sil.c      |  2 +-
 include/linux/libata.h      |  2 +-
 8 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fb06aef8e0f6..3bdd65bbff49 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3508,7 +3508,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
 }
 
 /**
- *	ata_do_set_mode - Program timings and issue SET FEATURES - XFER
+ *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@link: link on which timings will be programmed
  *	@r_failed_dev: out parameter for failed device
  *
@@ -3524,7 +3524,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
  *	0 on success, negative errno otherwise
  */
 
-int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
+int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
@@ -3605,7 +3605,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 		*r_failed_dev = dev;
 	return rc;
 }
-EXPORT_SYMBOL_GPL(ata_do_set_mode);
+EXPORT_SYMBOL_GPL(ata_set_mode);
 
 /**
  *	ata_wait_ready - wait for link to become ready
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0f9c30f9bc1e..e5fa61fb8a59 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3408,12 +3408,12 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 }
 
 /**
- *	ata_set_mode - Program timings and issue SET FEATURES - XFER
+ *	ata_eh_set_mode - Program timings and issue SET FEATURES - XFER
  *	@link: link on which timings will be programmed
  *	@r_failed_dev: out parameter for failed device
  *
  *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
- *	ata_set_mode() fails, pointer to the failing device is
+ *	ata_eh_set_mode() fails, pointer to the failing device is
  *	returned in @r_failed_dev.
  *
  *	LOCKING:
@@ -3422,7 +3422,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
+static int ata_eh_set_mode(struct ata_link *link,
+			   struct ata_device **r_failed_dev)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
@@ -3443,7 +3444,7 @@ int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	if (ap->ops->set_mode)
 		rc = ap->ops->set_mode(link, r_failed_dev);
 	else
-		rc = ata_do_set_mode(link, r_failed_dev);
+		rc = ata_set_mode(link, r_failed_dev);
 
 	/* if transfer mode has changed, set DUBIOUS_XFER on device */
 	ata_for_each_dev(dev, link, ENABLED) {
@@ -3926,7 +3927,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 		/* configure transfer mode if necessary */
 		if (ehc->i.flags & ATA_EHI_SETMODE) {
-			rc = ata_set_mode(link, &dev);
+			rc = ata_eh_set_mode(link, &dev);
 			if (rc)
 				goto rest_fail;
 			ehc->i.flags &= ~ATA_EHI_SETMODE;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 767a61f8ff89..135e1e5ee44e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -177,7 +177,6 @@ extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
-extern int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset,
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index dfc36b4ec9c6..cc876dc7a9d8 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -322,7 +322,9 @@ static int optidma_set_mode(struct ata_link *link, struct ata_device **r_failed)
 	u8 r;
 	int nybble = 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int rc  = ata_do_set_mode(link, r_failed);
+	int rc;
+
+	rc = ata_set_mode(link, r_failed);
 	if (rc == 0) {
 		pci_read_config_byte(pdev, 0x43, &r);
 
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 5b602206c522..cf3810933a27 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -46,7 +46,7 @@ static int pcmcia_set_mode(struct ata_link *link, struct ata_device **r_failed_d
 	struct ata_device *slave = &link->device[1];
 
 	if (!ata_dev_enabled(master) || !ata_dev_enabled(slave))
-		return ata_do_set_mode(link, r_failed_dev);
+		return ata_set_mode(link, r_failed_dev);
 
 	if (memcmp(master->id + ATA_ID_FW_REV,  slave->id + ATA_ID_FW_REV,
 			   ATA_ID_FW_REV_LEN + ATA_ID_PROD_LEN) == 0) {
@@ -58,7 +58,7 @@ static int pcmcia_set_mode(struct ata_link *link, struct ata_device **r_failed_d
 			ata_dev_disable(slave);
 		}
 	}
-	return ata_do_set_mode(link, r_failed_dev);
+	return ata_set_mode(link, r_failed_dev);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 6820c5597b14..a4ee3b92c9aa 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -387,7 +387,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
 	struct ata_device *dev;
 	int rc;
 
-	rc = ata_do_set_mode(link, r_failed);
+	rc = ata_set_mode(link, r_failed);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3a99f66198a9..1b6dc950a42a 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -351,7 +351,7 @@ static int sil_set_mode(struct ata_link *link, struct ata_device **r_failed)
 	u32 tmp, dev_mode[2] = { };
 	int rc;
 
-	rc = ata_do_set_mode(link, r_failed);
+	rc = ata_set_mode(link, r_failed);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 78a4addc6659..d092747be588 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1218,7 +1218,7 @@ extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
 extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
 			       bool enable);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
-extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
+int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
 extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
 
-- 
2.50.0

