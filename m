From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] obsolete asm/hdreg.h [3/5]
Date: Thu, 8 Apr 2004 18:09:09 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404081809.09937.bzolnier@elka.pw.edu.pl>
References: <200404080023.04460.bzolnier@elka.pw.edu.pl> <Pine.GSO.4.58.0404081048270.9729@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25064 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261885AbUDHQAb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2004 12:00:31 -0400
In-Reply-To: <Pine.GSO.4.58.0404081048270.9729@waterleaf.sonytel.be>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Thursday 08 of April 2004 10:49, Geert Uytterhoeven wrote:
> On Thu, 8 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > [IDE] asm/ide.h: ide_ioreg_t cleanup
> >
> > ide_ioreg_t is deprecated and hasn't been used by IDE driver for some
> > time. Use unsigned long directly on alpha, arm26, arm, mips, parisc,
> > ppc64 and sh.
> >
> > asm-ia64/ide.h (ide_ioreg_t is unsigned short) and asm-m68knommu/ide.h
> > (broken - ide_ioreg_t is not defined) are the only users of ide_ioreg_t
> > left.
>
> Why do you consider asm-m68knommu/ide.h broken?
>
> It just includes <asm-m68k/hdreg.h>, which is definitely not broken since
> it's happily (albeit very slowly) running apt-get upgrade right now ;-)

Well...

In kernel 2.5.70 ide_ioreg_t typedef was removed from
<asm-m68k/hdreg.h> and it is used all over <asm-m68knommu/ide.h>.

I see that this is fixed in linux-m68k-cvs but...

<asm-m68knommu/ide.h> hasn't been updated since kernel 2.5.46
and still depends on inlines which were removed from IDE code:
- ide_request_irq() (special case for COLDFIRE)
- ide_{request, release}_region(),
  which are empty because M68K use memory IO
- ide_fix_driveid() (special case for COLDFIRE),
  conflicts with generic version in drivers/ide/ide-iops.c
- maybe more

This issues are not fixed in linux-m68k-cvs tree.
[ Is there a separate m68knommu tree? ]

I hope you now don't regret asking this question... ;-)

Cheers,
Bartlomiej

