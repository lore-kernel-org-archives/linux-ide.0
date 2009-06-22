From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] IDE: Silent compiler warning in ide_pio_bytes()
Date: Mon, 22 Jun 2009 22:55:08 +0200
Message-ID: <20090622205508.GA25045@liondog.tnic>
References: <20090622211052.45b3cfc5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f224.google.com ([209.85.220.224]:62063 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZFVUzL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 16:55:11 -0400
Received: by fxm24 with SMTP id 24so1034123fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2009 13:55:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090622211052.45b3cfc5@hyperion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Mon, Jun 22, 2009 at 09:10:52PM +0200, Jean Delvare wrote:
> PageHighMem() isn't cheap so avoid calling it several times on the
> same page. I had the hope that this would silent the following
> compilation warning:
> 
> drivers/ide/ide-taskfile.c: In function 'ide_pio_bytes':
> drivers/ide/ide-taskfile.c:229: warning: 'flags' may be used uninitialized in this function
> 
> which is a false positive, but it did not. So let's just initialize the
> flags and be done with it, so that other developers don't waste their
> time looking at it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-taskfile.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.31-pre.orig/drivers/ide/ide-taskfile.c	2009-06-21 09:37:02.000000000 +0200
> +++ linux-2.6.31-pre/drivers/ide/ide-taskfile.c	2009-06-21 12:18:47.000000000 +0200
> @@ -226,7 +226,7 @@ void ide_pio_bytes(ide_drive_t *drive, s
>  	struct scatterlist *sg = hwif->sg_table;
>  	struct scatterlist *cursg = cmd->cursg;
>  	struct page *page;
> -	unsigned long flags;
> +	unsigned long flags = 0;	/* Silent compiler warning */

or maybe

	unsigned long uninitialized_var(flags);

>  	unsigned int offset;
>  	u8 *buf;

[..]

-- 
Regards/Gruss,
    Boris.
