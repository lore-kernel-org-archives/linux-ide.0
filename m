From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/5] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Tue, 17 Nov 2009 20:33:29 +0100
Message-ID: <200911172033.29805.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911171857.01805.bzolnier@gmail.com> <20091117182131.0d91fc0e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33582 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbZKQTgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 14:36:38 -0500
In-Reply-To: <20091117182131.0d91fc0e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 17 November 2009 19:21:31 Alan Cox wrote:
> > > I'm not convinced because for the majority of drivers the libata timing
> > > interface handles it. SiS needs it just because it does things by
> > > precomputed tables. It's a one off interface.
> > 
> > Controllers based on *Intel* PIIX are in the disagreement with the above
> 
> No the PIIX is quite different. You use the matching PIO timing (which is
> a short lookup and shorter code than even a helper function call). You do
> not use the clipping instead you set bit 3 to ensure that PIO cycles
> occur at low speed but MWDMA runs at the right speed. That is usually a
> win over picking a lower mode as the PIIX can do ATAPI DMA happily.

Thank you for the detailed explanation, I certainly would still be
scratching my head over it if it wasn't for your great help.

> So the only thing you can "share" is what would be a 4 byte table.

You are of course right, I must have been confused by the old driver.

> > paragraph and having generic helper to do conversion (without a clipping)
> > would bring us a little step closer to killing a needless code duplication
> > currently present in their ->set_piomode and ->set_dmamode methods.
> > 
> > [ In case somebody wonders: no, 'old' drivers don't have such duplication
> >   and 'whoever did it didn't port it across' cause said 'whoever'-s were not
> >   into the development of the square wheels.... ]
> 
> There is no duplication in the old drivers because they don't implement
> the needed check and clipping/bit setting that I can see ;)

Seems like the whoever maintained the old driver didn't port across
this critical bugfix. :(

-- 
Bartlomiej Zolnierkiewicz
