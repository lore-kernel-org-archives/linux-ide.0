From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [2.6 patch] avr32 mustn't select HAVE_IDE
Date: Mon, 14 Apr 2008 19:54:57 +0200
Message-ID: <20080414175457.GB15028@uranus.ravnborg.org>
References: <20080414141650.GD6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932272AbYDNRy7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080414141650.GD6695@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: hskinnemoen@atmel.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Apr 14, 2008 at 05:16:50PM +0300, Adrian Bunk wrote:
> There's a libata based PATA driver for avr32, but no support for 
> drivers/ide/ on avr32.
> 
> This patch fixes the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/ide/ide-cd.o
> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/ide-cd.c:37:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/ide.h:209:21: error: asm/ide.h: No such file or directory
> make[3]: *** [drivers/ide/ide-cd.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
Obviously correct.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
