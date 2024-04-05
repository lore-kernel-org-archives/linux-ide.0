Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3D1DFE4
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321507; cv=none; b=o6aAz9fLS5mUTEgCdGc8j+mPVQxqyjybd3pk87RmmF3rV6G172qDA7IuVNRxqBeB8o8q1T1tXELqbQip6bSgbd9bS1sezdIyyvCfhgKV3IN4Y8PZsJmtdhd3ctyBHZT2u/skPczsFbZgMItDtzJ7qXxM3xtqjeClqS8u1FXtE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321507; c=relaxed/simple;
	bh=eJsqu/B0DnKxPdcP/B8nZ4fNfWRHaxyj5Xrg2TBjXV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjwWNXGvxMz72df4qI/81hVfABsuL3OKNmtyEYymkVC8EuTLuZCq6FU5A9ufNm1sAmTigd9cHjbwFj1WUuvL7LdC9TTC05ndVeXwpd8EgEqH9AEL20dB9niIkTKlozpVU7/C+NX145BtgwO0RMgBagVNTlPETfgeG4HRkPqO21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkOopfbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkOopfbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A1AC433F1;
	Fri,  5 Apr 2024 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321505;
	bh=eJsqu/B0DnKxPdcP/B8nZ4fNfWRHaxyj5Xrg2TBjXV4=;
	h=From:To:Cc:Subject:Date:From;
	b=KkOopfbiGAK0RfKVTdQeyFwhkJX/2950E+Sa0fdO+SEjYIPsp8S6HvFepPPfsBYCO
	 18DJOSjv86A3RyaWKXg81bLkQ02eR0B4nlf2PMLRTCAfGADLqY15UKUZXi0wdVths8
	 Ddi9bdyMJl8HQjdP2xdb6zZL20z3+uJph1n/kupknmauN9osfpmf4am7iLchy79zAc
	 Enq9rGB+w35zDdZSGB3fXrbSn+hNcAP//bPS0VCslMtb+kH8ppzSPMb9o6c+HlpEaF
	 +FBGuD/NGdgV3EW4Q2Mlwh0Eiu0Cz9kvYhZYFSfi0WEorB0otDOIobbx1D0HFNymqY
	 lZUpH0jsrjHtA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Szuying Chen <chensiying21@gmail.com>,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw
Subject: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Date: Fri,  5 Apr 2024 21:51:43 +0900
Message-ID: <20240405125143.1134539-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commits 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
and 9815e3961754 ("ahci: asm1064: correct count of reported ports")
attempted to limit the ports of the ASM1166 and ASM1064 AHCI controllers
to avoid long boot times caused by the fact that these adapters report
a port map larger than the number of physical ports. The excess ports
are "virtual" to hide port multiplier devices and probing these ports
takes time. However, these commits caused a regression for users that do
use PMP devices, as the ATA devices connected to the PMP cannot be
scanned. These commits have thus been reverted by commit 6cd8adc3e18
("ahci: asm1064: asm1166: don't limit reported ports") to allow the
discovery of devices connected through a port multiplier. But this
revert re-introduced the long boot times for users that do not use a
port multiplier setup.

This patch adds the mask_port_map ahci module parameter to allow users
to manually specify port map masks for controllers. In the case of the
ASMedia 1166 and 1064 controllers, users that do not have port
multiplier devices can mask the excess virtual ports exposed by the
controller to speedup port scanning, thus reducing boot time.

The mask_port_map parameter accepts 2 different formats:
 - mask_port_map=<mask>
   This applies the same mask to all AHCI controllers
   present in the system. This format is convenient for small systems
   that have only a single AHCI controller.
 - mask_port_map=<pci_dev>=<mask>,<pci_dev>=mask,...
   This applies the specified masks only to the PCI device listed. The
   <pci_dev> field is a regular PCI device ID (domain:bus:dev.func).
   This ID can be seen following "ahci" in the kernel messages. E.g.
   for "ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)", the
   <pci_dev> field is "0000:01:00.0".

When used, the kerenl messages indicate that a port map mask was forced.
E.g.: without a mask:
modrpobe ahci
dmesg | grep ahci
...
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ahci 0000:00:17.0: (0000:00:17.0) 8/8 ports implemented (port mask 0xff)

With a mask:

modrpobe ahci mask_port_map=0000:00:17.0=0x1
dmesg | grep ahci
...
ahci 0000:00:17.0: masking port_map 0xff -> 0x1
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ahci 0000:00:17.0: (0000:00:17.0) 1/8 ports implemented (port mask 0x1)

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 562302e2e57c..6548f10e61d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -666,6 +666,87 @@ static int mobile_lpm_policy = -1;
 module_param(mobile_lpm_policy, int, 0644);
 MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 
+static char *ahci_mask_port_map;
+module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);
+MODULE_PARM_DESC(mask_port_map,
+		 "32-bits port map masks to ignore controllers ports. "
+		 "Valid values are: "
+		 "\"<mask>\" to apply the same mask to all AHCI controller "
+		 "devices, and \"<pci_dev>=<mask>,<pci_dev>=<mask>,...\" to "
+		 "specify different masks for the controllers specified, "
+		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
+		 "form \"domain:bus:dev.func\"");
+
+static void ahci_apply_port_map_mask(struct device *dev,
+				     struct ahci_host_priv *hpriv, char *mask_s)
+{
+	unsigned int mask;
+
+	if (kstrtouint(mask_s, 0, &mask)) {
+		dev_err(dev, "Invalid port map mask\n");
+		return;
+	}
+
+	hpriv->mask_port_map = mask;
+}
+
+static void ahci_get_port_map_mask(struct device *dev,
+				   struct ahci_host_priv *hpriv)
+{
+	char *param, *end, *str, *mask_s;
+	char *name;
+
+	if (!strlen(ahci_mask_port_map))
+		return;
+
+	str = kstrdup(ahci_mask_port_map, GFP_KERNEL);
+	if (!str)
+		return;
+
+	/* Handle single mask case */
+	if (!strchr(str, '=')) {
+		ahci_apply_port_map_mask(dev, hpriv, str);
+		goto free;
+	}
+
+	/*
+	 * Mask list case: parse the parameter to apply the mask only if
+	 * the device name matches.
+	 */
+	param = str;
+	end = param + strlen(param);
+	while (param && param < end && *param) {
+		name = param;
+		param = strchr(name, '=');
+		if (!param)
+			break;
+
+		*param = '\0';
+		param++;
+		if (param >= end)
+			break;
+
+		if (strcmp(dev_name(dev), name) != 0) {
+			param = strchr(param, ',');
+			if (param)
+				param++;
+			continue;
+		}
+
+		mask_s = param;
+		param = strchr(mask_s, ',');
+		if (param) {
+			*param = '\0';
+			param++;
+		}
+
+		ahci_apply_port_map_mask(dev, hpriv, mask_s);
+	}
+
+free:
+	kfree(str);
+}
+
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
@@ -688,6 +769,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 			  "Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.\n");
 	}
 
+	/* Handle port map masks passed as module parameter. */
+	if (ahci_mask_port_map)
+		ahci_get_port_map_mask(&pdev->dev, hpriv);
+
 	ahci_save_initial_config(&pdev->dev, hpriv);
 }
 
-- 
2.44.0

