From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Mon, 26 Nov 2007 03:23:14 +0300
Message-ID: <20071126002314.GA20104@zarina>
References: <20071123175229.GA27143@localhost.localdomain>
	<4747751D.4060802@garzik.org> <20071124072613.GA7303@linux-sh.org>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20071124072613.GA7303@linux-sh.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Nov 24, 2007 at 04:26:13PM +0900, Paul Mundt wrote:
> On Fri, Nov 23, 2007 at 07:49:33PM -0500, Jeff Garzik wrote:
> > Anton Vorontsov wrote:
> > >Here is the PATA Platform driver using OF infrastructure.
> > >
> > >Mostly it's just a wrapper around a bit modified pata_platform
> > >driver.
> > >
> > >Patches are well split for the easier review:
> > >
> > >First one factors out platform_device specific bits and modifies
> > >pata_platform to be a library-alike driver (with platform_device
> > >default binding).
> > >
> The only issue I have here is that this library-like version has subtle
> semantic changes that will break existing drivers.

Actually I've tried to keep semantics intact:

+static int __devinit pata_platform_probe(struct platform_device *pdev)
[...]
+       /*
+        * And the IRQ
+        */
+       irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+       if (irq_res)
+               irq_res->flags = pp_info ? pp_info->irq_flags : 0;
[...]

So, I'm passing flags from the platform data. Did you overlook these
bits, or I'm still changing semantics somewhere else?

> irq_flags exists in struct pata_platform_info precisely for the IRQ
> resource IRQ flags (as opposed to the IORESOURCE flags, which are what
> the IRQ resource flags refer to instead). This change takes that for
> granted and just assumes we're going to be using the res->flags, which is
> both an invalid assumption, and will utterly break blackfin and others
> that depend on it.
> 
> Incidentally, we already have an include/linux/pata_platform.h. If this
> is going to be library-like, through the prototypes in there, rather than
> splitting them up betewen include/linux and drivers/ata. We don't need
> two headers.

My intention was: keep "private" declarations in the drivers/ata/ and
"public" in the include/linux/ -- to not confuse pata_platform users
by __pata_platform_* internal stuff. But okay, I'll merge them.

> These patches basically look fine to me otherwise, though it would be
> nice if the semantic-changing bits had been abstracted. So as long as the
> old irq_flags behaviour is maintained and that irq_res->flags stuff is
> ripped out, I'll add my Acked-by as well.


Much thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
