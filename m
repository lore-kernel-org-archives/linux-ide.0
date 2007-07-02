From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes passed from user-space
Date: Mon, 2 Jul 2007 21:13:54 +0200
Message-ID: <200707022113.54449.bzolnier@gmail.com>
References: <200706302110.20766.bzolnier@gmail.com> <46894478.9070808@garzik.org> <200707022055.13683.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:26771 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbXGBS6Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 14:58:25 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2494887mue
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 11:58:24 -0700 (PDT)
In-Reply-To: <200707022055.13683.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Monday 02 July 2007, Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 July 2007, Jeff Garzik wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > On Monday 02 July 2007, Jeff Garzik wrote:
> > >> Bartlomiej Zolnierkiewicz wrote:
> > >>> This would brake setups which currently work OK, i.e. BIOS set things up
> > >>> (reminds me about cmd64x vs broken MWDMA)...
> > >>>
> > >>> The RightThing(tm) to do is to fix alim15x3 driver to program DMA timings
> > >>> (especially given that pata_ali seems to already contain the needed code).
> > >> I am not ready to trust that pata_ali works as well as alim15x3 in all 
> > >> cases.  Someone should test e.g. Alpha AXP systems with IDE (use 
> > >> alim15x3) to make sure all is well.
> > > 
> > > Sure but there is no problem with the new code in alim15x3 being X86 until
> > > it is verified to work with Alpha AXP machines etc...
> > 
> > I'm not sure I follow.  You now want to mark alim15x3 X86-only?  Or add 
> > the new code inside #ifdef X86?
> 
> Add the new code inside #ifdef X86, marking alim15x3 X86-only would be
> on over-kill...
> 
> > >> alim15x3 covers buggy, ugly, quirky chipsets.  I consider that coverage 
> > >> in general highly fragile.
> > > 
> > > and in case of MWDMA modes also highly dependent on BIOS settings
> > > which very likely results in broken suspend/resume...
> > 
> > Agreed.  But I would rather verify that timing programming works on 
> > supported platforms, before expanding use of said new code?

WRT expanding use of the new code:

The same code is used for initial tuning and re-tuning during resume...

If the new code doesn't work fine the game is already over since
it is used during driver initialization to tune DMA...

> Sure given that you have Alpha and Sparc machines handy for testing...
> 
> I don't so testing all supported platforms could take a while,
> in the meantime X86 users could enjoy fixed suspend/resume support...

After quick check I also seem to lack X86 ALI machine to test so
I'm counting on somebody else beating me to fixing alim15x3...

Thanks,
Bart
