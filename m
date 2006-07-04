From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 14/24] it821x: Fix the ATAPI autodma setup
Date: Tue, 4 Jul 2006 18:15:19 +0000 (UTC)
Message-ID: <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57486 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932320AbWGDSPI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:08 -0400
Date: Maw, 04 Gor 2006 19:01:38 +0100
In-Reply-To: <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Don't assume atapi dma is defaulted to on.

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/ide/pci/it821x.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

85cc34b0e65068dedb8370af2086e29625519a6a
diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
index 38f41b3..5928a09 100644
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -650,6 +650,8 @@ static void __devinit init_hwif_it821x(i
 		goto fallback;
 	}
 	ide_set_hwifdata(hwif, idev);
+	
+	hwif->atapi_dma = 1;
 
 	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
 	if(conf & 1) {
-- 
1.2.GIT

