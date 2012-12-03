From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] libata: fix ata_dma_enabled
Date: Mon, 03 Dec 2012 09:04:20 +0800
Message-ID: <50BBFA94.2070105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11571 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280Ab2LCBEB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2012 20:04:01 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org


ata_dma_enabled should check if device is either using multi word DMA
or ultra DMA instead of checking 0xff, as dma_mode 0 is not a valid dma
mode either.

This patch fixes the following bug:
https://bugzilla.kernel.org/show_bug.cgi?id=49151

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Dutra Julio <dutra.julio@gmail.com>
Tested-by: Szymon Janc <szymon@janc.net.pl>
Tested-by: Bernd Buschinski <b.buschinski@googlemail.com>
Cc: <stable@kernel.org>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 77eeeda..2444695 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1617,7 +1617,7 @@ static inline int ata_using_udma(struct ata_device *adev)
 
 static inline int ata_dma_enabled(struct ata_device *adev)
 {
-	return (adev->dma_mode == 0xFF ? 0 : 1);
+	return ata_using_mwdma(adev) || ata_using_udma(adev);
 }
 
 /**************************************************************************
-- 
1.8.0.1.2.gd1eded4

