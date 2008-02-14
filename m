From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 02/11] ata: fix sparse warning in sata_promise.c
Date: Wed, 13 Feb 2008 21:14:08 -0800
Message-ID: <1202966048.2748.16.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765573AbYBNFPU@vger.kernel.org>
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

drivers/ata/sata_promise.c:546:15: warning: symbol 'len' shadows an earlier one
drivers/ata/sata_promise.c:538:6: originally declared here

len is set again immediately after the loop, so this is safe.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/sata_promise.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index a07d319..f251a5f 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -543,7 +543,7 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 	idx = 0;
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u32 addr, offset;
-		u32 sg_len, len;
+		u32 sg_len;
 
 		/* determine if physical DMA addr spans 64K boundary.
 		 * Note h/w doesn't support 64-bit, so we unconditionally
-- 
1.5.4.1.1278.gc75be
