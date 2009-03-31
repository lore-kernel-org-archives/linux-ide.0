From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] de: drivers/ide/ide-atapi.c needs <linux/scatterlist.h>
Date: Tue, 31 Mar 2009 09:05:53 +0200
Message-ID: <10f740e80903310005i57337594x175559b7c071b736@mail.gmail.com>
References: <Pine.LNX.4.64.0903292229400.23398@anakin>
	 <200903302229.31846.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:65048 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZCaHF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 03:05:56 -0400
In-Reply-To: <200903302229.31846.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Dmitri Vorobiev <dmitri.vorobiev@movial.com>

On Mon, Mar 30, 2009 at 22:29, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Sunday 29 March 2009, Geert Uytterhoeven wrote:
>> On m68k:
>> | drivers/ide/ide-atapi.c: In function 'ide_io_buffers':
>> | drivers/ide/ide-atapi.c:87: error: implicit declaration of function 'sg_page'
>> | drivers/ide/ide-atapi.c:87: warning: passing argument 1 of 'PageHighMem' makes pointer from integer without a cast
>> | drivers/ide/ide-atapi.c:91: warning: passing argument 1 of 'kmap_atomic' makes pointer from integer without a cast
>> | drivers/ide/ide-atapi.c:96: error: implicit declaration of function 'sg_virt'
>> | drivers/ide/ide-atapi.c:96: warning: assignment makes pointer from integer without a cast
>> | drivers/ide/ide-atapi.c:107: error: implicit declaration of function 'sg_next'
>> | drivers/ide/ide-atapi.c:107: warning: assignment makes pointer from integer without a cast
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> thanks, applied
>
> [ Dmitri, sorry but m68k was faster than MIPS this time ;) ]

Thanks!

>> ---
>> No idea where it got introduced. 2.6.29 was fine.
>
> Hmm... the issue went unnoticed because it was mitigated in linux-next
> by ide_pio_bytes() conversion (resulting in ide_io_buffers() removal)...

I meant that I didn't see any removals of #include <linux/scatterlist.h> nor
additions of sg_*() users since v2.6.29.
But I did wonder why we never saw it in linux-next...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
