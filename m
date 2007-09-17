From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] [POWERPC] Remove unused variabls from
 drivers/ide/ppc/pmac.c
Date: Mon, 17 Sep 2007 14:06:44 +1000
Message-ID: <20070917140644.f62abe1e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:33867 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbXIQEGx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Sep 2007 00:06:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: paulus@samba.org
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org

Removes these warnings:

/home/sfr/kernels/linus/drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_check':
/home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1807: warning: unused variable 'map'
/home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1805: warning: unused variable 'pmif'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ide/ppc/pmac.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 4b13cd9..f19eb6d 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1802,9 +1802,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	int enable = 1;
-	int map;
 	drive->using_dma = 0;
 	
 	if (drive->media == ide_floppy)
-- 
1.5.3.1

