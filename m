From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [t13] RE: comment on T10 ATA-passthru
Date: Fri, 29 Oct 2004 16:50:33 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041029205033.GA32007@havoc.gtf.org>
References: <A9B8FF43A76C0D42A80DDD73CF99BEC80548967B@azsmsx407> <20041029142539.A29944@florence.linkmargin.com> <20041029194311.GA27218@havoc.gtf.org> <20041029153953.B29944@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:60305 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263524AbUJ2Uwq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Oct 2004 16:52:46 -0400
Content-Disposition: inline
In-Reply-To: <20041029153953.B29944@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linville@redhat.com, linux-ide@vger.kernel.org

On Fri, Oct 29, 2004 at 03:39:53PM -0500, Andy Warner wrote:
> Jeff Garzik wrote:
> > BTW, can you send me a patch that filters out
> > SET FEATURES - XFER MODE ?
> > 
> > That should not be executed without driver intervention /
> > synchronization.
> 
> There are _so_ many commands that can be terminal for
> continued communication with the drive, do we really want to
> start filtering commands ?

It is absolutely required that we snoop commands.

Two main reasons:

* to update device information (dev->id, etc.) that we have cached
  in local data structures

* to trigger hardware reprogramming, necessary to ensure continued
functional operation.

Examples:  a) Promise hardware snoops SET FEATURES - XFER MODE
commands, and reprograms a hardware register based on the taskfile's
contents.  If DMA is active on _other_ ports when this occurs, then data
corruption occurs.  One must make sure that the other ports are paused
before issuing this command.

b) PATA hardware requires programming controller-specific registers to
match the PIO/DMA mode set in the SET FEATURES - XFER MODE taskfile.

c) other random controller-specific oddities for other commands



> Would it be important/useful to make the pass-thru
> stuff a config option ?

When stable, passthru will be unconditionally enabled.

I'm mainly waiting on T10 to standardize the CDB opcode(s).


> However, in working through recovery scenarios for
> aborted PIO/DMA transfers, it looks like I need to
> reset the port, which will interact with hotplug
> because I lose drive phy status when I issue reset
> via the SATA control regs. Hotplug looks like it
> is going to be non-trivial, even though it's not
> horribly complicated. My plan is to continue down
> the route of seperating HBA init and drive probe.
> For adapters that support hotplug (shouldn't all
> SATA ?), I plan to just let the hotplug code take
> care of drive probing. For HBAs that are brain
> dead somehow (perhaps a PATA port ?), I plan to
> provide some easy hook that the hba driver can
> call during xxx_add_one()[or whatever.] Issues
> already identified include flagging a drive that's
> absent, and failing any subsequent requests, so
> that we don't hang trying to sync a disk that's
> not there any more.

Hotplug is definitely non-trivial :)  These are indeed some of the
issues in play.


> Post-hotplug, I'm going to be looking at NCQ, care
> to share any high-level design decisions that you
> (or others) have already taken in that area ?

Most of the code is already written to assume that queueing is
active.  Turning on NCQ in libata is trivial.  Handling errors and
synchronization is less trivial :)

For the controllers that transparently support it, we want to enable
TCQ as well.

	Jeff



