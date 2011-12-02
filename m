From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Fri, 2 Dec 2011 14:40:37 -0800
Message-ID: <CA+55aFzUy2C26GbTqapEgh0wh5Z1wuH_-Kdm7yCdp6cnu46afQ@mail.gmail.com>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru> <20111110152606.GB3207@oksana.dev.rtsoft.ru>
 <20111110153816.239af1d7@lxorguk.ukuu.org.uk> <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202191917.GB3037@localhost.localdomain> <20111202223402.GA7780@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111202223402.GA7780@oksana.dev.rtsoft.ru>
Sender: linux-next-owner@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Dave Martin <dave.martin@linaro.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Dec 2, 2011 at 2:34 PM, Anton Vorontsov
<anton.vorontsov@linaro.org> wrote:
>
> One option is to test this patch on a board that is now broken:
>
> http://lkml.org/lkml/2011/11/10/290

That seems broken.

Spot the trouble:

  +	ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
  +				    oirq.size);
  +no_irq:
  +#ifdef NO_IRQ
  +#if NO_IRQ != 0
  +	if (ret == NO_IRQ)
  +		pr_warn("Hit NO_IRQ case for your arch. Drivers might expect "
  +			"NO_IRQ, but we return 0. If anything breaks, driver "
  +			"have to be fixed.\n");
  +#endif
  +#endif
  +	return ret;

It claims "we return 0", but then doesn't return zero.. Hmm?

                  Linus
