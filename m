Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533B22B8A0
	for <linux-ide@vger.kernel.org>; Thu, 16 Jan 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038201; cv=none; b=JdqBc30Qdqdn3HziTZhbuQR1zuwv77vj+weioN9IDnYkD0xK6y+A2kPfW9y5y0pKflpzYB9rUYRD0iaBnxSV6bSFerc02CPIdftk5eiDeLFCS8cb7uUUdSoj5DRNiPDTmvUWu4JUSL5lpcsaDxVx73sWVFvdWynQtEKgCt0cb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038201; c=relaxed/simple;
	bh=Crnbrzfe/4iSkkL9M/ms9i3yWXrxPmh+fESIX4IRz8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaYaMYf6ROD17wm6s/hBZIgyM6lI5EKkDLyNOL6QqvsTl153I0M40/9J9QGAmLjbTlN1tZ3lSePOkHmalZilSwqGDkCVY9f6fi3QazoBJdDW1MchtFA892GJglmuQ/0w5Vn5ihrIcR+qMHRpPox1Cy/An1bWWDqy0ZqCBjCXxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPk5DLZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPk5DLZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524F2C4CED6;
	Thu, 16 Jan 2025 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038201;
	bh=Crnbrzfe/4iSkkL9M/ms9i3yWXrxPmh+fESIX4IRz8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPk5DLZfZZ7v1AkdhOqMm+3XSXB35MI3UQNmQyRkN6PXJ5sP85v64jBWJdYmctOur
	 o7D2o5SVmyg3HtzBQecH89qmTGQRFLhykKja0AuqvTF4eugAPnUzVKdrfnQhXUZwFe
	 CJ+S4NncM5524xgy6x0Dths4bQGLjMq9TU9jDYMx/tK/yGYhWkOeQ3Q4lIV51J7RRX
	 svLWWt2i+IeEK8kWNfHLeO8+5qSj4lCbcqEN4n9AHF+q/KF79imZXE4I/CnahwFX57
	 92gGQLZtJRfgKIa3g3HkMJTwhVpdI/VRW7HHiKEPJ4XsjbHAw3I+SeiTqoIJ1+RYnc
	 EQXRXcxgnhR3A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/2] ata: ahci: Create a ahci_get_port_map_helper() helper
Date: Thu, 16 Jan 2025 15:36:32 +0100
Message-ID: <20250116143630.1935474-5-cassel@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116143630.1935474-4-cassel@kernel.org>
References: <20250116143630.1935474-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=cassel@kernel.org; h=from:subject; bh=Crnbrzfe/4iSkkL9M/ms9i3yWXrxPmh+fESIX4IRz8M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI7JfMjmVujlR7dXORsKhVyrFt5s+zanWqnY+81lNZE3 3h+/3JNRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZiHsXwz8hMVpx9x1GZ4ic8 GzVZv+ccrV6TphT/fW2ACtPGGVEKFxgZFrqXOG18auAfyKO45QaD49dDd8I2d76v9zzNqjPD9fB VBgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Create a ahci_get_port_map_helper() helper so that this code can be reused
by other module parameters that are saved in a port bitmap.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 48 +++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8d27c567be1c..92b08d3a0c3c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -676,35 +676,27 @@ MODULE_PARM_DESC(mask_port_map,
 		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
 		 "form \"domain:bus:dev.func\"");
 
-static void ahci_apply_port_map_mask(struct device *dev,
-				     struct ahci_host_priv *hpriv, char *mask_s)
-{
-	unsigned int mask;
-
-	if (kstrtouint(mask_s, 0, &mask)) {
-		dev_err(dev, "Invalid port map mask\n");
-		return;
-	}
-
-	hpriv->mask_port_map = mask;
-}
+typedef void (*port_map_callback_t)(struct device *dev,
+				    struct ahci_host_priv *hpriv, char *mask_s);
 
-static void ahci_get_port_map_mask(struct device *dev,
-				   struct ahci_host_priv *hpriv)
+static void ahci_get_port_map_helper(struct device *dev,
+				     struct ahci_host_priv *hpriv,
+				     const char *module_str,
+				     port_map_callback_t apply_cb)
 {
 	char *param, *end, *str, *mask_s;
 	char *name;
 
-	if (!strlen(ahci_mask_port_map))
+	if (!strlen(module_str))
 		return;
 
-	str = kstrdup(ahci_mask_port_map, GFP_KERNEL);
+	str = kstrdup(module_str, GFP_KERNEL);
 	if (!str)
 		return;
 
 	/* Handle single mask case */
 	if (!strchr(str, '=')) {
-		ahci_apply_port_map_mask(dev, hpriv, str);
+		apply_cb(dev, hpriv, str);
 		goto free;
 	}
 
@@ -739,13 +731,33 @@ static void ahci_get_port_map_mask(struct device *dev,
 			param++;
 		}
 
-		ahci_apply_port_map_mask(dev, hpriv, mask_s);
+		apply_cb(dev, hpriv, mask_s);
 	}
 
 free:
 	kfree(str);
 }
 
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
+	ahci_get_port_map_helper(dev, hpriv, ahci_mask_port_map,
+				 ahci_apply_port_map_mask);
+}
+
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-- 
2.48.0

