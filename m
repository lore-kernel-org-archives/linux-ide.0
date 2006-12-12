From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: do not mangle saved HOST_CAP while resetting controller
Date: Tue, 12 Dec 2006 20:17:32 +0900
Message-ID: <20061212111732.GF18947@htj.dyndns.org>
References: <20061123051815.GD18344@dosa.chappati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:61977 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932201AbWLLLRk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 06:17:40 -0500
Received: by nz-out-0102.google.com with SMTP id s1so963270nze
        for <linux-ide@vger.kernel.org>; Tue, 12 Dec 2006 03:17:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061123051815.GD18344@dosa.chappati.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manoj Kasichainula <manoj@io.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Do not mangle with HOST_CAP while resetting controller.  The code is
there for a historical reason.  The mangling breaks controller feature
detection and 0 PORTS_IMPL workaround code.

This problem was spotted by Manoj Kasichainula.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Manoj Kasichainula <manoj@io.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f36da48..dbae6d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -645,8 +645,6 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 	u32 cap_save, impl_save, tmp;
 
 	cap_save = readl(mmio + HOST_CAP);
-	cap_save &= ( (1<<28) | (1<<17) );
-	cap_save |= (1 << 27);
 	impl_save = readl(mmio + HOST_PORTS_IMPL);
 
 	/* global controller reset */
