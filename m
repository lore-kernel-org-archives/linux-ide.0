From: Li Yang <leoli@freescale.com>
Subject: [PATCH 02/12] ata/sata_fsl: Remove deprecated hooks
Date: Wed, 31 Oct 2007 19:27:54 +0800
Message-ID: <1193830084-22298-2-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:44021 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758068AbXJaLRp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:45 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9VBHglk007292
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdH7005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:41 -0500 (CDT)
In-Reply-To: <1193830084-22298-1-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 8a8ce9d..4c8c820 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1323,8 +1323,6 @@ static struct scsi_host_template sata_fsl_sht = {
 };
 
 static const struct ata_port_operations sata_fsl_ops = {
-	.port_disable = ata_port_disable,
-
 	.check_status = sata_fsl_check_status,
 	.check_altstatus = sata_fsl_check_status,
 	.dev_select = ata_noop_dev_select,
@@ -1334,8 +1332,6 @@ static const struct ata_port_operations sata_fsl_ops = {
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
 	.irq_clear = sata_fsl_irq_clear,
-	.irq_on = ata_dummy_irq_on,
-	.irq_ack = ata_dummy_irq_ack,
 
 	.scr_read = sata_fsl_scr_read,
 	.scr_write = sata_fsl_scr_write,
-- 
1.5.3.2.104.g41ef

