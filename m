From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 27 Oct 2008 07:15:57 +0100
Message-ID: <20081027061556.GA17928@gollum.tnic>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810260938.55709.valerio.passini@unicam.it> <20081026145819.GA1320@gollum.tnic> <200810262101.42874.valerio.passini@unicam.it>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:41335 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYJ0GQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 02:16:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1824915fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 26 Oct 2008 23:16:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810262101.42874.valerio.passini@unicam.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valerio Passini <valerio.passini@unicam.it>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: valerio.p@libero.it, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

On Sun, Oct 26, 2008 at 09:01:42PM +0100, Valerio Passini wrote:

[.. ]

> Here I am, thus the patched kernel has been installed and tested.
> Burning CD's and simulation work perfectly and everything seems fine.
> :)

Well, nice to hear :). Thanks for your debugging effort and patience.

Bart, please apply.

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Mon, 27 Oct 2008 06:59:14 +0100
Subject: [PATCH] ide-cd: fix dma alignment regression

e5318b531b008c79d2a0c0df06a7b8628da38e2f introduced a regression which
caused some ATAPI drives to turn off dma for REQ_TYPE_ATA_PC commands
while burning and thus degrating performance and ultimately causing an
excessive amount of underruns. The issue is documented also in
http://bugzilla.kernel.org/show_bug.cgi?id=11742.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Tested-by: Valerio Passini <valerio.passini@unicam.it>
---
 drivers/ide/ide-cd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 64b9cb1..ea35e94 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1204,7 +1204,8 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		 * separate masks.
 		 */
 		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
-		if ((unsigned long)buf & alignment || rq->data_len & alignment
+		if ((unsigned long)buf & alignment
+		    || rq->data_len & q->dma_pad_mask
 		    || object_is_on_stack(buf))
 			drive->dma = 0;
 	}
-- 
1.5.6.5


-- 
Regards/Gruss,
    Boris.
