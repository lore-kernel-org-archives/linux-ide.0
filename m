From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: linux-ide: hda: possibly failed opcode: 0x25 on Alpha with
 2.6.34-rc3
Date: Tue, 13 Apr 2010 18:46:40 +0200
Message-ID: <20100413164640.GD10612@physik.fu-berlin.de>
References: <20100406232659.GA4788@physik.fu-berlin.de>
 <201004131734.57365.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38341 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753302Ab0DMQqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Apr 2010 12:46:44 -0400
Content-Disposition: inline
In-Reply-To: <201004131734.57365.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

thank you very much for your kind reply!

On Tue, Apr 13, 2010 at 05:34:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 07 April 2010 01:26:59 am Adrian Glaubitz wrote:
> > Dear IDE maintainers,
> 
> I'm flattered but nowadays I'm just a maintainer of a modest
> out-of-tree project or two.. ;-)

Hehe, just trying to keep good manners in public ;).

> 
> > I recently installed Debian unstable on an old digital personal
> > workstation 433au alpha (Miata) [1] with the default kernel 2.6.32
> > from Debian unstable. There were no obvious problems except for the
> > tulip network driver which produced a lot of noise [2]. Joe Perches was
> > so kind to provide a patch to reduce the noise. I applied the patch
> > against 2.6.34-rc3 and rebuilt the kernel with the 2.6.32 Debian
> > config using "make oldconfig". The kernel build took around 18 hours ;).
> > 
> > Anyway, after rebooting the machine into the new kernel (2.6.34-rc3), the
> > IDE driver obviously triggered a lot of errors [3] resulting in the kernel
> > not being able to mount the root partition.
> 
> I think that the highest chance of bringing the right people's
> attention to this kernel regression would be achieved by filling
> the official bug-report at https://bugzilla.kernel.org/.

Ok, I will report the problem there. Btw, the problem doesn't occur
with 2.6.33.2 either so it definetely seems to be a regression with
2.6.34. Unfortunately, I don't have the machine at hand anymore, so I
won't be able to test in near future :(. Very sorry. However, I know
someone who still has such a workstation, I will ask him to test.


Thanks,

Adrian
