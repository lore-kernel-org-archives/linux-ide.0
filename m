From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [0/5] move hd.c to drivers/block/
Date: Wed, 25 Jun 2008 22:16:10 +0200
Message-ID: <200806252216.11112.bzolnier@gmail.com>
References: <20080609222155.GA1987@cs181133002.pp.htv.fi> <200806221521.33506.bzolnier@gmail.com> <20080624215407.GB18252@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:17889 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbYFYUd7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jun 2008 16:33:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1166800ywe.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Jun 2008 13:33:48 -0700 (PDT)
In-Reply-To: <20080624215407.GB18252@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tuesday 24 June 2008, Adrian Bunk wrote:
> On Sun, Jun 22, 2008 at 03:21:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 22 June 2008, Adrian Bunk wrote:
> > > On Tue, Jun 10, 2008 at 07:56:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > On Tuesday 10 June 2008, Adrian Bunk wrote:
> > > > > This patch limits BLK_DEV_HD_ONLY to the ARM platforms offering 
> > > > > IRQ_HARDDISK, fixing the following compile error on others:
> > > > > 
> > > > > <--  snip  -->
> > > > > 
> > > > > ...
> > > > >   CC      drivers/ide/legacy/hd.o
> > > > > ...
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'hd_times_out':
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: 'IRQ_HARDDISK' undeclared (first use in this function)
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: (Each undeclared identifier is reported only once
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: for each function it appears in.)
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'do_hd_request':
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:661: error: 'IRQ_HARDDISK' undeclared (first use in this function)
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'hd_init':
> > > > > /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:765: error: 'IRQ_HARDDISK' undeclared (first use in this function)
> > > > > make[3]: *** [drivers/ide/legacy/hd.o] Error 1
> > > > > 
> > > > > <--  snip  -->
> > > > > 
> > > > > Reported-by: Adrian Bunk <bunk@kernel.org>
> > > > > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> > > > 
> > > > applied, thanks
> > > > 
> > > > BTW Could you look into converting your "remove BLK_DEV_HD_ONLY" patch
> > > > into "move old hd driver to drivers/block/" one because the old hd driver
> > > > still has some uses (as noticed by Alan)?
> > > 
> > > drivers/ide/Makefile says:
> > >   # old hd driver must be last
> > > 
> > > Is this still true?
> > 
> > Yep.
> > 
> > > If yes then moving the driver to drivers/block/ requires switching to 
> > > late_initcall() since drivers/block/ is linked before drivers/ide/ .
> > 
> > Care to cook a patch?
> 
> Comes as part of this patchset.

thanks, I applied all patches
