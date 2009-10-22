From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Thu, 22 Oct 2009 11:44:04 +0200
Message-ID: <200910221144.04471.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <200910212139.24675.bzolnier@gmail.com> <20091021.174155.44894825.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49161 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZJVJxV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2009 05:53:21 -0400
Received: by fxm18 with SMTP id 18so8951213fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 22 Oct 2009 02:53:25 -0700 (PDT)
In-Reply-To: <20091021.174155.44894825.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

On Thursday 22 October 2009 02:41:55 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Wed, 21 Oct 2009 21:39:24 +0200
> 
> > Seems like SSD (simply by being faster) triggers some race condition that
> > hardware has tolerated in the past and since we used to always serialize
> > operation for CMD646 before:
> 
> Yes, and technically we only did the synchronization for one
> of the two chips mpatocka is adding the serialize setting to.
> 
> > commit e01698aed04811b9a9c4f8d54b73cb182757063d           
> > Author: David S. Miller <davem@davemloft.net>             
> > Date:   Sun Jun 21 22:48:03 2009 -0700
> > 
> >     ide cmd64x: Remove serialize setting.
> > 
> > it went undetected until now..
> 
> Right, and see also:
> 
> commit 6b5cde3629701258004b94cde75dd1089b556b02
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Mon Dec 29 20:27:32 2008 +0100
> 
>     cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
> 
> Which is how we got there.

We are through this the second time and you're still not willing
neither to listen nor to read the code.  We always did serialization
for CMD646, we just used  hwif->chipset == ide_cmd646 (without using
IDE_HFLAG_SERIALIZE flag):

1061                 if (h && h->hwgroup) {  /* scan only initialized ports */
1062                         if (hwif->irq == h->irq) {
1063                                 hwif->sharing_irq = h->sharing_irq = 1;
1064                                 if (hwif->chipset != ide_pci ||
1065                                     h->chipset != ide_pci) {
1066                                         save_match(hwif, h, &match);
1067                                 }
1068                         }

so the code was using the same serialized hwgroup for CMD646 (which always
uses shared PCI IRQ AFAIK) because of hwif->chipset == ide_cmd646.  My patch
only made this explicit in preparation for other changes (one of such other
changes resulted later in uncovering unexpected IRQ problem on Ultra 5).

> The most conservative thing to do is to set the flag as
> is done by mpatocka's patch but I'd like Frans to regression
> test that on his ultra5.

Agreed, though I wonder whether we should also provide module parameter to
disable serializing on those chipsets for people not using SSDs...
