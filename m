From: Li Yang <leoli@freescale.com>
Subject: [PATCH 12/12] ata/sata_fsl: Remove ata_scsi_suspend/resume callbacks
Date: Wed, 31 Oct 2007 19:28:04 +0800
Message-ID: <1193830084-22298-12-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
 <1193830084-22298-6-git-send-email-leoli@freescale.com>
 <1193830084-22298-7-git-send-email-leoli@freescale.com>
 <1193830084-22298-8-git-send-email-leoli@freescale.com>
 <1193830084-22298-9-git-send-email-leoli@freescale.com>
 <1193830084-22298-10-git-send-email-leoli@freescale.com>
 <1193830084-22298-11-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:44122 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbXJaLSB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:18:01 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9VBHxM8007387
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:59 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHR005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:58 -0500 (CDT)
In-Reply-To: <1193830084-22298-11-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: ashish kalra <ashish.kalra@freescale.com>, Li Yang <leoli@freescale.com>

From: ashish kalra <ashish.kalra@freescale.com>

Signed-off-by: ashish kalra <ashish.kalra@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index c3b0360..d015b4a 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1223,10 +1223,6 @@ static struct scsi_host_template sata_fsl_sht = {
 	.slave_configure = ata_scsi_slave_config,
 	.slave_destroy = ata_scsi_slave_destroy,
 	.bios_param = ata_std_bios_param,
-#ifdef CONFIG_PM
-	.suspend = ata_scsi_device_suspend,
-	.resume = ata_scsi_device_resume,
-#endif
 };
 
 static const struct ata_port_operations sata_fsl_ops = {
-- 
1.5.3.2.104.g41ef

