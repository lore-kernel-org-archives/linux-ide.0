From: Tejun Heo <tj@kernel.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 15:07:21 -0500
Message-ID: <20151221200721.GN4026@mtj.duckdns.org>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36630 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbLUUHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 15:07:24 -0500
Content-Disposition: inline
In-Reply-To: <20151221193550.GM4026@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: "Artem S. Tashkinov" <t.artem@mailcity.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

Hello, Artem.

Can you please apply the following patch on top and see whether
anything changes?  If it does make the issue go away, can you please
revert the ".can_queue" part and test again?

Thanks.

---
 drivers/ata/ahci.h    |    2 +-
 drivers/ata/libahci.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -365,7 +365,7 @@ extern struct device_attribute *ahci_sde
  */
 #define AHCI_SHT(drv_name)						\
 	ATA_NCQ_SHT(drv_name),						\
-	.can_queue		= AHCI_MAX_CMDS - 1,			\
+	.can_queue		= 1/*AHCI_MAX_CMDS - 1*/,		\
 	.sg_tablesize		= AHCI_MAX_SG,				\
 	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
 	.shost_attrs		= ahci_shost_attrs,			\
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -420,7 +420,7 @@ void ahci_save_initial_config(struct dev
 		hpriv->saved_cap2 = cap2 = 0;
 
 	/* some chips have errata preventing 64bit use */
-	if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
+	if ((cap & HOST_CAP_64)/* && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)*/) {
 		dev_info(dev, "controller can't do 64bit DMA, forcing 32bit\n");
 		cap &= ~HOST_CAP_64;
 	}

-- 
tejun
