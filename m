From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Implementing CONFIG_IDE_POLL
Date: Thu, 22 Apr 2004 06:00:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404220600.43718.bzolnier@elka.pw.edu.pl>
References: <20040407034240.GA31195@flea>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6598 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263183AbUDVEBM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Apr 2004 00:01:12 -0400
In-Reply-To: <20040407034240.GA31195@flea>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org


Yes, it was way too long delay, sorry...

On Wednesday 07 of April 2004 05:42, Marc Singer wrote:
> I've taken a stab at implementing a polling mode for an IDE
> implementation that lacks interrupts.  Yes, yes, I know, I know.
> Changing the hardware *is* the right answer.  Well, that doesn't
> appear to be happening before I need to ship some running code.
>
> So, I've made something that works.  It turns out not to be too
> difficult nor invasive.  Essentially, I'm allowing the the hardware
> initialization to pass IDE_NO_IRQ such that there is no IRQ probing
> and no one attempts to enable or disable that interrupt.  Then there
> is an ide_poll() function which is called at a couple of different
> places.  It does what it can if the device is ready, or it sets a
> timer if there is more to be done and it looks like it might be a long
> wait.  This code is working on my target platform.  I can use a CF
> card for the root filesystem.
>
> I'm looking for some constructive criticism.  Overall, this
> implementation was more complex that I would have liked.  Am I missing
> anything important?  Is there a better way?
>
> There is one part that is missing.  IDE_POLL is set true when the
> ARCH_LPD7A40X architecture is defined.

ide-lpd7a40x.c and arch-lh7a40x/ide.h should be merged into a IDE driver.

drivers/ide/arm/ is the right place for this code

ide_register_hw() is obsolete, please use &ide_hwifs[0] directly for now...

Why you can't reuse hwgroup->timer for polling?

Regards,
Bartlomiej

