From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/5] pata_sis: Implement MWDMA for the UDMA 133 capable
 chips
Date: Tue, 17 Nov 2009 18:21:31 +0000
Message-ID: <20091117182131.0d91fc0e@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<200911171827.29891.bzolnier@gmail.com>
	<20091117173823.217b95a7@lxorguk.ukuu.org.uk>
	<200911171857.01805.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35850 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751770AbZKQSTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 13:19:36 -0500
In-Reply-To: <200911171857.01805.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > I'm not convinced because for the majority of drivers the libata timing
> > interface handles it. SiS needs it just because it does things by
> > precomputed tables. It's a one off interface.
> 
> Controllers based on *Intel* PIIX are in the disagreement with the above

No the PIIX is quite different. You use the matching PIO timing (which is
a short lookup and shorter code than even a helper function call). You do
not use the clipping instead you set bit 3 to ensure that PIO cycles
occur at low speed but MWDMA runs at the right speed. That is usually a
win over picking a lower mode as the PIIX can do ATAPI DMA happily.

So the only thing you can "share" is what would be a 4 byte table.

> paragraph and having generic helper to do conversion (without a clipping)
> would bring us a little step closer to killing a needless code duplication
> currently present in their ->set_piomode and ->set_dmamode methods.
> 
> [ In case somebody wonders: no, 'old' drivers don't have such duplication
>   and 'whoever did it didn't port it across' cause said 'whoever'-s were not
>   into the development of the square wheels.... ]

There is no duplication in the old drivers because they don't implement
the needed check and clipping/bit setting that I can see ;)

Alan
