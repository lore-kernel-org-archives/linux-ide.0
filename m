From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Sun, 2 Dec 2007 09:45:39 -0600
Message-ID: <20071202154539.GA12415@lixom.net>
References: <20071127153708.GA12490@localhost.localdomain> <4751E639.8090308@garzik.org> <20071201235810.GA2635@zarina> <20071202035755.GA3116@lixom.net> <20071202114617.GA2923@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:51437 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbXLBPl5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 10:41:57 -0500
Content-Disposition: inline
In-Reply-To: <20071202114617.GA2923@zarina>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbou@mail.ru>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org

On Sun, Dec 02, 2007 at 02:46:17PM +0300, Anton Vorontsov wrote:
> On Sat, Dec 01, 2007 at 09:57:55PM -0600, Olof Johansson wrote:
> > On Sun, Dec 02, 2007 at 02:58:10AM +0300, Anton Vorontsov wrote:
> > > On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> > > while (1) {
> > > 	send_patches();
> > > 
> > > 	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
> > > 		break;
> > > 
> > > 	sleep(wait_for_comments_timeout); <-- currently here.
> > 
> > I still haven't seen you address the compatible comments (that
> > pata-platform is suboptimal). Or did I miss some respin of the patches?
> 
> I didn't resend these patches yet. You started the thread, but you hid
> away from the discussion (you had been Cc'ed to every mail).
> 
> 1. Arnd suggested {p,s}ata-pio-{1,2,3,..} or ata-{1,2,3,..} compatible
>    scheme;
> 2. Sergei verbosely explained that that there is no reason to
>    complicate compatible property. He suggested ata-generic, or
>    ata-simple;
> 
> Mainly I was awaiting for your further comments. By now I tend to
> follow Sergei's comments and rename compatible stuff to ata-generic.
> Are you fine with it?

Ah, sorry about that. The discussion got a bit noisy so I tuned it out.

Yes, I agree with Sergei: I don't think the pio/ata mode belongs there,
"ata-generic" (or "generic-ata") sounds good to me. If firmwares want to
specify pata/sata stuff as more specific compatible fields, then they are
free to, but the driver shouldn't depend on it as long as "ata-generic"
is in the list.

ATA/PIO modes could be communicated with separate properties as well,
but I don't see a need for it right now. Tuning PIO modes normally
involves changing bus parameters/cycle times, etc, and that' hardly
generic enough to be handled by this driver in the first place.

I will need to add a compatible field to it myself (our firmware uses
"electra-ide") + some minor changes, but I will do that on top of this
patch once it goes in since it involves removing the old code from
arch/powerpc/platforms/pasemi.


-Olof
