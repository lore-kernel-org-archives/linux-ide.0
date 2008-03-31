From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Mon, 31 Mar 2008 08:04:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0803310803350.6871@anakin>
References: <200803301714.04527.bzolnier@gmail.com> <Pine.LNX.4.64.0803302012560.16372@anakin>
 <200803302134.42569.bzolnier@gmail.com> <Pine.LNX.4.64.0803310750230.6871@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yorgi.telenet-ops.be ([195.130.133.69]:36674 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYCaGEu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 02:04:50 -0400
Received: from monty.telenet-ops.be (monty.telenet-ops.be [195.130.132.56])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id 592A9588148
	for <linux-ide@vger.kernel.org>; Mon, 31 Mar 2008 08:04:49 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0803310750230.6871@anakin>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

On Mon, 31 Mar 2008, Geert Uytterhoeven wrote:
> On Sun, 30 Mar 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 30 March 2008, Geert Uytterhoeven wrote:
> > > On Sun, 30 Mar 2008, Bartlomiej Zolnierkiewicz wrote:
> > > > * Add ->atapi_{in,out}put_bytes and ->ata_{in,out}put_data methods to
> > > >   falconide and q40ide host drivers (->ata_* methods are implemented on
> > > >   top of ->atapi_* methods so they also do byte-swapping now).
> > > > 
> > > > * Cleanup atapi_{in,out}put_bytes().
> > > 
> > > Thanks!
> > > 
> > > One remaining issue (for which the fix has never been submitted upstream so
> > > far) with Atari and Q40 is that due to the byteswapped interface, the driveid
> > > is also byteswapped, so it has to be unswapped again in ide_fix_driveid().
> > 
> > My patch causes unswapping for _all_ data coming from the device so I wonder
> > whether the ide_fix_driveid() fix is still needed?
> 
> I'll give it a try on Aranym...

Oops, just applying this series of 5 patches is not sufficient, I get
lots of rejects...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
