From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-dma: fix ide_build_dmatable() for TRM290
Date: Thu, 16 Oct 2008 21:48:47 +0200
Message-ID: <200810162148.47262.bzolnier@gmail.com>
References: <200809282241.26289.sshtylyov@ru.mvista.com> <48F72CC7.2040202@ru.mvista.com> <48F73198.20209@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:61815 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992AbYJPTwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 15:52:54 -0400
Received: by gxk9 with SMTP id 9so157868gxk.13
        for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 12:52:52 -0700 (PDT)
In-Reply-To: <48F73198.20209@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 16 October 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> Apparently, 'xcount' being 0 does not mean 0 bytes for TRM290; it 
> >> means 4 bytes, judging from the code immediately preceding this 
> >> check.  So, we must never try
> >> to "split" the PRD for TRM290.
> >>
> >> This is probably never hit anyway -- with the DMA buffers aligned to 
> >> at least
> >> 512 bytes and ATAPI DMA not being used for non block I/O commands...
> >>
> >> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>   
> >
> >   Bart, unfortunately, drivers/ide/ide-dma-sff.c has the same mistake 
> > -- you probably forgot to modify the patch splitting it from 
> > ide-dma.c... :-/
> 
>    Even the one cleaning up ide_build_dmatable() actually...

Thanks for noticing and sorry for that.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: re-add TRM290 fix lost during ide_build_dmatable() cleanup

commit 14c123f37187aba0b4e0e893a969efc6820c4170 ("ide: cleanup
ide_build_dmatable()") accidentally reverted TRM290 fix introduced
by commit 22e05b4549bf2405d6aca128540b20cd2dd33f1f ("ide-dma: fix
ide_build_dmatable() for TRM290").

Reported-by: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma-sff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-dma-sff.c
===================================================================
--- a/drivers/ide/ide-dma-sff.c
+++ b/drivers/ide/ide-dma-sff.c
@@ -130,7 +130,7 @@ int ide_build_dmatable(ide_drive_t *driv
 			xcount = bcount & 0xffff;
 			if (is_trm290)
 				xcount = ((xcount >> 2) - 1) << 16;
-			if (xcount == 0x0000) {
+			else if (xcount == 0x0000) {
 				if (count++ >= PRD_ENTRIES)
 					goto use_pio_instead;
 				*table++ = cpu_to_le32(0x8000);
