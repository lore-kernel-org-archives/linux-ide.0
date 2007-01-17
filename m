From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Date: Wed, 17 Jan 2007 21:31:55 +0100
Message-ID: <17838.34747.222649.93821@alkaid.it.uu.se>
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
	<45AE539E.2040600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38089 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbXAQUhz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jan 2007 15:37:55 -0500
In-Reply-To: <45AE539E.2040600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, akira2.iguchi@toshiba.co.jp, arnd@arndb.de, kou.ishizaki@toshiba.co.jp, linas@austin.ibm.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > If there is a highly common case, the code for that case
 > > is available, and the code is cheap to execute (doesn't
 > > require too many additional variables), then having an
 > > explicit test + inline code is preferred. If any of these
 > > conditions isn't met, then I wouldn't bother converting
 > > the call to the if/inline/call combo.
 > 
 > 
 > To be a bit more specific, the branch being taken, or not, depends on 
 > the system setup.  For example, in sata_promise's case, with no other 
 > SATA controllers in use,
 > 
 > 	if (ap->ops->irq_on)
 > 		ap->ops->irq_on(ap);
 > 	else
 > 		ata_irq_on(ap);
 > 
 > the direct function call will ALWAYS be called.  But if you had a weird 
 > system with both Cell and Promise PDC203xx, then the branch is dependent 
 > on whether the activity comes from the Cell SATA or Promise SATA.
 > 
 > So it's highly predictable in a great many cases.
 > 
 > And it should be noted that it is a direct function call not inline, 
 > thus its if/indirect/direct not if/indirect/inline.
 > 
 > Does that change the answer at all?

The real benefits from identifying a common case is to inline
the code for it. So the fact that the common case is still a
full-blown function call here and not inline code means that
there's much less benefit from rewriting an indirect call as
an if/indirect/direct sequence.

There is some branch prediction benefit from having
if/call-indirect/call-direct-to-common-case instead of a
single call-indirect, but only if the common case really is
much more common than other cases, or if the other cases
are limited to just one (so there's two common cases).

I wouldn't change a call-indirect to if/call-indirect/call-direct
unless it's on a very hot path with a known dominant common case.
