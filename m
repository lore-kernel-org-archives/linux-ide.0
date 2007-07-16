From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Mon, 16 Jul 2007 21:29:26 +0200
Message-ID: <20070716192925.GA10124@bitwizard.nl>
References: <200706160123.55636.bzolnier@gmail.com> <4693D9B6.4090408@ru.mvista.com> <20070713161612.2f2ebb0b@the-village.bc.nu> <46979652.6040201@rtr.ca> <4697987E.3040406@ru.mvista.com> <4697D425.7000300@rtr.ca> <4697D518.7010108@ru.mvista.com> <4697D686.6090104@rtr.ca> <4697DAAE.5090704@ru.mvista.com> <4697E7E2.70303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757410AbXGPT3i@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4697E7E2.70303@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 13, 2007 at 05:00:18PM -0400, Mark Lord wrote:
> >   Ah, that makes sense -- during PIO interrupts happen a lot more often.
> >20 secs still seem to be too much.
> 
> I don't think so, even for modern drives.
> Figure 8-10 seconds max for spin-up,
> plus 6-9 seconds to do a sector re-assignment
> or retries on a bad block (a measured *real-life* value).
> 
> That adds up to 14-19 seconds, so 20 seconds is probably good.
> 
> Still, this does need to be adjustable for faster (CF) devices,
> and slower (optical/tape) devices, rather than just a single
> set of fixed timeout values.

In real life, with real bad blocks on real harddrives, some harddrives
take more than the DMA TIMEOUT time to read a single block, even without
having to spin up. 

The current code then resets the drive, on which the drive reports
"busy, not ready for command", and things go downhill from there. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
