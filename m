From: Joe Perches <joe@perches.com>
Subject: [PATCH 17/59] drivers/ide: Add missing "space"
Date: Mon, 19 Nov 2007 17:48:09 -0800
Message-ID: <3c52bdbf8c60392df6b4fc91e6188f4a382b5310.1195454435.git.joe__14624.240602325$1195523859$gmane$org@perches.com>
References: 1234567
 <1195523331-15303-1-git-send-email-joe@perches.com>
 <1195523331-15303-2-git-send-email-joe@perches.com>
 <1195523331-15303-3-git-send-email-joe@perches.com>
 <1195523331-15303-4-git-send-email-joe@perches.com>
 <1195523331-15303-5-git-send-email-joe@perches.com>
 <1195523331-15303-6-git-send-email-joe@perches.com>
 <1195523331-15303-7-git-send-email-joe@perches.com>
 <1195523331-15303-8-git-send-email-joe@perches.com>
 <1195523331-15303-9-git-send-email-joe@perches.com>
 <1195523331-15303-10-git-send-email-joe@perches.com>
 <1195523331-15303-11-git-send-email-joe@perches.com>
 <1195523331-15303-12-git-send-email-joe@perches.com>
 <1195523331-15303-13-git-send-email-joe@perches.com>
 <1195523331-15303-14-git-send-email-joe@perches.com>
 <1195523331-15303-15-git-send-email-joe@perches.com>
 <1195523331-15303-16-git-send-email-joe@perches.com>
 <1195523331-15303-17-git-send-email-joe@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759048AbXKTBz6@vger.kernel.org>
In-Reply-To: <1195523331-15303-17-git-send-email-joe@perches.com>
Message-Id: <3c52bdbf8c60392df6b4fc91e6188f4a382b5310.1195454435.git.joe@perches.com>
In-Reply-To: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ide/ppc/pmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 5afdfef..7f7a598 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1513,7 +1513,7 @@ pmac_ide_build_dmatable(ide_drive_t *drive, struct request *rq)
 
 		if (pmif->broken_dma && cur_addr & (L1_CACHE_BYTES - 1)) {
 			if (pmif->broken_dma_warn == 0) {
-				printk(KERN_WARNING "%s: DMA on non aligned address,"
+				printk(KERN_WARNING "%s: DMA on non aligned address, "
 				       "switching to PIO on Ohare chipset\n", drive->name);
 				pmif->broken_dma_warn = 1;
 			}
-- 
1.5.3.5.652.gf192c
