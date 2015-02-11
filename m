From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] sata_dwc_460ex: disable COMPILE_TEST
Date: Tue, 10 Feb 2015 21:54:58 -0500
Message-ID: <20150211025458.GB21356@htj.duckdns.org>
References: <CA+55aFwwp3xEgjk3Qo_CHLKLXA6hOtqSaLwCPJzj34f5AHKRhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:44215 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbBKCzC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Feb 2015 21:55:02 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so804295qcz.6
        for <linux-ide@vger.kernel.org>; Tue, 10 Feb 2015 18:55:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFwwp3xEgjk3Qo_CHLKLXA6hOtqSaLwCPJzj34f5AHKRhQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, IDE-ML <linux-ide@vger.kernel.org>

84683a7e081f ("sata_dwc_460ex: enable COMPILE_TEST for the driver")
enabled COMPILE_TEST for the driver and 2de5a9c004e9 ("sata_dwc_460ex:
disable compilation on ARM and ARM64") subsequently turned it off for
ARMs but it still triggers compile warnings on 64bits.

   drivers/ata/sata_dwc_460ex.c:652:32: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lli[idx].sar = cpu_to_le32((u32)dmadr_addr);
                                 ^
Disable it completely for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Sorry about the trouble.  In case you haven't done it already, here's
the patch.

Thanks.

 drivers/ata/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e7f338a..5f60155 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -269,7 +269,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
-	depends on 460EX || (COMPILE_TEST && !(ARM || ARM64))
+	depends on 460EX
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
