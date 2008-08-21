From: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 8/9] pata_sil680: convert CONFIG_PPC_MERGE to CONFIG_PPC
Date: Wed, 20 Aug 2008 23:46:57 -0500
Message-ID: <1219294018-12557-9-git-send-email-galak@kernel.crashing.org>
References: <1219294018-12557-1-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-2-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-3-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-4-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-5-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-6-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-7-git-send-email-galak@kernel.crashing.org>
 <1219294018-12557-8-git-send-email-galak@kernel.crashing.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756701AbYHUEuR@vger.kernel.org>
In-Reply-To: <1219294018-12557-8-git-send-email-galak@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
powerpc platforms and we want to get rid of CONFIG_PPC_MERGE use
CONFIG_PPC instead.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/ata/pata_sil680.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 720b864..9655511 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -230,7 +230,7 @@ static u8 sil680_init_chip(struct pci_dev *pdev, int *try_mmio)
 		tmpbyte & 1, tmpbyte & 0x30);
 
 	*try_mmio = 0;
-#ifdef CONFIG_PPC_MERGE
+#ifdef CONFIG_PPC
 	if (machine_is(cell))
 		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
 #endif
-- 
1.5.5.1
