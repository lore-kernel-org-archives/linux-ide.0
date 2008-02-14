From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 07/11] ata: fix sparse warning in pata_cs5536.c
Date: Wed, 13 Feb 2008 21:14:23 -0800
Message-ID: <1202966063.2748.21.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:7923 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761580AbYBNFOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so160087rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:24 -0800 (PST)
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Everybody passes in a u32...why fight it.

drivers/ata/pata_cs5536.c:124:26: warning: incorrect type in argument 3 (different signedness)
drivers/ata/pata_cs5536.c:124:26:    expected int *val
drivers/ata/pata_cs5536.c:124:26:    got unsigned int *<noident>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/pata_cs5536.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index d753e56..c71505e 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -85,7 +85,7 @@ static const u8 pci_reg[4] = {
 	PCI_IDE_CFG, PCI_IDE_DTC, PCI_IDE_CAST, PCI_IDE_ETC,
 };
 
-static inline int cs5536_read(struct pci_dev *pdev, int reg, int *val)
+static inline int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
 {
 	if (unlikely(use_msr)) {
 		u32 dummy;
-- 
1.5.4.1.1278.gc75be


