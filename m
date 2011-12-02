From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Sat, 3 Dec 2011 02:40:18 +0400
Message-ID: <20111202224018.GB7780@oksana.dev.rtsoft.ru>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
 <20111110152606.GB3207@oksana.dev.rtsoft.ru>
 <20111110153816.239af1d7@lxorguk.ukuu.org.uk>
 <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202191917.GB3037@localhost.localdomain>
 <20111202223402.GA7780@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111202223402.GA7780@oksana.dev.rtsoft.ru>
Sender: linux-next-owner@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Dec 03, 2011 at 02:34:02AM +0400, Anton Vorontsov wrote:
> On Fri, Dec 02, 2011 at 07:19:17PM +0000, Dave Martin wrote:
> [...]
> > > > > Drivers should not use NO_IRQ; moreover, some architectures don't
> > > > > have it nowadays. '0' is the 'no irq' case.
> > > > > 
> > > > > Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > > > 
> > > > Acked-by: Alan Cox <alan@linux.intel.com>
> > > 
> > > In case if we don't want a "band-aid fix" for 3.2, here is the patch
> > > that just does the proper fix (w/ a risk to break minor architectures).
> > 
> > This is now broken on ARM where, for good or bad, NO_IRQ currently is
> > used and is -1.
> > 
> > How do we resolve it?
> 
> One option is to test this patch on a board that is now broken:
> 
> http://lkml.org/lkml/2011/11/10/290

Oh, actually, reading my own patch:

"ARM defines NO_IRQ to -1, but OF code relies on IRQ domains support,
 which returns correct ('0') value in 'no irq' case. So everything
 should be fine."


I forgot that on ARM we use IRQ domains, so ARM should be OK.

Do you really see any breakage, and if so, what board?

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
