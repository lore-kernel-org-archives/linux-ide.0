From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: SRST can't be trusted on PMP sil3726
Date: Wed, 21 May 2008 14:11:24 +0900
Message-ID: <4833AEFC.2000705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:49349 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYEUFLa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 01:11:30 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2762667waf.23
        for <linux-ide@vger.kernel.org>; Tue, 20 May 2008 22:11:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

As in sil4726, SRST can't be trusted on sil3726 causing detection
problems under certain configuraitons.  I thought it was from the
Config Disk device but apparently not.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-pmp.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3374ec5..b65db30 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -322,9 +322,12 @@ static void sata_pmp_quirks(struct ata_port *ap)
 	if (vendor == 0x1095 && devid == 0x3726) {
 		/* sil3726 quirks */
 		ata_port_for_each_link(link, ap) {
-			/* class code report is unreliable */
+			/* Class code report is unreliable and SRST
+			 * times out under certain configurations.
+			 */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_NO_SRST |
+					       ATA_LFLAG_ASSUME_ATA;
 
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)
