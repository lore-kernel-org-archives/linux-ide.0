From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 07 Oct 2008 21:04:45 +1100
Message-ID: <1223373885.8157.49.camel@pasglop>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
	<20081007092605.GA28907@oksana.dev.rtsoft.ru>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081007092605.GA28907@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: avorontsov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Tejun Heo <tj@kernel.org>, Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
List-Id: linux-ide@vger.kernel.org

On Tue, 2008-10-07 at 13:26 +0400, Anton Vorontsov wrote:
> On Tue, Oct 07, 2008 at 10:30:59AM +0900, Tejun Heo wrote:
> > Anton Vorontsov wrote:
> > > On Mon, Oct 06, 2008 at 03:41:19PM -0500, Matt Sealey wrote:
> > >> There is a simple problem with the patch which is that an "IRQ 0" can and does
> > >> actually exist on a bunch of platforms, at least to the best of my knowledge.
> > >>
> > >> Checking for -1 (which means for definite, no irq at all, because it is
> > >> totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.
> > > 
> > > This was discussed years ago.
> > > 
> > > http://lkml.org/lkml/2005/11/22/159
> > > http://lkml.org/lkml/2005/11/22/227
> > > 
> > 
> > Would this break any existing platforms?
> 
> Nope.
> 
> The driver is only available for PPC platforms.
> 
> As time goes by one can change `depend on PPC_OF' to just `depends on
> OF', so that the driver will be also available for SPARC. And still
> it will work, because SPARC also understands VIRQ0 as invalid VIRQ.
> 

Yup, I agree. I'll pick it up in my next batch.

Cheers,
Ben.
