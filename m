From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ide: constify ide_dma_ops structures
Date: Sun, 15 Nov 2015 21:36:30 +0100
Message-ID: <1447619790-5203-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The ide_dma_ops structures are never modified, so declare these as const,
as is already done for the others.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/ide/it821x.c |    2 +-
 drivers/ide/trm290.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index f01ba46..04029d1 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -508,7 +508,7 @@ static void it821x_quirkproc(ide_drive_t *drive)
 
 }
 
-static struct ide_dma_ops it821x_pass_through_dma_ops = {
+static const struct ide_dma_ops it821x_pass_through_dma_ops = {
 	.dma_host_set		= ide_dma_host_set,
 	.dma_setup		= ide_dma_setup,
 	.dma_start		= it821x_dma_start,
diff --git a/drivers/ide/trm290.c b/drivers/ide/trm290.c
index 0069f6c..d550b37 100644
--- a/drivers/ide/trm290.c
+++ b/drivers/ide/trm290.c
@@ -314,7 +314,7 @@ static const struct ide_tp_ops trm290_tp_ops = {
 	.output_data		= ide_output_data,
 };
 
-static struct ide_dma_ops trm290_dma_ops = {
+static const struct ide_dma_ops trm290_dma_ops = {
 	.dma_host_set		= trm290_dma_host_set,
 	.dma_setup 		= trm290_dma_setup,
 	.dma_start 		= trm290_dma_start,

