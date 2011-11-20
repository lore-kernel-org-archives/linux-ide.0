From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Mysterious MWDMA timings (Was: PATCH: Add CFA modes)
Date: Sun, 20 Nov 2011 09:03:44 +0100
Message-ID: <20111120080343.GD8628@suse.cz>
References: <1155232332.24077.7.camel@localhost.localdomain>
 <4EC7DB92.2020801@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jablonecka.jablonka.cz ([91.219.244.36]:39357 "EHLO
	jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab1KTIgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Nov 2011 03:36:07 -0500
Content-Disposition: inline
In-Reply-To: <4EC7DB92.2020801@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sat, Nov 19, 2011 at 08:38:42PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 10-08-2006 21:52, Alan Cox wrote:
> 
> >>From nobody Mon Sep 17 00:00:00 2001
> >From: root<root@hraefn.swansea.linux.org.uk>
> >Date: Thu Aug 10 18:06:38 2006 +0100
> >Subject: [PATCH] Add compact flash support
> 
> >The CFA world has some additional rules and drive modes we need to support for
> >newer expansion cards and on embedded boxes
> 
>    Sorry, this is very old patch, but the issue I'm going to touch
> is even much older...
> 
> >@@ -1913,6 +1945,8 @@ static const struct ata_timing ata_timin
> >  	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
> >  	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
> >
> >+	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
> >+	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
> 
>    Alan, I keep wondering where you got these 25 ns setup timings
> and where such numbers for MWDMA modes 0-2 came from (that should
> rahter be a question for Vojtech Pavlik, the author of
> drivers/ide/ide-timigs.c from which this code was apparently copied;
> I'm including him in the CC in hopes he could remember why these
> numbers occured, though it's about 10 years since that code was
> written) -- they're not in any spec. Actually, according to the
> comments to 'struct ata_timings', its 'setup' field corresponds to
> address valid to DIOR-/DIOW- setup timing (t1) which only makes
> sense for the PIO modes, so why it's not zero for MWDMA modes is
> beyond me also...

Oh, that's a long time ago indeed. I got these from the ATA spec, a
rather ancient one, too, plus the programming interface datasheets for
the AMD, VIA, Intel and SiS chipsets.

I don't remember why the setup timing is specified with MWDMA, my
assumption, though, is that this is because the timing registers were
programmed once for a drive and then kept regardless what kind of
command was sent there.

And there was a chance that commands resulting in PIO transfers
(identify, perhaps?) would be issued, and for these the setup register
needed to be programmed to a sensible value.

Or, possibly, these old chipsets used the same setup register for the
DIOR-/DIOW- timing in MWDMA mode. 

I'm afraid that with the scarce documentation back then, the ultimate
decision was made on what worked and what resulted in timeouts.

>    What I'd like to do is use this field for MWDMA as the CS(1:0)
> valid to DIOR-/DIOW- timing (tM) which seems to correspond to t1
> quite closely (and the numbers for tM are slightly less than those
> used on MWDMA modes now) -- the controller I'm writing the driver
> for now has tM timing programmable...
> Or should I just a new timing to 'struct ata_timing'? Or should I
> just keep the tM timing table private to the driver as it's the only
> user of this timing? Opinions?

Vojtech

-- 
Vojtech Pavlik
Director SuSE Labs
