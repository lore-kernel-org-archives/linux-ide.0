From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] remove unneeded #include <linux/ide.h>'s
Date: Tue, 29 Jul 2008 21:43:22 +0200
Message-ID: <200807292143.23094.bzolnier@gmail.com>
References: <20080727130448.GK9301@cs181140183.pp.htv.fi> <200807271632.16417.bzolnier@gmail.com> <20080729164831.GC23951@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:8530 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbYG2Tvc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 15:51:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so26829fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 29 Jul 2008 12:51:30 -0700 (PDT)
In-Reply-To: <20080729164831.GC23951@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 29 July 2008, Adrian Bunk wrote:
> On Sun, Jul 27, 2008 at 04:32:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 27 July 2008, Adrian Bunk wrote:
> > > The sh systemh_defconfig currently fails to build with the following 
> > > error:
> > > 
> > > <--  snip  -->
> > > 
> > > ...
> > >   CC      arch/sh/boards/renesas/systemh/irq.o
> > > In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/boards/renesas/systemh/irq.c:16:
> > > /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/ide.h:645: error: 'CONFIG_IDE_MAX_HWIFS' undeclared here (not in a function)
> > > make[2]: *** [arch/sh/boards/renesas/systemh/irq.o] Error 1
> > 
> > Please also fix the source root of the problem:
> > 
> > arch/sh/boards/renesas/systemh/irq.c should have no bussiness in
> > including include/linux/ide.h (which is for drivers/ide/ _only_)
> >...
> 
> ide-scsi.c and the mediabay stuff might qualify as exceptions?

Yes, they are exceptions confirming the rule. :)

> For the rest a patch is below (on top of your #include <linux/hdreg.h> 
> removal patch).

applied
