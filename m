Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221824DCF9
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763495; cv=none; b=ABcxj/IQ9ktPoPq/10nkEq1XEBHvX27cjjzta/0blpPJrzISl+WelSk/koqYYlVA6NF81dlUedY39G11lGl9nhGSycZklk0iQuG/Wsj00ABlUjmHFfVP2Mvcl9Tkd4QxdQabqTdYsZB/b7bkXMC0CWtJPUj1tOXh5pPWIo6Bsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763495; c=relaxed/simple;
	bh=PfGOCFpTt3Z2xHneNdbAtQ3jo8QdVCZaRhRicKRg7x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgSLa+4G2PnPO5nDwdywVY3hSVdPzrvCeGNA+wnJNr83VUB86JZhfh7IDFXBrmQk0+2CoZ9Acqz/ZnGWggOEb029RbeSOT5qI6Vuy+VvO/s0UT9wyeQHnuOyea1ApW4ayYo7YJig6iPe1xA4m5d7YPU8AUa5bjmprgRKyyluysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox6Cfbuh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox6Cfbuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18496C4CEED;
	Thu, 21 Aug 2025 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755763494;
	bh=PfGOCFpTt3Z2xHneNdbAtQ3jo8QdVCZaRhRicKRg7x8=;
	h=From:To:Cc:Subject:Date:From;
	b=ox6CfbuhtLTcUYpdPDYWouXkLcuYtSwXSnZv+U/wzYSzAqWb1bUuohDHkXCJ7He3x
	 L5mgLWf73tR3Cm7y+z+gAlY4DIrRjVV0hKyxI2WTn6Kzl3YiRGDWXBQS78oGvDDEbJ
	 Wme07yJDD8cWxdbFEEZwsT5BCnNztUfjAly/2Nga7tQxvXiEF2EqAvBp0gc1JPL2sI
	 jIo3L+41khb/4aod9bj6aLAMlEQrBWiX74CtZPz74Lyks6D+P8tQzaKLB0UZ0CbqLa
	 ZCNks9dshWC4tFubW378IbKjYW7DNrrhWzz10U5QWwF6cGEVaytO4axmbTJzsBbjmf
	 xYUJywSNi4dew==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>
Subject: [PATCH] ata: ahci: Allow ignoring the external/hotplug capability of ports
Date: Thu, 21 Aug 2025 17:02:06 +0900
Message-ID: <20250821080206.62412-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
external ports") introduced disabling link power management (LPM) for
ports that are advertized as external/hotplug capable. This is necessary
to force the maximum power policy (ATA_LPM_MAX_POWER) onto the port link
to ensure that the hotplug capability of the port is functional.

However, doing so blindly for all ports can prevent systems from going
into a low power state, even if the external/hotplug ports on the system
are unused. E.g., a laptop may see the internal SATA slot of a docking
station as an external hotplug capable port, and in such case, the user
may prefer to not use the port and to privilege instead enabling LPM
to allow the laptop to transition to low power states.

Since there is no easy method to automatically detect such choice,
introduce the new mask_port_ext_map module parameter to allow a user to
ignore the external/hotplug capability of a port. The format for this
parameter value is identical to the format used for the mask_port_map
parameter: a mask can be defined for all AHCI adapters of a system or
for a particular adapters identified with their PCI IDs (bus:dev.func
format).

The function ahci_get_port_map_mask() is renamed to ahci_get_port_mask()
and modified to return a mask, either for the port map maks of an
adapter (to ignore ports) or for the external/hotplug capability of an
adapter ports. Differentiation between map_port_mask and
map_port_ext_mask is done by passing the parameter string to
ahci_get_port_mask() as a second argument.

To be consistent with this change, the function
ahci_apply_port_map_mask() is renamed ahci_port_mask() and changed to
return a mask value.

The mask for the external/hotplug capability for an adapter, if defined
by the map_port_ext_mask parameter, is stored in the new field
mask_port_ext_map of struct ahci_host_priv. ahci_mark_external_port() is
modified to not set the ATA_PFLAG_EXTERNAL flag for a port if
hpriv->mask_port_ext_map includes the number of the port. In such case,
an information message is printed to notify that the external/hotplug
capability is being ignored.

Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220465
Fixes: 4edf1505b76d ("ata: ahci: Disallow LPM policy control for external ports")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.c | 57 ++++++++++++++++++++++++++++++++--------------
 drivers/ata/ahci.h |  1 +
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e1c24bbacf64..f17325e9f914 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -689,40 +689,50 @@ MODULE_PARM_DESC(mask_port_map,
 		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
 		 "form \"domain:bus:dev.func\"");
 
-static void ahci_apply_port_map_mask(struct device *dev,
-				     struct ahci_host_priv *hpriv, char *mask_s)
+static char *ahci_mask_port_ext_map;
+module_param_named(mask_port_ext_map, ahci_mask_port_ext_map, charp, 0444);
+MODULE_PARM_DESC(mask_port_ext_map,
+		 "32-bits mask to ignore the external/hotplug capability of ports. "
+		 "Valid values are: "
+		 "\"<mask>\" to apply the same mask to all AHCI controller "
+		 "devices, and \"<pci_dev>=<mask>,<pci_dev>=<mask>,...\" to "
+		 "specify different masks for the controllers specified, "
+		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
+		 "form \"domain:bus:dev.func\"");
+
+static u32 ahci_port_mask(struct device *dev, char *mask_s)
 {
 	unsigned int mask;
 
 	if (kstrtouint(mask_s, 0, &mask)) {
 		dev_err(dev, "Invalid port map mask\n");
-		return;
+		return 0;
 	}
 
-	hpriv->mask_port_map = mask;
+	return mask;
 }
 
-static void ahci_get_port_map_mask(struct device *dev,
-				   struct ahci_host_priv *hpriv)
+static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
 {
 	char *param, *end, *str, *mask_s;
 	char *name;
+	u32 mask = 0;
 
-	if (!strlen(ahci_mask_port_map))
-		return;
+	if (!mask_p || !strlen(mask_p))
+		return 0;
 
-	str = kstrdup(ahci_mask_port_map, GFP_KERNEL);
+	str = kstrdup(mask_p, GFP_KERNEL);
 	if (!str)
-		return;
+		return 0;
 
 	/* Handle single mask case */
 	if (!strchr(str, '=')) {
-		ahci_apply_port_map_mask(dev, hpriv, str);
+		mask = ahci_port_mask(dev, str);
 		goto free;
 	}
 
 	/*
-	 * Mask list case: parse the parameter to apply the mask only if
+	 * Mask list case: parse the parameter to get the mask only if
 	 * the device name matches.
 	 */
 	param = str;
@@ -752,11 +762,13 @@ static void ahci_get_port_map_mask(struct device *dev,
 			param++;
 		}
 
-		ahci_apply_port_map_mask(dev, hpriv, mask_s);
+		mask = ahci_port_mask(dev, mask_s);
 	}
 
 free:
 	kfree(str);
+
+	return mask;
 }
 
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
@@ -782,8 +794,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 	}
 
 	/* Handle port map masks passed as module parameter. */
-	if (ahci_mask_port_map)
-		ahci_get_port_map_mask(&pdev->dev, hpriv);
+	hpriv->mask_port_map =
+		ahci_get_port_mask(&pdev->dev, ahci_mask_port_map);
+	hpriv->mask_port_ext_map =
+		ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext_map);
 
 	ahci_save_initial_config(&pdev->dev, hpriv);
 }
@@ -1757,11 +1771,20 @@ static void ahci_mark_external_port(struct ata_port *ap)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
-	/* mark external ports (hotplug-capable, eSATA) */
+	/*
+	 * Mark external ports (hotplug-capable, eSATA), unless we were asked to
+	 * ignore this feature.
+	 */
 	tmp = readl(port_mmio + PORT_CMD);
 	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
-	    (tmp & PORT_CMD_HPCP))
+	    (tmp & PORT_CMD_HPCP)) {
+		if (hpriv->mask_port_ext_map & (1U << ap->port_no)) {
+			ata_port_info(ap,
+				"Ignoring external/hotplug capability\n");
+			return;
+		}
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
+	}
 }
 
 static void ahci_update_initial_lpm_policy(struct ata_port *ap)
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2c10c8f440d1..267c144b7c60 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -330,6 +330,7 @@ struct ahci_host_priv {
 	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
 	u32			mask_port_map;	/* Mask of valid ports */
+	u32			mask_port_ext_map; /* Mask of ports ext feature */
 
 	void __iomem *		mmio;		/* bus-independent mem map */
 	u32			cap;		/* cap to use */
-- 
2.50.1

