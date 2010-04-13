From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: linux-ide: hda: possibly failed opcode: 0x25 on Alpha with 2.6.34-rc3
Date: Tue, 13 Apr 2010 17:34:57 +0200
Message-ID: <201004131734.57365.bzolnier@gmail.com>
References: <20100406232659.GA4788@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:36009 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab0DMPgo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Apr 2010 11:36:44 -0400
In-Reply-To: <20100406232659.GA4788@physik.fu-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 07 April 2010 01:26:59 am Adrian Glaubitz wrote:
> Dear IDE maintainers,

I'm flattered but nowadays I'm just a maintainer of a modest
out-of-tree project or two.. ;-)

> I recently installed Debian unstable on an old digital personal
> workstation 433au alpha (Miata) [1] with the default kernel 2.6.32
> from Debian unstable. There were no obvious problems except for the
> tulip network driver which produced a lot of noise [2]. Joe Perches was
> so kind to provide a patch to reduce the noise. I applied the patch
> against 2.6.34-rc3 and rebuilt the kernel with the 2.6.32 Debian
> config using "make oldconfig". The kernel build took around 18 hours ;).
> 
> Anyway, after rebooting the machine into the new kernel (2.6.34-rc3), the
> IDE driver obviously triggered a lot of errors [3] resulting in the kernel
> not being able to mount the root partition.

I think that the highest chance of bringing the right people's
attention to this kernel regression would be achieved by filling
the official bug-report at https://bugzilla.kernel.org/.

Thanks.
--
Bartlomiej Zolnierkiewicz
