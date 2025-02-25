Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3926A085
	for <linux-ide@vger.kernel.org>; Tue, 25 Feb 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492987; cv=none; b=PwsExuaVjknFW3BdTO3P+AdK/f3Uq2XPsoJqkLK8WHd5av23L3tMKI7rwlRXr1pS2KF+SHT6HyQafozJr7uQbLbvtzYCLblAxV/5Rvqn7LguoqynzkyqqmFTN0hj+2sRr7cMXiHRlexmTmNPm5S8s92xRYrac1+JQZh0WDzl5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492987; c=relaxed/simple;
	bh=HrGbsl5W5PUDKGMa0tYFOJRQBEWNT2jHYgQ9GRrk3hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6ez1rLuX7en61wgWAWq8ikMJbwJWcdHDTg3HGvx3FxFgngfXUSoH0ZLLiCRcCQFKW5EtmrcpUZvu2Z2lEY5nKQr9tQNkxOzyd3h2TSkl+HVXiLweS7AOIHvraBKvGN8lwud+wCDDoC6d69mH6pT4tHY+vYu/uQrvJP+Ijwtiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnzQ1ivV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnzQ1ivV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837BAC4CEDD;
	Tue, 25 Feb 2025 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740492987;
	bh=HrGbsl5W5PUDKGMa0tYFOJRQBEWNT2jHYgQ9GRrk3hM=;
	h=From:To:Cc:Subject:Date:From;
	b=RnzQ1ivVZjahg/hxrAcKdm9mxLOrZnvZ6ie2nP+mGCgHXUjpLgPZsJTTpTpyId/QV
	 UxeHwsLaWCJXBH2+LOASB1qXprK8kmady+Rgk+9s8huF269JqyC/1UV9FJD/X4h6zK
	 EHt7RXZrawTMvl71oHYwnB1gH57cfP9eqADjPc4IvLtlBnIQbKc1ggNMe6VK5/iuj8
	 VrzZII+8Y2AvpPDnbtB3ndorFjjKII0RaZQR066JN2xsOiSlEU6KTLRGvU2cGybQ+3
	 LFqqZyO46i31gj6EAlz9zc8FVRBfwBhCpC80O2yhV6ZcWmLC5Z1mZf3i7I/PrURmnM
	 Fe/4mj8R2iQow==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Josua Mayer <josua@solid-run.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Make ahci_ignore_port() handle empty mask_port_map
Date: Tue, 25 Feb 2025 15:16:12 +0100
Message-ID: <20250225141612.942170-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=cassel@kernel.org; h=from:subject; bh=HrGbsl5W5PUDKGMa0tYFOJRQBEWNT2jHYgQ9GRrk3hM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL3XljjuHi3Qrg8H3v7vb7Gm8fSU507F3732CZ7U07or Fjxw/eWHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI5WZGhts3psZKWHb6tDzO exl/ZtNac7/Cc2ey1AWiz7WdVDITs2D4ycj7eOoBhrns6vKFBzKabn5/2fDrmgv7oc9nn2ZGL+o 6wgkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port
numbers") added a skip to ahci_platform_enable_phys() for ports that are
not in mask_port_map.

The code in ahci_platform_get_resources(), will currently set mask_port_map
for each child "port" node it finds in the device tree.

However, device trees that do not have any child "port" nodes will not have
mask_port_map set, and for non-device tree platforms mask_port_map will
only exist as a quirk for specific PCI device + vendor IDs, or as a kernel
module parameter, but will not be set by default.

Therefore, the common thing is that mask_port_map is only set if you do not
want to use all ports (as defined by Offset 0Ch: PI – Ports Implemented
register), but instead only want to use the ports in mask_port_map. If
mask_port_map is not set, all ports are available.

Thus, ahci_ignore_port() must be able to handle an empty mask_port_map.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/linux-ide/10b31dd0-d0bb-4f76-9305-2195c3e17670@samsung.com/
Co-developed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
Fixes: 2c202e6c4f4d ("ata: libahci_platform: Do not set mask_port_map when not needed")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.h    | 8 ++++++--
 drivers/ata/libahci.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index aea30df50c58..b2e0ef4efbdc 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -386,8 +386,12 @@ struct ahci_host_priv {
 static inline bool ahci_ignore_port(struct ahci_host_priv *hpriv,
 				    unsigned int portid)
 {
-	return portid >= hpriv->nports ||
-		!(hpriv->mask_port_map & (1 << portid));
+	if (portid >= hpriv->nports)
+		return true;
+	/* mask_port_map not set means that all ports are available */
+	if (!hpriv->mask_port_map)
+		return false;
+	return !(hpriv->mask_port_map & (1 << portid));
 }
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fdfa7b266218..e7ace4b10f15 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -541,6 +541,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		hpriv->saved_port_map = port_map;
 	}
 
+	/* mask_port_map not set means that all ports are available */
 	if (hpriv->mask_port_map) {
 		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
 			port_map,
-- 
2.48.1

