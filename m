From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 2/2] libata: no need to speed down if already at
	PIO0
Date: Mon, 29 Oct 2007 16:45:05 +0900
Message-ID: <20071029074505.GP11853@htj.dyndns.org>
References: <20071029074109.GO11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:5386 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbXJ2HpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 03:45:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1494960rvb
        for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 00:45:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071029074109.GO11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

After reset, transfer mode is always PIO0 regardless of
dev->xfer_mask.  Check dev->pio_mode before trying to slow down after
configuration failure.  This prevents bogus speed down before device
is actually configured.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <lan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-eh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2437,7 +2437,7 @@ static int ata_eh_handle_dev_fail(struct
 		/* give it just one more chance */
 		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
 	case -EIO:
-		if (ehc->tries[dev->devno] == 1) {
+		if (ehc->tries[dev->devno] == 1 && dev->pio_mode > XFER_PIO_0) {
 			/* This is the last chance, better to slow
 			 * down than lose it.
 			 */
