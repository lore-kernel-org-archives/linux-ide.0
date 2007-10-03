From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [patch 01/10] pata_acpi: restore driver
Date: Wed, 03 Oct 2007 17:05:54 -0400
Message-ID: <1191445554.9479.14.camel@localhost.localdomain>
References: <200710022052.l92Kqx0w021673@imap1.linux-foundation.org>
	 <4703FBC6.80104@garzik.org>  <20071003215446.2ee23248@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:43267 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752890AbXJCVF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 17:05:56 -0400
In-Reply-To: <20071003215446.2ee23248@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, htejun@gmail.com

On Wed, 2007-10-03 at 21:54 +0100, Alan Cox wrote:
> On Wed, 03 Oct 2007 16:29:58 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > akpm@linux-foundation.org wrote:
> > > From: Alan Cox <alan@redhat.com>
> > > 
> > > This patch assumes the mode filter patches were applied, if not then ping
> > > me and I'll send the trivially different patch (extra argument to
> > > mode_filter)
> > > 
> > > Don't assume the BIOS can validate modes or has any sense at all.  Instead use
> > > the BIOS timings to deduce the modes.
> > > 
> > > Signed-off-by: Alan Cox <alan@redhat.com>
> > > Cc: Tejun Heo <htejun@gmail.com>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > 
> > >  drivers/ata/Kconfig     |    9 
> > >  drivers/ata/Makefile    |    2 
> > >  drivers/ata/pata_acpi.c |  403 ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 414 insertions(+)
> > 
> > Can I get a better email subject and patch description please?
> > 
> > Just reply to this email, and I can hand-edit the patch from there.
> > 
> > "pata_acpi: restore driver" is a bad one-line summary, because nothing 
> > was lost (hence nothing to be restored).  it's simply a new driver.
> > 
> > The patch description is also wanting -- it describes work-in-progress, 
> > but should really be a summary of what the pata_acpi driver is, why we 
> > want it, and how it works.
> > 
> > Email some text, and I shall apply straightaway
> 
> 
> 	On a cable there may be
> 	eighty wires or perhaps forty
> 	and we learn about its type
> 	In the world of ACPI
> 
> 	So we call the GTM
> 	And we find the the timing rate
> 	And we look through it to see
> 	If eighty wire it must be
> 
> 	Timing lives in ACPI routines
> 	ACPI routines, ACPI routines
> 	Timing lives in ACPI routines
> 	ACPI routes ACPI routines
> 
> 	And the drivers call into see
> 	Which cable type its to be
> 	And the code begins to work
> 
> 	Timing lives in ACPI routines
> 	ACPI routines, ACPI routines
> 	Timing lives in ACPI routines
> 	ACPI routes ACPI routines
> 
> 	[Full speed ahead, Mr Hacker, full speed ahead]
> 	 Full speed over here sir!
> 	 Checking Cable, checking cable
> 	 Aye aye, 80 wire,
> 	 Heaven heaven]
> 
> 	If we use ACPI (ACPI)
> 	Every box (every box) has all we need (has all we need)
> 	Cable type (cable type) and mode timing (mode timing)
> 	In our ATA (in our ATA) subroutines (subroutines, ha ha)
> 
> 	Timing lives in ACPI routines
> 	ACPI routines, ACPI routines
> 	Timing lives in ACPI routines
> 	ACPI routes ACPI routines
> 	Timing lives in ACPI routines
> 	ACPI routines, ACPI routines
> 	Timing lives in ACPI routines
> 	ACPI routes ACPI routines

If you could do a few SCSI ones, I'd particularly appreciate one to the
tune of Lucy in the Sky with Diamonds (although it's not on the same
album, unfortunately) ...

James


