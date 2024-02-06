Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1F1B949
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254059; cv=none; b=eAgc6ux/avJKXMnyr0sRMfXXYObkZPOC+oQ4uU8J327+5rcaLEUSZesfAfHNcbso6XJxN8gB5LOvOlHJ9S3aUTcwoM+uknMI0QLHveOPKBEQmtWrMJXYhkhw5/tXuL9PaHkf3IzyXCnOR+wb2mWVaIBaLPIes4LQ5ociAWOr4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254059; c=relaxed/simple;
	bh=9MGWFAs7sgQVDULmFL5uVDRT2VWDSFs6SCFgQwDALRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYU1nJh3xeeg58MV+T3GrmoeW582YV0dKkmEbYOWRFU+ihAv/FvHO2HU4/ro+yl3RY1gmrFK7hjeFsrlpPym+uap9MNmXiED9EJJ80oYId1oLxsmrvxCVB4HaTax39iMdovIBhe0Xen9bXOkXgJNxqpLF0klgi6rPVTucSckwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFDaNHu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFDaNHu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0660BC433C7;
	Tue,  6 Feb 2024 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707254058;
	bh=9MGWFAs7sgQVDULmFL5uVDRT2VWDSFs6SCFgQwDALRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFDaNHu95L/CAwG4plS4U+RznOGwTf68i1mFdSCU6V+ZeBW/uM5dVNSZl7l4PSGtE
	 /vebB20AxXP5bPiZHXl9W93Go2bvZIMqItIXRR/41Ct+7/dBj8I/qwgTc4Xtvh6+HT
	 QZNU/0xPqRkRJuiOxKfn1ufv1OW64gJSkh/JeTky7olnn3PF/81q7EUZU6emSFOx/P
	 MPFV66Pzm+MNjxtfQG2JogxjPd8+L0JaDP0rjuXEFqq9sppDls5MJuCgdYkwuUJj/Y
	 yGt3w5y5kKYS0WpuoUWQrLD8Mw6Mvca6ug1+zBXQaz5iSIfsCPm5gJ0v496OEYn60v
	 ViAqm166WOqhw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 1/5] ata: ahci: move marking of external port earlier
Date: Tue,  6 Feb 2024 22:13:42 +0100
Message-ID: <20240206211352.1664816-2-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>
References: <20240206211352.1664816-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the marking of an external port earlier in the call chain.
This is needed for further cleanups.
No functional change intended.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c    | 14 ++++++++++++++
 drivers/ata/libahci.c |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index da2e74fce2d9..aa58ce615e79 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1642,6 +1642,18 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_mark_external_port(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* mark esata ports */
+	tmp = readl(port_mmio + PORT_CMD);
+	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
+		ap->pflags |= ATA_PFLAG_EXTERNAL;
+}
+
 static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 					   struct ahci_host_priv *hpriv)
 {
@@ -1934,6 +1946,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
+		ahci_mark_external_port(ap);
+
 		ahci_update_initial_lpm_policy(ap, hpriv);
 
 		/* disabled/not-implemented port */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..fca376f03c9e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1280,10 +1280,8 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
 {
-	struct ahci_host_priv *hpriv = ap->host->private_data;
 	const char *emsg = NULL;
 	int rc;
-	u32 tmp;
 
 	/* make sure port is not active */
 	rc = ahci_deinit_port(ap, &emsg);
@@ -1291,11 +1289,6 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
 	ahci_port_clear_pending_irq(ap);
-
-	/* mark esata ports */
-	tmp = readl(port_mmio + PORT_CMD);
-	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
-		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
 void ahci_init_controller(struct ata_host *host)
-- 
2.43.0

