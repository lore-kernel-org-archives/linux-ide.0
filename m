Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0E19F422
	for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971021; cv=none; b=Z93f+ZrRY0kADSaFAMwIRemlvbaqUyeQoqIYlQL3E/vNF5yD7PCuDIrFGmgZULSMwzB5NgF+sjsTFrhlJ1GJPPVtC0PJb7GPM4iEmW7hLRd7Z9FuOEvsanI0/lorkXstVN4bJ9pIRdo1stUd5jPvM1M9VkLSapts0Uwc8u/66Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971021; c=relaxed/simple;
	bh=jQbAtwSLSmO2A+d8x0tdgw1d/2oEgcM7W7xVAgXEPCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5BehtC9YhzglGMhZPCFdUlIpF5MALMJIju2haVQ7t6mESrjAzcojv0A67edmcyyyjyhUK+uyhMm4W4QPhd5yQbyMMdiponvCIw/+Gee2gDr+lTKnQiiErrANZPCCAuSH3ZB/HAc21qUw02ClRVk7U86w2pbg1ZZI9ondfsl4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fty2d1/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fty2d1/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B572EC4CED1;
	Fri,  7 Feb 2025 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738971020;
	bh=jQbAtwSLSmO2A+d8x0tdgw1d/2oEgcM7W7xVAgXEPCA=;
	h=From:To:Cc:Subject:Date:From;
	b=Fty2d1/J0zvqyxZ/Pl2vCB4oMkhs+XJaP6463WkmPMwJ8OJl8WXnCoJITgzpX6oDv
	 zF4PaWEy8ujwZfy9O3YEQjzUwCDwVVLZZZCBVFMNDu44NalnerpohUoBOOKna2RpWy
	 EHpnhTw04PwAkuAq4impwTJa2sqGpoS6HVIsrI/NWOuogfaAXC04RaMPwcM+dMj1to
	 EaKX6ss0dfXOSbwWwr2Tf05dnSEREptL0tcdzuP2UVelAO1W7YgpIYNTKRrgPqJWhQ
	 QsYdhgDAq098zFlNECAlSk6SHr79BxDPvVFVcPLRFUj5nG+eSCV5dYQMnqXoaS5AMj
	 xdqArw/c1OBwQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2] ata: libahci_platform: Do not set mask_port_map when not needed
Date: Sat,  8 Feb 2025 08:29:15 +0900
Message-ID: <20250207232915.1439174-1-dlemoal@kernel.org>
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

However, this commit also erroneously sets bit 0 of
hpriv->mask_port_map when the platform devices tree does not define port
child nodes, to match the fact that the temporary default number of
ports used in that case is 1 (which is also consistent with the fact
that only index 0 of hpriv->phys[] is initialized with the call to
ahci_platform_get_phy(). But doing so causes ahci_platform_init_host()
to initialize and probe only the first port, even if this function
determines that the controller has in fact multiple ports using the
capability register of the controller (through a call to
ahci_nr_ports()). This can be seen with the ahci_mvebu driver (Armada
385 SoC) with the second port declared as "dummy":

ahci-mvebu f10a8000.sata: masking port_map 0x3 -> 0x1
ahci-mvebu f10a8000.sata: AHCI vers 0001.0000, 32 command slots, 6 Gbps, platform mode
ahci-mvebu f10a8000.sata: 1/2 ports implemented (port mask 0x1)
ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
scsi host0: ahci-mvebu
scsi host1: ahci-mvebu
ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 40 lpm-pol 0
ata2: DUMMY

Fix this issue by removing setting bit 0 of hpriv->mask_port_map when
the platform device tree does not define port child nodes.

Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 - Improved commit message (fixed typos, added example and removed
   cc-stable tag).

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

