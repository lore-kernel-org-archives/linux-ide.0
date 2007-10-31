From: Li Yang <leoli@freescale.com>
Subject: [PATCH 05/12] ata/sata_fsl: Remove unnecessary SCR cases
Date: Wed, 31 Oct 2007 19:27:57 +0800
Message-ID: <1193830084-22298-5-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56730 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696AbXJaLRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:50 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHlqB004854
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:48 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHD005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:47 -0500 (CDT)
In-Reply-To: <1193830084-22298-4-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Li Yang <leoli@freescale.com>

From: Jeff Garzik <jeff@garzik.org>

SCRs in the driver map to the standard values found in include/linux/ata.h,
so no need for individual scr_read/scr_write case statements duplicating
the natural value.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 9e99cc8..e04fb75 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -472,16 +472,10 @@ static int sata_fsl_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
 
 	switch (sc_reg_in) {
 	case SCR_STATUS:
-		sc_reg = 0;
-		break;
 	case SCR_ERROR:
-		sc_reg = 1;
-		break;
 	case SCR_CONTROL:
-		sc_reg = 2;
-		break;
 	case SCR_ACTIVE:
-		sc_reg = 3;
+		sc_reg = sc_reg_in;
 		break;
 	default:
 		return -EINVAL;
@@ -502,16 +496,10 @@ static int sata_fsl_scr_read(struct ata_port *ap, unsigned int sc_reg_in,
 
 	switch (sc_reg_in) {
 	case SCR_STATUS:
-		sc_reg = 0;
-		break;
 	case SCR_ERROR:
-		sc_reg = 1;
-		break;
 	case SCR_CONTROL:
-		sc_reg = 2;
-		break;
 	case SCR_ACTIVE:
-		sc_reg = 3;
+		sc_reg = sc_reg_in;
 		break;
 	default:
 		return -EINVAL;
-- 
1.5.3.2.104.g41ef

