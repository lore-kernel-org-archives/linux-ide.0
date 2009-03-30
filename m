From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] de: drivers/ide/ide-atapi.c needs <linux/scatterlist.h>
Date: Mon, 30 Mar 2009 22:29:31 +0200
Message-ID: <200903302229.31846.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0903292229400.23398@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:21738 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZC3U0d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2009 16:26:33 -0400
In-Reply-To: <Pine.LNX.4.64.0903292229400.23398@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Dmitri Vorobiev <dmitri.vorobiev@movial.com>

On Sunday 29 March 2009, Geert Uytterhoeven wrote:
> On m68k:
> | drivers/ide/ide-atapi.c: In function 'ide_io_buffers':
> | drivers/ide/ide-atapi.c:87: error: implicit declaration of function 'sg_page'
> | drivers/ide/ide-atapi.c:87: warning: passing argument 1 of 'PageHighMem' makes pointer from integer without a cast
> | drivers/ide/ide-atapi.c:91: warning: passing argument 1 of 'kmap_atomic' makes pointer from integer without a cast
> | drivers/ide/ide-atapi.c:96: error: implicit declaration of function 'sg_virt'
> | drivers/ide/ide-atapi.c:96: warning: assignment makes pointer from integer without a cast
> | drivers/ide/ide-atapi.c:107: error: implicit declaration of function 'sg_next'
> | drivers/ide/ide-atapi.c:107: warning: assignment makes pointer from integer without a cast
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

thanks, applied

[ Dmitri, sorry but m68k was faster than MIPS this time ;) ]

> ---
> No idea where it got introduced. 2.6.29 was fine.

Hmm... the issue went unnoticed because it was mitigated in linux-next
by ide_pio_bytes() conversion (resulting in ide_io_buffers() removal)...

>  drivers/ide/ide-atapi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index 6adc5b4..445d157 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -6,6 +6,8 @@
>  #include <linux/cdrom.h>
>  #include <linux/delay.h>
>  #include <linux/ide.h>
> +#include <linux/scatterlist.h>
> +
>  #include <scsi/scsi.h>
>  
>  #ifdef DEBUG
