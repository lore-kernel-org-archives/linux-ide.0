From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
Date: Wed, 02 Dec 2009 09:34:37 +1100
Message-ID: <1259706877.2076.1036.camel@pasglop>
References: <20091201070834.6A840B7B63@ozlabs.org> <m2hbsazapo.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <m2hbsazapo.fsf@igel.home>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 21:43 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This is a libata driver for the "macio" IDE controller used on most Apple
> > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
> 
> Tried it on my iBook G4 and I got an oops during probing, in
> pata_macio_common_init+0x378/0x614.

Any chance you can send me the oops log ? (you have a digital
camera ? :-)

What model of ibook ? There's one here I could try on I think but it
might not be the same model.

Cheers,
Ben.
