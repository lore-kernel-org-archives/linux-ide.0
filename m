From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: ide/hpt366: remove unused variable
Date: Tue, 21 Oct 2008 02:03:26 +0400
Message-ID: <20081020220326.GB21471@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:43485 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYJTWDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Oct 2008 18:03:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1541295fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 20 Oct 2008 15:03:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org



Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/ide/pci/hpt366.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 9cf171c..ca0acb5 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1289,7 +1289,6 @@ static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
 
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	int serialize		= HPT_SERIALIZE_IO;
 	u8  chip_type		= info->chip_type;
