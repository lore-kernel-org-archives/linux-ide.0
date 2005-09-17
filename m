From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] cs5520: fix return value of cs5520_init_one()
Date: Sat, 17 Sep 2005 15:50:43 +0400
Message-ID: <20050917115043.GB2768@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:16404 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751074AbVIQLkY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Sep 2005 07:40:24 -0400
Received: by zproxy.gmail.com with SMTP id i11so307403nzi
        for <linux-ide@vger.kernel.org>; Sat, 17 Sep 2005 04:40:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkiewicz@elka.pw.edu.pl>
Cc: Amit Gud <amitg@calsoftinc.com>, linux-ide@vger.kernel.org

From: Amit Gud <amitg@calsoftinc.com>

Patch follows from the suggestions by AC and Felipe W Damasio for
fixing the return codes from IDE drivers.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/pci/cs5520.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -225,7 +225,7 @@ static int __devinit cs5520_init_one(str
 	if(pci_enable_device_bars(dev, 1<<2))
 	{
 		printk(KERN_WARNING "%s: Unable to enable 55x0.\n", d->name);
-		return 1;
+		return -ENODEV;
 	}
 	pci_set_master(dev);
 	if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {

