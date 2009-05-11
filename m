From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: libata depends on HAS_DMA
Date: Mon, 11 May 2009 22:38:55 +0000
Message-ID: <200905112238.55404.arnd@arndb.de>
References: <20090511222702.352192505@arndb.de>>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:59899 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789AbZEKWi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 18:38:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

libata uses the DMA mapping API, so it cannot be built
on architectures that don't have DMA support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9120717..f076268 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig ATA
 	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && HAS_DMA
 	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	select SCSI
-- 
1.6.0.4

-- 


