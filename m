From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Sun, 3 Oct 2004 22:54:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410032254.16900.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston> <200410021656.30122.bzolnier@elka.pw.edu.pl> <1096763626.3634.58.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:13981 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268149AbUJCU4N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Oct 2004 16:56:13 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:54369 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S51589AbUJCU4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 22:56:12 +0200
Received: from chello084010012196.chello.pl ([84.10.12.196]:62463 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S480910AbUJCUwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sun, 3 Oct 2004 22:52:10 +0200
In-Reply-To: <1096763626.3634.58.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Sunday 03 October 2004 02:33, Benjamin Herrenschmidt wrote:
> On Sun, 2004-10-03 at 00:56, Bartlomiej Zolnierkiewicz wrote:
> 
> > I think that if platform is using specific driver it is a
> > correct place to put such information but I may be wrong.
> > 
> > Well, at least it allows somebody knowing nothing about specific
> > platform (me) to see what IRQs are needed and why they are needed.
> > Following all IDE code paths using the default stuff and guessing
> > which parts are overridden by specific platform can get you insane.
> > 
> > I know that is not perfect and I'm open for better ideas.
> 
> I see your point, but I'd still rather have some generic way (since
> the problem is actually common with controllers in legacy mode).
> 
> Something like
> 
>   if (hwif->irq == NO_IRQ) (*)
>       hwif->irq = ide_get_legacy_irq(hwif);

This is really bad from maintainability and sanity point of view ie.
you change something in IDE code and then suddenly have to grep
arch and platform specific code and worry about what these callbacks
wanted to achieve and watch out to not break them (or more likely,
don't know about this issue completely and break them silently :).
With placing IRQ setup in host drivers everything is clear _immediately_.

Also what happens when one architecture can use two different
drivers both needing different legacy IRQs?

Hm, why there are no such things in other (much more successful)
subsystems (SCSI, network) but some devices also use weird IRQs?

> Or maybe just de-obsolete one of the old "default" callbacks

grep kernel for occurrences of ide_default_irq() and then try to match
archs/platforms/IRQs to host drivers and code which setup IRQs vs code
which make use of it... really traumatic experience...

> (*) and please, don't compare with 0, 0 is a valid IRQ number on a
> number of platforms !)

ide-probe.c heavily depends on !hwif->irq but maybe somebody
will finally fix IDE to not use 0 to represent unknown IRQ.
