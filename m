Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C451A4F2D
	for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914556; cv=none; b=nyg2IqJ35x8l9vPTl1vqJetovJC3ogd3mnc/2jHdBcVOLQk5yDm5FV6vV1JWh8G9QVVXTDOH/u5SEOhVESFusEe+rh9M4tZSE7uM9OnmKEMyWLb39XEi+ORCGPj1fdNtqmw8nNLPzV9V4j6a++CzXqJtyQ6h1tpAKhEZzYlQ8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914556; c=relaxed/simple;
	bh=KD7cASzqjX6eRZYFGKBXXN9vOLOJISmFet4AJCmVNWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBAu0EG0X17sE+Xj1Kniwxny7mhn6sKmhpT1NwzKafBbJEhGAKt6HuP1Jbx9RQA/emKhQfI6cKFYiT3/mNjzw/zdTHsJTne2fSoKS8rQvpXYSwF5CMavQ29jVklM3x4pBgIoYpplMvXwbRqDC4vDAww7b/mS6oleCa6UynbRyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXQ+m7d0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXQ+m7d0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1161DC4CED1;
	Fri,  7 Feb 2025 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738914555;
	bh=KD7cASzqjX6eRZYFGKBXXN9vOLOJISmFet4AJCmVNWI=;
	h=From:To:Cc:Subject:Date:From;
	b=DXQ+m7d0zXOy8IZ2lz+SyHOXbO/yDun93PFAtnUopBkXA2y2+tqMd202ygjzobV/p
	 JC13vT1+8x6CO0WXDC6CzvsZ2Dc5tHjiqloehftq2t/WGoCd7x9VuKeDg9quUzIbTs
	 tM6o4Do1c6oTFBCZjTfi4qWAwPOSk1Et8+fKA55RnJOKNzkYsMM/3lEjL2nbgt6oiV
	 2QHMbfXodV5smE33fkW+z3tM0E+pj5LPR9bRzuq3bhax7G8ifbiGsrMYPVxSjj4iKt
	 /sSAQKtIAH3iH2cHL5lOPfnJRarfsT8OEz3ouoTAOesRxXsp254ZFbwvcyrJhGSaLH
	 yD1TO8zkGtqoA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Josua Mayer <josua@solid-run.com>
Subject: [PATCH] ata: libahci_platform: Do not set mask_port_map when not needed
Date: Fri,  7 Feb 2025 16:48:10 +0900
Message-ID: <20250207074810.1433154-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive
port numbers") modified ahci_platform_get_resources() to allow
identifying the ports of a controller that are defined as child nodes of
the controller node in order to support non-consecutive port numbers (as
defined by the platform device tree).

However, this commit also erroneously sets bits 0 of
hpriv->mask_port_map when the platform devices tree does not define port
child nodes, to match the fact that the temporary default number of
ports used in that case is 1. Doing so causes ahci_platform_init_host()
to initialize and probe only the first port, even if the controller has
multiple ports (that are not defined through the platform DT).

Fix this by removing setting bit 0 of hpriv->mask_port_map when the
platform devices tree does not define port child nodes.

Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
Cc: stable@vger.kernel.org
Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libahci_platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 53b2c7719dc5..91d44302eac9 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -651,8 +651,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		 * If no sub-node was found, keep this for device tree
 		 * compatibility
 		 */
-		hpriv->mask_port_map |= BIT(0);
-
 		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
 		if (rc)
 			goto err_out;
-- 
2.48.1

