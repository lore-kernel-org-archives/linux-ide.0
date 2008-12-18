From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O support properly
Date: Fri, 19 Dec 2008 00:13:09 +0100
Message-ID: <200812190013.10156.bzolnier@gmail.com>
References: <494A5BBF.8000807@inf.tu-dresden.de> <200812182142.16533.bzolnier@gmail.com> <20081218224010.45e3ce55@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:5649 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbYLRXOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 18:14:20 -0500
In-Reply-To: <20081218224010.45e3ce55@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Mario Schwalbe <schwalbe@inf.tu-dresden.de>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Thursday 18 December 2008, Alan Cox wrote:
> > OTOH the current patch is safe even for 2.6.28 (based on years of experience
> > with the check that we had in IDE subsystem) and will fix some libata drivers
> > (pata_legacy, pata_qdi and pata_winbond) to use dword IO on >= ATA-2 devices.
> > 
> > [ In reality this a regression fix for IDE -> libata conversion as it is a
> >   huge performance improvement for the above mentioned DMA-less drivers. ]
> 
> The 32bit PIO support is already queued up and went to Jeff a while ago
> so thats all in hand - its btw a big win on some suprising chipset cases
> including Intel ICH chipsets.

It is a not exactly the same issue as the pata_{legacy,qdi,winbond} one
discussed above.  Anyway cool to see another IDE -> libata regression fixed.

> > Jeff, I would like to merge it through IDE tree since the other patch depends
> > on it but if you want to go ahead and push it to Linus earlier feel free to
> > do it (or I can include it into the next IDE fixes pull request if you like).
> 
> Its still broken. You cannot use the version check for versions below 3.

Hmm, this doesn't seem to be a problem w.r.t. to the patch we are discussing
because in such case ata_id_major_version() will just return 0 and the check
will behave in the identical way as it was before the patch.

> I remain unconvinced we should be looking at it anywhere except specific
> pure ISA cycle pass through hardware and thus it belongs as a helper for
> those drivers not as ata_has_mumble stuff as its not ATA - eide_* maybe.

Sure, we can always improve things further later.  However Mario's patch
is _definitely_ an improvement over the _current_ code.  Don't you agree?

[ There are no alternative patches to consider currently so... ]

Thanks,
Bart
