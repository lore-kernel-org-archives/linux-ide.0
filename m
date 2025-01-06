Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717C3597F
	for <linux-ide@vger.kernel.org>; Mon,  6 Jan 2025 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141266; cv=none; b=BsKUvLt1fsk8Z0urGb066XjzI4xb1d4Uu3dQNHrQMKyUxAv+6ucz062gxcPmMCPYZyBNijOqJlm6VMluEfhA2k4oIhxBQYbDwQOgmJyhBOv6I6fWR+8w7hb+9sGRVx3Hd1VFqtjaf8CCBE9X2lP8youWElpk/C3tEbXFFTZHHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141266; c=relaxed/simple;
	bh=TFm6KQXGa26QjjNaw8I3E3IGY0Knwv5lD8/3nDPT07c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e71gt8LvsFC5FcBvXRZ/X1EkkqNrgJ2OBJG91P3pfmPh56CUPk/Np73YplsuuPlqeEwUNCTSxC9CBADQA9JPZDFgX5i4uqYm+Kvm6QGr08QKaAXzm4voZSwmE+zYdhR3JZI3/2ZhKGtNdRBlgF7mdL0byV7ODHaJvpPSO5h15h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvg0ckRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvg0ckRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947C4C4CED6;
	Mon,  6 Jan 2025 05:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736141265;
	bh=TFm6KQXGa26QjjNaw8I3E3IGY0Knwv5lD8/3nDPT07c=;
	h=From:To:Subject:Date:From;
	b=Hvg0ckRzR24ctwowreEG7qPUKgl2bK4Ybzft497eYHoD+tGIauFtbWIRST+ONJ1gq
	 CqPoeMqb6abf4bKzGHt9XC+s3Aavw6hUQJfr7vjrMcB92PD24SUR6UfcOTkli6ZIiq
	 +DWkI4PXm9boL6Y3FYBiPrcWMPxAksRsrTj1+JAkWWkQyRYk0IFedTLd6i63gqRHp1
	 m77pedQOBBl7E+/okWGgvFdgPrtO6GeaC3YVokwzFV4+I3xUjQ0AIiSSmhb0ZoBRGK
	 r6IJaLbd3qSQY6l/j+iP8M+RAhwWeR6GhKnTR9/gpnTxmPs8EQ1NZIBpt9bOnJbgfL
	 NYXT987nESESg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ahci: Introduce ahci_ignore_port() helper
Date: Mon,  6 Jan 2025 14:27:01 +0900
Message-ID: <20250106052701.47246-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libahci and AHCI drivers may ignore some ports if the port is invalid
(its ID does not correspond to a valid physical port) or if the user
explicitly requested the port to be ignored with the mask_port_map
ahci module parameter. Such port that shall be ignored can be identified
by checking that the bit corresponding to the port ID is not set in the
mask_port_map field of struct ahci_host_priv. E.g. code such as:
"if (!(hpriv->mask_port_map & (1 << portid)))".

Replace all direct use of the mask_port_map field to detect such port
with the new helper inline function ahci_ignore_port() to make the code
more readable/easier to understand.

The comment describing the mask_port_map field of struct ahci_host_priv
is also updated to be more accurate.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.h             | 13 ++++++++++++-
 drivers/ata/ahci_brcm.c        |  2 +-
 drivers/ata/ahci_ceva.c        |  4 ++--
 drivers/ata/libahci_platform.c |  6 +++---
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 8f40f75ba08c..aea30df50c58 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -328,7 +328,7 @@ struct ahci_port_priv {
 struct ahci_host_priv {
 	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
-	u32			mask_port_map;	/* mask out particular bits */
+	u32			mask_port_map;	/* Mask of valid ports */
 
 	void __iomem *		mmio;		/* bus-independent mem map */
 	u32			cap;		/* cap to use */
@@ -379,6 +379,17 @@ struct ahci_host_priv {
 						  int port);
 };
 
+/*
+ * Return true if a port should be ignored because it is excluded from
+ * the host port map.
+ */
+static inline bool ahci_ignore_port(struct ahci_host_priv *hpriv,
+				    unsigned int portid)
+{
+	return portid >= hpriv->nports ||
+		!(hpriv->mask_port_map & (1 << portid));
+}
+
 extern int ahci_ignore_sss;
 
 extern const struct attribute_group *ahci_shost_groups[];
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 24c471b485ab..29be74fedcf0 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -288,7 +288,7 @@ static unsigned int brcm_ahci_read_id(struct ata_device *dev,
 
 	/* Re-initialize and calibrate the PHY */
 	for (i = 0; i < hpriv->nports; i++) {
-		if (!(hpriv->mask_port_map & (1 << i)))
+		if (ahci_ignore_port(hpriv, i))
 			continue;
 
 		rc = phy_init(hpriv->phys[i]);
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index f2e20ed11ec7..2d6a08c23d6a 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -206,7 +206,7 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 		goto disable_clks;
 
 	for (i = 0; i < hpriv->nports; i++) {
-		if (!(hpriv->mask_port_map & (1 << i)))
+		if (ahci_ignore_port(hpriv, i))
 			continue;
 
 		rc = phy_init(hpriv->phys[i]);
@@ -218,7 +218,7 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	ahci_platform_deassert_rsts(hpriv);
 
 	for (i = 0; i < hpriv->nports; i++) {
-		if (!(hpriv->mask_port_map & (1 << i)))
+		if (ahci_ignore_port(hpriv, i))
 			continue;
 
 		rc = phy_power_on(hpriv->phys[i]);
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index b68777841f7a..53b2c7719dc5 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -49,7 +49,7 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 	int rc, i;
 
 	for (i = 0; i < hpriv->nports; i++) {
-		if (!(hpriv->mask_port_map & (1 << i)))
+		if (ahci_ignore_port(hpriv, i))
 			continue;
 
 		rc = phy_init(hpriv->phys[i]);
@@ -73,7 +73,7 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 
 disable_phys:
 	while (--i >= 0) {
-		if (!(hpriv->mask_port_map & (1 << i)))
+		if (ahci_ignore_port(hpriv, i))
 			continue;
 
 		phy_power_off(hpriv->phys[i]);
@@ -94,7 +94,7 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 	int i;
 
 	for (i = 0; i < hpriv->nports; i++) {
-		if (!(hpriv->mask_port_map & (1 << i)))
+		if (ahci_ignore_port(hpriv, i))
 			continue;
 
 		phy_power_off(hpriv->phys[i]);
-- 
2.47.1

