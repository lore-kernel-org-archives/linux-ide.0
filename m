From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Mon, 11 Aug 2008 17:26:21 +0100
Message-ID: <20080811172621.147b6277@lxorguk.ukuu.org.uk>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<20080811163648.GI26082@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080811163648.GI26082@trinity.fluff.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 11 Aug 2008 17:36:48 +0100
Ben Dooks <ben-linux@fluff.org> wrote:

> 
> On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
> > When no irq specified, pata_of_platform fills irq_res with -1,
> > which is wrong to do for two reasons:
> > 
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> 
> interesting, IRQ 0 is actually valid on some ARM systems.

Not as far as Linux is concerned. It's expected that any IRQ that happens
to be "physical IRQ 0" whatever that means is remapped by the arch code
unless not visible outside the arch.
