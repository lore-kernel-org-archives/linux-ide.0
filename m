From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Fri, 2 Dec 2011 11:28:14 -0800
Message-ID: <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru> <20111202192618.GC3037@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49934 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab1LBT2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2011 14:28:35 -0500
In-Reply-To: <20111202192618.GC3037@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org

On Fri, Dec 2, 2011 at 11:26 AM, Dave Martin <dave.martin@linaro.org> w=
rote:
>
> This is now broken on ARM where, for good or bad, NO_IRQ currently is
> used and is -1.
>
> How do we resolve it? =A0If we are ready to eliminate NO_IRQ from
> drivers/of/irq.c (or indeed, all code that uses it) and just use 0 fo=
r
> that case, we should surely just do it... but I'm not confident I can
> judge on that.

Just stop using NO_IRQ. First in drivers/of/irq.c, then in any drivers
as you notice breakage.

Don't *change* NO_IRQ to zero (that whole #define is broken - leave it
around as a marker of brokenness), just start removing it from all the
ARM drivers that use the OF infrastructure. Which is presumably not
all that many yet.

So whenever you find breakage, the fix now is to just remove NO_IRQ
tests, and replace them with "!irq".

                       Linus
