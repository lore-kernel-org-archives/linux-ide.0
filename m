From: =?ISO-8859-15?Q?David_M=FCller?= <dave.mueller@gmx.ch>
Subject: [PATCH] libata: fix out-of-bounds access in pata_oldpiix.c
Date: Fri, 18 Jul 2008 09:06:12 +0200
Message-ID: <488040E4.1090500@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752697AbYGRHGK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jul 2008 03:06:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

The "pata_oldpiix" driver in linux-2.6.26 is calling its "set_dmamode" 
routine also locally, but under different preconditions as the 
corresponding call in libata-core.c. This may cause an "out-of-array 
bounds" access in "oldpiix_set_dmamode".


Signed-off-by: Dave Mueller <dave.mueller@gmx.ch>

diff -dpurN a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
--- a/drivers/ata/pata_oldpiix.c   2008-07-18 08:13:38.000000000 +0200
+++ b/drivers/ata/pata_oldpiix.c   2008-07-18 08:18:45.000000000 +0200
@@ -198,7 +198,7 @@ static unsigned int oldpiix_qc_issue(str

         if (adev != ap->private_data) {
                 oldpiix_set_piomode(ap, adev);
-               if (adev->dma_mode)
+               if (adev->dma_mode != 0xff)
                         oldpiix_set_dmamode(ap, adev);
         }
         return ata_sff_qc_issue(qc);

