From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] remove CONFIG_IDE_MAX_HWIFS
Date: Tue, 29 Jul 2008 21:45:21 +0200
Message-ID: <200807292145.21681.bzolnier@gmail.com>
References: <20080727130448.GK9301@cs181140183.pp.htv.fi> <200807271632.16417.bzolnier@gmail.com> <20080729164801.GB23951@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:8274 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbYG2Tvd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 15:51:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so26840fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 29 Jul 2008 12:51:32 -0700 (PDT)
In-Reply-To: <20080729164801.GB23951@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 29 July 2008, Adrian Bunk wrote:
> On Sun, Jul 27, 2008 at 04:32:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 27 July 2008, Adrian Bunk wrote:
> >...
> > > <--  snip  -->
> > > 
> > > Considering the little benefits of all this fiddling with IDE_MAX_HWIFS 
> > > I decided to fix it through a simplification:
> > > - always #define MAX_HWIFS      CONFIG_IDE_MAX_HWIFS
> > > - always set CONFIG_IDE_MAX_HWIFS in kconfig
> > > - let IDE_MAX_HWIFS default to 10
> > > - allow changing the value of IDE_MAX_HWIFS only if IDE && EMBEDDED
> > 
> > I was actually wondering whether it is worth to keep IDE_MAX_HWIFS
> > now that ide_hwif_t instances are allocated dynamically.
> > 
> > [ The difference between MAX_HWIFS == 10 and MAX_HWIFS == 2 is now
> >   ~100 bytes (x86_32) and between MAX_HWIFS == 10 and MAX_HWIFS == 1
> >   it is ~1kb (IIRC). ]
> > 
> > Since there were also many other improvements in shrinking drivers/ide/
> > code size which should keep embedded users happy and compensate for
> > the above 1kB-worst-case I would prefer to have IDE_MAX_HWIFS removed
> > completely.
> >...
> 
> Patch below.

applied

Thanks Adrian!
