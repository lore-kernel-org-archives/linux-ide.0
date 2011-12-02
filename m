From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Fri, 2 Dec 2011 23:22:43 +0000
Message-ID: <20111202232243.6af6f1e2@lxorguk.ukuu.org.uk>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
	<20111110152606.GB3207@oksana.dev.rtsoft.ru>
	<20111110153816.239af1d7@lxorguk.ukuu.org.uk>
	<20111110162859.GA7088@oksana.dev.rtsoft.ru>
	<20111202191917.GB3037@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111202191917.GB3037@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>
List-Id: linux-ide@vger.kernel.org

> This is now broken on ARM where, for good or bad, NO_IRQ currently is
> used and is -1.

Good.

ARM developers have been told to change this for several years. The nice
approach hasn't worked, the patient approach hasn't worked so now finally
ARM is going to be dragged kicking and screaming into doing the work
everyone else did several years ago.

I have so little sympathy over this that you'll need a quantum physicist
to measure it.

> Half-removing NO_IRQ is going to be problematic, though...
> I really don't care whether the "no irq" value is 0 or -1, but it is
> abundantly clear that choosing different values to mean the same thing
> on opposite sides of an interface does not work.

You've had years to fix it. If I were you I'd delete NO_IRQ from your
tree, type make and get it done. It's not even a big job to clean it out.

At that point various other drivers will also start working properly on
ARM because they use 0 for polled mode.

Alan
