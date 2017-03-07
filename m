From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: allow subsystem to be used on m32r and s390 archs
Date: Tue, 07 Mar 2017 14:56:40 +0100
Message-ID: <2339253.11Ms71o855@amdc3058>
References: <CGME20170307135643epcas1p257e7a1e1410a498343b8a6b425df65f2@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39405 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755257AbdCGN77 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2017 08:59:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Both archs should work just fine with libata subsystem nowadays.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Cross compile tested.

 drivers/ata/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 70b57d2..7e0fc98 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -14,7 +14,6 @@ menuconfig ATA
 	tristate "Serial ATA and Parallel ATA drivers (libata)"
 	depends on HAS_IOMEM
 	depends on BLOCK
-	depends on !(M32R || S390) || BROKEN
 	select SCSI
 	select GLOB
 	---help---
-- 
1.9.1


