From: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: Re: [PATCH] de: drivers/ide/ide-atapi.c needs <linux/scatterlist.h>
Date: Thu, 02 Apr 2009 13:56:39 +0300
Message-ID: <49D499E7.9020603@movial.com>
References: <Pine.LNX.4.64.0903292229400.23398@anakin> <200903302229.31846.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762204AbZDBK4x@vger.kernel.org>
In-Reply-To: <200903302229.31846.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
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

That's OK for me as long as Malta builds again :)

Dmitri
