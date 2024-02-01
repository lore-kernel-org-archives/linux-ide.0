Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00564158D73
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804118; cv=none; b=uPHE+VQkZnDaMFct1rkifpJf2eCpEVvk+jIeKJ8hrLpd/tHIVQNaSW1Oyaq5HruZGR7m/jJywGTBeh4G4YjB2Nhku5R9WjMQ34VYK6bzMxz/3MZKTDMUYig6I/AgAil80luyjTOmkBZkQ18uomBNKVtOAD03HRIRiIaya10bVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804118; c=relaxed/simple;
	bh=ss0CgCSGqJtxG8cq+VJKPbm8uJb7XnxKb1ZGSpoRX04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grqwSbC8S4icR66RHAxVn0kgKpAUV1LFNbMWAaJ+ihGW6muWZJ1KttW1STJWw5vH4nsu+J2lY9FBN5lG8A6Y4RLKmeGoxCaM68PZXca6ErGB9Gibu025t4udD+rR5Uxm19N3ZqEw6KDYI9xlqfJBR4nwt0msaU1toX7ucrCrGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIHlRH2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIHlRH2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0001DC433F1;
	Thu,  1 Feb 2024 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804117;
	bh=ss0CgCSGqJtxG8cq+VJKPbm8uJb7XnxKb1ZGSpoRX04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIHlRH2smMVmsfP5S+U7OdnnU67iL8aZFzjJAardw+XGMjZw2iPyTBJ8s4y5olAhg
	 LhIGPrei7vzjkZvTKfxINvvrH87qDtQBURpWOGGVk3BgoqugYoer7+g2GZ4oW9Xvgi
	 /sy0AalwerM/tat1LCxPfmmKd5qxmXLTMfU/Tq2r+ktddKBpaZhVPB2fbd+fbkoNVO
	 uXjEAfMIi7puCi7rB0Tu1pT0xeArbJd5crAtmRG4oSMnUa2Vx9R3fB1FUWoTyGpJpz
	 yPAPbAfUU8yZufLdAgewzyHpm4IRWKM6KYovVZa6PxPpP+LkPO4z201BYNRKprP4aB
	 KJNC5L2sr096A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/5] ata: ahci: move marking of external port earlier
Date: Thu,  1 Feb 2024 17:14:58 +0100
Message-ID: <20240201161507.1147521-2-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201161507.1147521-1-cassel@kernel.org>
References: <20240201161507.1147521-1-cassel@kernel.org>
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

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c    | 14 ++++++++++++++
 drivers/ata/libahci.c |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index da2e74fce2d9..157ab88bdf75 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1642,6 +1642,17 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_mark_external_port(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
+		ap->pflags |= ATA_PFLAG_EXTERNAL;
+}
+
 static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 					   struct ahci_host_priv *hpriv)
 {
@@ -1934,6 +1945,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
+		/* mark esata ports */
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

