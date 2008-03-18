From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 2/2] pata_it821x: use raw nbytes in check_atapi_dma
Date: Tue, 18 Mar 2008 17:56:12 +0900
Message-ID: <47DF83AC.40606@gmail.com>
References: <47D5EFD4.2090801@gmail.com> <47DE63C8.2000006@garzik.org> <47DF81AF.7080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:44748 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYCRI4S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 04:56:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6829467wah.23
        for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2008 01:56:17 -0700 (PDT)
In-Reply-To: <47DF81AF.7080000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

pata_it821x needs to look at raw request size in check_atapi_dma().

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
This should restore the original behavior.  However, there's a catch.
Alan, you said DMA behavior on pata_it821x genuinely depends on
transfer size, right?  Then, it can be one of the following two.

1. It depends on the size of the buffer handed to the controller, in
   which case qc->nbytes is the right value to look at.  For pata_ali,
   this definitely wasn't the case as small DMA transfers failed even
   though large aligned buffer was supplied.

2. It depends on the size of the data the drive transfers in response
   of the command.  In this case, checking raw or any size on host
   size is useless as the drive may transfer any number of bytes.  In
   this case, we should use command type to determine whether DMA can
   be used or not as we can guarantee certain transfer sizes for
   certain commands.  pata_ali fell into this category.

All in all, I think discerning #1 from #2 is hair-splitting for not
enough benefit (heh.. yeah, I'm going there again) and applying #1 for
controllers which fall in #2 is dangerous while the other way is fine.
I think it's better to just implement atapi_check_dma_rw_only() and
use it for these controllers.

Anyways, this patch restores the old behavior and should be fine for
2.6.25.

Thanks.

 drivers/ata/pata_it821x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -564,7 +564,7 @@ static int it821x_check_atapi_dma(struct
 	struct it821x_dev *itdev = ap->private_data;
 
 	/* Only use dma for transfers to/from the media. */
-	if (qc->nbytes < 2048)
+	if (ata_qc_raw_nbytes(qc) < 2048)
 		return -EOPNOTSUPP;
 
 	/* No ATAPI DMA in smart mode */
