From: Christer Weinigel <christer@weinigel.se>
Subject: Re: Driver retries disk errors.
Date: 01 Sep 2004 00:55:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <m3isay9atv.fsf@zoo.weinigel.se>
References: <20040830163931.GA4295@bitwizard.nl>
	<1093952715.32684.12.camel@localhost.localdomain>
	<20040831135403.GB2854@bitwizard.nl>
	<1093961570.597.2.camel@localhost.localdomain>
	<20040831155653.GD17261@harddisk-recovery.com>
	<1093965233.599.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268648AbUHaXBc@vger.kernel.org>
In-Reply-To: <1093965233.599.8.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Retries also pop up in other less obvious cases and conveniently paper
> over a wide variety of timeouts, power management quirks and drives just
> having a random fit. Eight is probably excessive in all cases.
> 
> For non hard disk cases many devices do want and need retry.

For ripping CDs I'd prefer if the application could control retries
and not default to what the CD player prefers.

I have a CD, KLF -- Ultra Rare Tracks, and unfortunately someone I
borrowed it to managed to literally stomp on it, so the record has a
lot of scratches.  I would very much like to rip as much as possible
of this CD so that I can at least listen to part of it, but every time
I have tried the CD player just gets stuck in an endless retry loop.

The same thing happens when trying to rip a "copy controlled" CD,
which is also pretty irritating since this means that I can't rip my
Teddybears Stockholm CD and put the songs on my iPod.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
