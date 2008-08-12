From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 12 Aug 2008 18:04:57 +0400
Message-ID: <20080812140457.GA9103@oksana.dev.rtsoft.ru>
References: <48A05152.7020508@harris.com> <20080811151913.GA14690@oksana.dev.rtsoft.ru> <48A0676E.5020308@harris.com> <20080811170756.GA29827@oksana.dev.rtsoft.ru> <1218492032.8041.11.camel@pasglop> <48A19788.6050502@harris.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:57721 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752327AbYHLOE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 10:04:59 -0400
Content-Disposition: inline
In-Reply-To: <48A19788.6050502@harris.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Steven A. Falco" <sfalco@harris.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks, Sam" <SSparks@aclaratech.com>, linux-ide@vger.kernel.org

On Tue, Aug 12, 2008 at 10:00:40AM -0400, Steven A. Falco wrote:
> Benjamin Herrenschmidt wrote:
> >   
> >> 1. IDE status read does not work. (But am I understand correctly
> >>    that IDE works well if IRQ is unspecified? Then this is hardly
> >>    an issue.)
> >> 2. IDE interrupt comes when it should not. I'd recommend to use
> >>    oscilloscope to find out what is happening there, that is, if
> >>    the drive actually deasserts its irq line after status read.
> >>    If so, than this could be a PIC problem.
> >>
> >> What is the platform on which you're observing the issue, btw?
> >>     
> >
> > Another possibility is that you got the wrong interrupt number
> > in the device-tree...
> >
> > Ben.
> >   
> 
> The platform is the AMCC Sequoia board.  We've built a little adapter to
> connect a compact flash card to the processor bus.  I believe the
> interrupt selection in the device tree is correct, and I've checked over
> the u-boot settings for the IRQ line (active high, level sensitive). 

IDE IRQs are active-low.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
