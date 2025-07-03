Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C92E03F3
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539115; cv=none; b=FxfQ4nPTnYDKOaoNoreLzUt+tFnnZstsmKA0yY3/yE505KhermOEDT3vmWaViyelJ6FlChr208AdAuo5e2N5bAxelbks7/o0uX4U3NWlvNvkaUu2Ub6/19LEmPTs4x/nl0vI/+PYQtWcbVFGv+QO4OJX3YGa8fMXFsL+flX3uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539115; c=relaxed/simple;
	bh=PcRd6rVG/MOjwFu69An4J3kDqqXqt84b26IzLNSpG9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW0LwJskxR8BvpvbW+jy8h2iswczAMOwRPeH7PIRrD3E56xzBhz3v3i/e/JPKA3za31mfkLsUzBb8ZDKbwdjwg6CR2mW7485vfQG4pQyfXQ+lLn0xDmvkQzQk8RnXi9DmVCg7ZhReqFLSW4Ub/g4/BF8ViPOh2/5ES6GEUgLYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saeJC0nS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saeJC0nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24716C4CEED;
	Thu,  3 Jul 2025 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539115;
	bh=PcRd6rVG/MOjwFu69An4J3kDqqXqt84b26IzLNSpG9w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=saeJC0nSxoxewAwRFLmLqE+MCR62r+yIXuR1yO0QxpM0XfVicND++AdNdhB45gUxj
	 N/v9DnT8HMUlx6Sd+bl8qmpX1zHu5D7wYPT5rtDlKuwJVZvOxk70Nfatq79wtRmReG
	 CA02/UPrQCvDJPLCkEZ1GXvSvhpWWfndzAV+om4aV9ZHTtzqnh+nIzLtBK1GzAF1ph
	 /d3S7E+FHM3LZRDe7DRPFy3VajnjjFwaVtz+aujw5dhIW6sgovDM4n7jUD3S5Vsq7P
	 G92o/cP9Q1FawxOh061mDDHWLcxNHFKSfMjRlzVBN1ABNvM7RJqmYasnehKAQoR2H3
	 FddcbixgF8AAg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 4/4] ata: libata-core: Rename ata_do_set_mode()
Date: Thu,  3 Jul 2025 19:36:22 +0900
Message-ID: <20250703103622.291272-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703103622.291272-1-dlemoal@kernel.org>
References: <20250703103622.291272-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the renaming of libata-eh ata_set_mode() function to
ata_eh_set_mode(), libata-core function ata_do_set_mode() can now be
renamed to the simpler ata_set_mode().

All the call sites of the former ata_do_set_mode() are updated to use
the new function name.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c   | 6 +++---
 drivers/ata/libata-eh.c     | 2 +-
 drivers/ata/pata_optidma.c  | 4 +++-
 drivers/ata/pata_pcmcia.c   | 4 ++--
 drivers/ata/pata_pdc2027x.c | 2 +-
 drivers/ata/sata_sil.c      | 2 +-
 include/linux/libata.h      | 2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 72abd2996e9c..bbf1318a2b9a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3510,7 +3510,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
 }
 
 /**
- *	ata_do_set_mode - Program timings and issue SET FEATURES - XFER
+ *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@link: link on which timings will be programmed
  *	@r_failed_dev: out parameter for failed device
  *
@@ -3526,7 +3526,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
  *	0 on success, negative errno otherwise
  */
 
-int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
+int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
@@ -3607,7 +3607,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 		*r_failed_dev = dev;
 	return rc;
 }
-EXPORT_SYMBOL_GPL(ata_do_set_mode);
+EXPORT_SYMBOL_GPL(ata_set_mode);
 
 /**
  *	ata_wait_ready - wait for link to become ready
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8b2a0a56ffe1..e5fa61fb8a59 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3444,7 +3444,7 @@ static int ata_eh_set_mode(struct ata_link *link,
 	if (ap->ops->set_mode)
 		rc = ap->ops->set_mode(link, r_failed_dev);
 	else
-		rc = ata_do_set_mode(link, r_failed_dev);
+		rc = ata_set_mode(link, r_failed_dev);
 
 	/* if transfer mode has changed, set DUBIOUS_XFER on device */
 	ata_for_each_dev(dev, link, ENABLED) {
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

