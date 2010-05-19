From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sata_mv: drop unncessary EH callback resetting
Date: Wed, 19 May 2010 22:10:19 +0200
Message-ID: <1274299824-15691-2-git-send-email-tj@kernel.org>
References: <1274299824-15691-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45399 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab0ESUKi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 16:10:38 -0400
In-Reply-To: <1274299824-15691-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Now that BMDMA EH ops are separated out from SFF ops, mv5_ops doesn't
have to explicitly reset ->error_handler() and ->post_internal_cmd().
Drop them.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_mv.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f3471bc..16bacd3 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -675,8 +675,6 @@ static struct ata_port_operations mv5_ops = {
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
 	.hardreset		= mv_hardreset,
-	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
-	.post_internal_cmd	= ATA_OP_NULL,
 
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
-- 
1.6.4.2

