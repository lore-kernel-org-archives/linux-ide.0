From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 12 Aug 2008 08:02:01 +1000
Message-ID: <1218492121.8041.14.camel@pasglop>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<20080811163648.GI26082@trinity.fluff.org>
Reply-To: benh@kernel.crashing.org
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

On Mon, 2008-08-11 at 17:36 +0100, Ben Dooks wrote:
> On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
> > When no irq specified, pata_of_platform fills irq_res with -1,
> > which is wrong to do for two reasons:
> > 
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;

> interesting, IRQ 0 is actually valid on some ARM systems.

It never is on powerpc (anymore). Linus several times said he believed
that was the right thing to do, so when I make the whole IRQ handling
using virtual IRQ numbers on ppc, I made 0 reserved (and 1..15 only ever
assigned to a 8259 if there's one).

ARM, with their collections of cascaded fancy PICs all over the place
should probably look into using a similar remapping scheme :-)
 
Ben.
