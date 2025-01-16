Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CAC24A7C9
	for <linux-ide@vger.kernel.org>; Thu, 16 Jan 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038203; cv=none; b=tYkP5xmi8lVBzI79K9phYeLmcn8qour6953HnfeLbwMZAjaxpECD5UczJeYFzWbrLjTAJj3/TD27pPWxNjXREBfimo+47oId4YrPKypqzvtycA7QrcFy8cP+CVVrSyEXM6DvpiOmBndivbtZnzfnPu4llNaxRn9ClYcnlv5DFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038203; c=relaxed/simple;
	bh=/tOcBxi6eN1XGS4tekULbdwD/6S8e+v3bnrFkDG4XW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNidwqo/ykXs6bx4Ue8pDa5/L3R0ayups/cR79BSHM+06QcpO5F7DGo9blsI+GmYfniI6G8CviIhl7Ecm2NtYz/R4l5FIEsTsHjE07dpidrc3h9tKickon2scju9fON3vHdojg2jv86QNGspnAHsw119LBknVHEQcXxVc1J04cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uywHp8h/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uywHp8h/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123E3C4CEE1;
	Thu, 16 Jan 2025 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038203;
	bh=/tOcBxi6eN1XGS4tekULbdwD/6S8e+v3bnrFkDG4XW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uywHp8h/SYnaBW/VosWS9h5te7p6fdSkJe6lOx7jXoJHx9jSr1iM7OGy+kYws9/OY
	 f/n79dCAB8pWS1ur51DFOLqGina57vRvtR9tS4VtIdWgDgW/v2Ld9Q5UnssgOBqpXj
	 aO0Ru/wxTM6jD1BLceCWH2ua1IP8baCf/ocLZvp8ZVh3SjH3TW8445W8GY/Jsxlgw+
	 KiwKzJ3hGPC8g5AqmHUjmDaGItVVE5BpMxX39FBsyVXb/Gp0b2A833H+1AVmbeptId
	 t3ebyR0M3s4yyvHGzBbgrFgsM8qpf6Ol+v/EigCyeKcUty7T0psSt/+FX6BqVjFn8t
	 XSTwAF97ZVwKQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: ahci: Add external_port_map module parameter
Date: Thu, 16 Jan 2025 15:36:33 +0100
Message-ID: <20250116143630.1935474-6-cassel@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116143630.1935474-4-cassel@kernel.org>
References: <20250116143630.1935474-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937; i=cassel@kernel.org; h=from:subject; bh=/tOcBxi6eN1XGS4tekULbdwD/6S8e+v3bnrFkDG4XW0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI7JfMVqyZsytOvq2CIydn82mrn4qyXVzhEimtbmt7MW uV+/dLSjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkVRbD/6ik94HzeGbypVew c1W91nssp+3beWFdX0DwEre3LxJmSjD8lbwi7Cx0q9fHviUowFvdyeXtzodXncVUckP/cTvPDLf jAQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
changed so that LPM is not enabled on external ports (hotplug-capable or
eSATA ports).

This is because hotplug and LPM are mutually exclusive, see 7.3.1 Hot Plug
Removal Detection and Power Management Interaction in AHCI 1.3.1.

This does require that firmware has set the appropate bits (HPCP or ESP)
in PxCMD (which is a per port register in the AHCI controller).

If the firmware has failed to mark a port as hotplug-capable or eSATA in
PxCMD, then there is currently not much the user can do.

If LPM is enabled on the port, hotplug insertions and removals will not be
detected on that port.

In order to allow a user to fix up broken firmware, add a module parameter
'external_port_map' for the 'ahci' driver.

The external_port_map parameter accepts 2 different formats:
 - external_port_map=<map>
   This applies the same map to all AHCI controllers
   present in the system. This format is convenient for small systems
   that have only a single AHCI controller.
 - external_port_map=<pci_dev>=<map>,<pci_dev>=map,...
   This applies the specified maps only to the PCI device listed. The
   <pci_dev> field is a regular PCI device ID (domain:bus:dev.func).
   This ID can be seen following "ahci" in the kernel messages. E.g.
   for "ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)", the
   <pci_dev> field is "0000:01:00.0".

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 92b08d3a0c3c..ec2bc5f17b96 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -676,6 +676,17 @@ MODULE_PARM_DESC(mask_port_map,
 		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
 		 "form \"domain:bus:dev.func\"");
 
+static char *ahci_external_port_map;
+module_param_named(external_port_map, ahci_external_port_map, charp, 0444);
+MODULE_PARM_DESC(external_port_map,
+		 "32-bits port map to force set one or more ports as external. "
+		 "Valid values are: "
+		 "\"<map>\" to apply the same map to all AHCI controller "
+		 "devices, and \"<pci_dev>=<map>,<pci_dev>=<map>,...\" to "
+		 "specify different maps for the controllers specified, "
+		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
+		 "form \"domain:bus:dev.func\"");
+
 typedef void (*port_map_callback_t)(struct device *dev,
 				    struct ahci_host_priv *hpriv, char *mask_s);
 
@@ -758,6 +769,34 @@ static void ahci_get_port_map_mask(struct device *dev,
 				 ahci_apply_port_map_mask);
 }
 
+static void ahci_apply_external_port_map(struct device *dev,
+					 struct ahci_host_priv *hpriv,
+					 char *mask_s)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	unsigned long port_map;
+	unsigned int map;
+	int i;
+
+	if (kstrtouint(mask_s, 0, &map)) {
+		dev_err(dev, "Invalid external port map\n");
+		return;
+	}
+
+	port_map = map;
+	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
+		if (i < host->n_ports)
+			host->ports[i]->pflags |= ATA_PFLAG_EXTERNAL;
+	}
+}
+
+static void ahci_get_external_port_map(struct device *dev,
+				       struct ahci_host_priv *hpriv)
+{
+	ahci_get_port_map_helper(dev, hpriv, ahci_external_port_map,
+				 ahci_apply_external_port_map);
+}
+
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
@@ -2020,6 +2059,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
+	/* Handle external port map passed as module parameter. */
+	if (ahci_external_port_map)
+		ahci_get_external_port_map(&pdev->dev, hpriv);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-- 
2.48.0

