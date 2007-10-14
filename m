From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates (part 1)
Date: Sun, 14 Oct 2007 17:38:39 +0200
Message-ID: <200710141738.39838.bzolnier@gmail.com>
References: <200710120034.49730.bzolnier@gmail.com> <Pine.LNX.4.64N.0710121518030.21684@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:26712 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629AbXJNQQZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 12:16:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1073003nfb
        for <linux-ide@vger.kernel.org>; Sun, 14 Oct 2007 09:16:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64N.0710121518030.21684@blysk.ds.pg.gda.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 12 October 2007, Maciej W. Rozycki wrote:
> On Fri, 12 Oct 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> > * Kconfig facelift - as a result of this change users have three less
> >   config options to worry about (BLK_DEV_IDEPCI, BLK_DEV_IDEDMA_PCI
> >   and IDE_CHIPSETS) and can just select host drivers that they need
> 
>  Well, it depends on how you look at it.  If you have PCI, an on-board IDE 
> interface and do not want any PCI IDE controllers, then you now have a 
> zillion of options to disable instead of just one.  Have a look at 
> "arch/mips/configs/sb1250-swarm_defconfig" for an example (hmm..., 

I see, having suddenly zillion options to go through and disable may be
problem.  Fortunately not in this particular case because none of IDE PCI
host drivers is enabled by default in drivers/ide/Kconfig.

To be sure I've just checked it with:

ARCH=mips make sb1250-swarm_defconfig menuconfig

and it looks fine (all IDE PCI host drivers are disabled).

However big thanks for raising this point.  I was unaware of such side-effect
while working on the above change but from now on I'll keep this in mind. :)

> CONFIG_BLK_DEV_IDE_SWARM disabled by default -- that should probably be 
> changed; I'll cook a patch).  I guess it is not possible to make everyone 
> happy at once though, so please do not treat it as a hard objection. :-)

Hmm, it also seems that CONFIG_IDE_GENERIC=y may be removed now because
IDE SWARM host driver does the probing itself?

Thanks,
Bart
