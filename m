From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] avr32 mustn't select HAVE_IDE
Date: Tue, 15 Apr 2008 22:09:19 +0200
Message-ID: <200804152209.19837.bzolnier@gmail.com>
References: <20080414141650.GD6695@cs181133002.pp.htv.fi> <20080414175457.GB15028@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:31989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbYDOVTm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:42 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140209fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:40 -0700 (PDT)
In-Reply-To: <20080414175457.GB15028@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@kernel.org>, hskinnemoen@atmel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 14 April 2008, Sam Ravnborg wrote:
> On Mon, Apr 14, 2008 at 05:16:50PM +0300, Adrian Bunk wrote:
> > There's a libata based PATA driver for avr32, but no support for 
> > drivers/ide/ on avr32.
> > 
> > This patch fixes the following compile error:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC [M]  drivers/ide/ide-cd.o
> > In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/ide-cd.c:37:
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/ide.h:209:21: error: asm/ide.h: No such file or directory
> > make[3]: *** [drivers/ide/ide-cd.o] Error 1
> > 
> > <--  snip  -->
> > 
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> Obviously correct.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

applied
