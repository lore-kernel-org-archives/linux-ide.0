From: ashish kalra <ashish.kalra@freescale.com>
Subject: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Wed, 29 Jul 2009 21:33:27 +0530 (India Standard Time)
Message-ID: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:57053 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbZG2QFt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 12:05:49 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n6TG5Wm2018066
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 09:05:43 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n6TG5jmn009098
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 11:05:46 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org

From: Ashish Kalra <Ashish.Kalra@freescale.com>
Date: Wed, 29 Jul 2009 21:15:49 +0530

Fix for non-ncq & ncq commands causing timeouts when both are issued 
simultaneously to the same device.

Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
---
  drivers/ata/sata_fsl.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5a88b44..a33f130 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1262,6 +1262,7 @@ static struct scsi_host_template sata_fsl_sht = {
  static struct ata_port_operations sata_fsl_ops = {
  	.inherits		= &sata_pmp_port_ops,

+	.qc_defer = ata_std_qc_defer;
  	.qc_prep = sata_fsl_qc_prep,
  	.qc_issue = sata_fsl_qc_issue,
  	.qc_fill_rtf = sata_fsl_qc_fill_rtf,
-- 
1.6.0


