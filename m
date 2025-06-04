Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4228ECC9;
	Wed,  4 Jun 2025 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037072; cv=none; b=nwEOtA3tV5A/R+dNGxIOwVyeH0FWC9fSWWNh1kRIsxKDjjLlyN1e1B517INJXktEuOeTR9vdcn4SXAEy6zU/zD6xTab5d8TyhJ+mxyPtZHkee+VY/6kpyC5xdBJ6SGcmHs4Nqrg2uXE+yb4uffklb17XfRx0W5MghqwTsjX3tUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037072; c=relaxed/simple;
	bh=ggwoki9c2BwP/sGTmMHE1VekW49QINGECUTib6v7NpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnS+6vEyt9TQNtiBfSLPzOM3OLhnyjQvdaJU+c6QvFTrp7RxdZILtBbtohy6K3CFZ0jdk0iN19IvUAlh0jbrgDY0awoYiCMfT2HaiS0PH9siHo7MkoPzx+wnH8T5dJVv17xUr+lf1ZKOnhHnA7cIVSZEJrtW7eHcvIaaB+qeqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neOuFRF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neOuFRF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83471C4CEE7;
	Wed,  4 Jun 2025 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749037072;
	bh=ggwoki9c2BwP/sGTmMHE1VekW49QINGECUTib6v7NpM=;
	h=From:To:Cc:Subject:Date:From;
	b=neOuFRF48UZGjxlObU4xZCA5Yr9n25W6u25RkSNKEYoOIEw9JUA9ulaCVZe+5lghk
	 vDC9CaB8Jo4dKC0cdMZ4v3ev3w95q265X23RMSJfMDwyFV5r3efIDpRFx8af1L0FZJ
	 +FnWZ8T67ALqDl28OFOpLkOELjBELaeZ7Jj6OqUxC2SAR0XFQt6Y8vX0QBlBHYFOly
	 GJNcz4QDfHos1z3mxPI1zhYRmiuAOXaoOjzMzcSzPx+T7dz2Jd6+81YF9HTOtR/4mB
	 LWRhfpurNku4qigtpFSKKiD0aHf6h8MRm3/J21GbYevZiA1PHmL1PIT8UzHzpn9JKh
	 L5YKCSq5yxmSQ==
From: Philipp Stanner <phasta@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] ata: macio: Use non-hybrid PCI devres API
Date: Wed,  4 Jun 2025 13:34:24 +0200
Message-ID: <20250604113423.138595-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macio enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_regions() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Replace the call to sometimes-managed pci_request_regions() with one to
the always-managed pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Hi,
seems I forgot sending this patch out a while ago. Mea culpa.

PCI has currently chained the changes mentioned above queued up for
Linus, so it's probably a good idea to get this into macio relatively
soonish. Otherwise the driver would likely fail to reload in v6.16,
because the device's PCI regions remain blocked.

Thx
P.
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index fbf5f07ea357..f7a933eefe05 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1298,7 +1298,7 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 	priv->dev = &pdev->dev;
 
 	/* Get MMIO regions */
-	if (pci_request_regions(pdev, "pata-macio")) {
+	if (pcim_request_all_regions(pdev, "pata-macio")) {
 		dev_err(&pdev->dev,
 			"Cannot obtain PCI resources\n");
 		return -EBUSY;
-- 
2.48.1

