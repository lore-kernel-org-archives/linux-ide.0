From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Fix build error in pata_of_platform (NO_IRQ usage)
Date: Thu, 10 Nov 2011 15:35:50 +0000
Message-ID: <20111110153550.6274179d@lxorguk.ukuu.org.uk>
References: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au>
	<4E94A920.40503@xenotime.net>
	<4E987829.3080104@xenotime.net>
	<20111110135703.GA23609@elte.hu>
	<20111110151852.GA7465@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60456 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751465Ab1KJPfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 10:35:24 -0500
In-Reply-To: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org

> The proper fix (stop OF code from returning NO_IRQ values) is pending.

Please just apply the proper fix.

> - The NO_IRQ disease spreads despite our willingness, even within
>   the new OF code.

Then it can stop right here, because if the arch people don't fix their
code to use zero their ATA port won't work.

> +/* For archs that don't support NO_IRQ (such as x86), provide a dummy value */
> +#ifndef NO_IRQ
> +#define NO_IRQ 0
> +#endif

NAK - just test against zero. They've been complained at about this for
over two years. Enough is enough.

Alan
