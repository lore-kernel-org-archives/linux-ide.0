From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Sun, 03 Oct 2004 10:33:46 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096763626.3634.58.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410011611.16859.bzolnier@elka.pw.edu.pl>
	 <1096691450.12039.3.camel@gaston>
	 <200410021656.30122.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:23740 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267648AbUJCAh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Oct 2004 20:37:58 -0400
In-Reply-To: <200410021656.30122.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sun, 2004-10-03 at 00:56, Bartlomiej Zolnierkiewicz wrote:

> I think that if platform is using specific driver it is a
> correct place to put such information but I may be wrong.
> 
> Well, at least it allows somebody knowing nothing about specific
> platform (me) to see what IRQs are needed and why they are needed.
> Following all IDE code paths using the default stuff and guessing
> which parts are overridden by specific platform can get you insane.
> 
> I know that is not perfect and I'm open for better ideas.

I see your point, but I'd still rather have some generic way (since
the problem is actually common with controllers in legacy mode).

Something like

  if (hwif->irq == NO_IRQ) (*)
      hwif->irq = ide_get_legacy_irq(hwif);

Or maybe just de-obsolete one of the old "default" callbacks

(*) and please, don't compare with 0, 0 is a valid IRQ number on a
number of platforms !)



