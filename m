Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86138F7D
	for <linux-ide@vger.kernel.org>; Thu,  4 Apr 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224231; cv=none; b=JGwOiVNOfZ64WSXKNB8Oap+sa1inzs1c+s7Df9Fsy+nk+PkM8twKru7R5Ox2YBlcUo5r68n1V3fTXGPak1eQWFCq8EvwGYSEN/W645ndX8opVC3HGDyAXTm88Y8102X/QBeZjwc0efEg8ZlUredS1tZ07Joxp0Qo1r04L7SUHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224231; c=relaxed/simple;
	bh=8khoyiX9jCM3/LmrShGv6HE92NYti8InqH9MISpUFyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Shr82HUyEc1rAh0z/76i4SzNBuoBmjJIsfubY88bDnKxDfmYfVdnXV8AhzQdou86dcpvXg9rO2qMiJ2VHwvAq+uLB870n7KH7kdQBnEgAVYJCt3KubnO1OB9yX0xLD7lhwCq8NbwGuKpumJtqbZtPSKPkoxLdiXP1R18pUA0zD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo47Fk7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo47Fk7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7275C433C7;
	Thu,  4 Apr 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712224231;
	bh=8khoyiX9jCM3/LmrShGv6HE92NYti8InqH9MISpUFyM=;
	h=From:To:Cc:Subject:Date:From;
	b=jo47Fk7NvKAinFNJXXBlHRyxMIUmh+oESc4yagIrkLs/ScAeI1/2qzDanw+DngeNo
	 pgQ/RUP2iv6dmcCeqEIBU/12g38AoavJ33QvaDLi0XR1wJRXBXcu6n3DVdaevz1l5M
	 SMAfLNnOfAOLQ7G9vm3UPcJn5UcaV6fXgEcRy00JnnGhExZzczG5kyQtN95hOGVZnO
	 Ot2ns6aMBuv4YYEMIXtGpRKiJoeWYmhez+6bWhTly/Uzhy+wMDyb0WUK3RdcWT4cRG
	 L9tE+aSJ2dAmQeY+FgYmT3wMLpQgpJp9Xb0AFPZ4WlwSp9kzm26ciI5bNUdHJK+3Nx
	 ybm1R3D/1wDyQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Conrad Kostecki <conikost@gentoo.org>,
	Szuying Chen <chensiying21@gmail.com>,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw
Subject: [PATCH] ata: ahci: Add mask_port_map module parameter
Date: Thu,  4 Apr 2024 18:50:26 +0900
Message-ID: <20240404095026.929491-1-dlemoal@kernel.org>
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
takes time. However, these commits caused a regression for user that do
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

The mask_port_map parameter accepts 2 different format:
 - mask_port_map=<mask>
   This applies the same mask to all AHCI controllers
   present in the system. This format is convenient for small systems
   that have only a single AHCI controller.
 - mask_port_map=<dev name>=<mask>,<dev name>=mask,...
   This applies the specified masks only to the device listed. The
   device name correspond to the string following "ahci" in probe
   kernel messages. E.g. for:
   ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)
   the device name is "0000:01:00.0".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 562302e2e57c..3bc8626f3ba9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -666,6 +666,90 @@ static int mobile_lpm_policy = -1;
 module_param(mobile_lpm_policy, int, 0644);
 MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 
+static char *ahci_mask_port_map;
+module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);
+MODULE_PARM_DESC(mask_port_map,
+		 "Provide 32-bit port map masks to ignore controllers ports. "
+		 "Valid values are: "
+		 "<mask> to apply the same mask to all controller devices, "
+		 "<dev0_name>=<mask0>,<dev1_name>=<mask1>,...' to specify a "
+		 "different mask per controller, where <dev_name> is the "
+		 "controller host name as printed in the messages "
+		 "\"ahci xxxx:bus:dev.func: ...\"");
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
+	if (mask) {
+		dev_warn(dev, "Forcing port map mask 0x%x\n", mask);
+		hpriv->mask_port_map = mask;
+	}
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
+	if (!strchr(str, '=')) {
+		/* Single mask case */
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
@@ -688,6 +772,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
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

