From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Sun, 3 Aug 2008 23:01:20 +0100
Message-ID: <20080803230120.155aa3e5@lxorguk.ukuu.org.uk>
References: <1217779055.4179.10.camel@localhost.localdomain>
	<58cb370e0808031309n54052c51m744c479aa69b2f4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44743 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757540AbYHCWSi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 18:18:38 -0400
In-Reply-To: <58cb370e0808031309n54052c51m744c479aa69b2f4a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

>   - "difficult" legacy PC-class hardware (i.e. secondary interface on
> CY82C693 etc)

Yep - probably an hours work but I've simply not been able to get the
relevant hardware to test.

> * There are still regressions in many libata PCI host drivers dating back
>   to their rushed introduction.

I don't think we have any that are real straight forward "you
forgot something" regressions now. There are a few "works with A not B"
cases in both directions that we'll probably take ages to figure out.

> * There are still corner case in libata core - PIO is dead slow
> compared to drivers/ide/,

There are two there - libata keeps IRQs blocked for longer in PIO mode as
well which is a factor for realtime that needs looking at, as well as
using 16bit not 32bit I/O for most devices (which is trivial to fix). The
IRQ masking stuff is more complex and old IDE handles it far better for
PIO on non shared IRQ interfaces. That is actually probably the most
complicated thing to address of the stuff you'd want to do if you were
going to kill off old IDE.

>   "serialized" hosts are not supported, some quirks for obsolete
> hardware got lost...

Serialized hardware has been supported since 2.6.24 or so. Not sure there
are any quirks for obsolete hardware now missing but its always fun
trying to nail them all. Libata can support per command serializing and
pretty much arbitarily complex serializing rules via qc_defer.

> > The proposal is to discuss the future of these two subsystems and arrive
> > at a consensus what's happening to each going forwards.
> 
> Well, I'm looking forward to discuss the future of Linux ATA support.

Have fun, but don't expect me to respect any decisions made off public
lists. I don't really see any point worrying about it - porting m68k to
libata is of minimal value for example and there is little likelyhood of
Amiga AHCI SATA suddenely appearing.

Alan
