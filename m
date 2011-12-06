From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 07:13:21 +0100
Message-ID: <20111206061321.GH9192@game.jcrosoft.org>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205184522.316598de@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111205184522.316598de@lxorguk.ukuu.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 18:45 Mon 05 Dec     , Alan Cox wrote:
> > But as you illustrated, there is a large number of drivers that already 
> > assume no IRQ is < 0, even if they don't use any IRQ #0 themselves.  
> > That is a much bigger problem to fix.
> 
> And a much larger number assuming the reverse is true which are hiding
> potential bugs on ARM.
> 
> Looking at the serial stuff the best checks appear to be looking at
> "irq", "-1" and NO_IRQ.
> 
> For migration stuff that's doing broken things like
> 
> 	if (irq < 0)
> 
> can be changed to
> 
> 	if (irq <= 0)
> 
> and that can be done before NO_IRQ itself is nailed on ARM and PA-RISC.
can we sinply introduce a macro irq_is_valid

and make it chip dependant as gpio_is_valid
and then move away from irq 0 valid

so we do not need to brake anthing first and then easly convert them

Best Regards,
J.
