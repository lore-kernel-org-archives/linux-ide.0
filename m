From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_artop: fix UDMA5 for AEC6280[R] and UDMA6 for AEC6880[R]
Date: Fri, 10 Aug 2007 01:45:38 +0200
Message-ID: <200708100145.38739.bzolnier@gmail.com>
References: <200708092319.34828.bzolnier@gmail.com> <20070809235455.3117d5dc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:45692 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbXHIXq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 19:46:59 -0400
Received: by mu-out-0910.google.com with SMTP id i10so860265mue
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 16:46:58 -0700 (PDT)
In-Reply-To: <20070809235455.3117d5dc@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 10 August 2007, Alan Cox wrote:
> On Thu, 9 Aug 2007 23:19:34 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > Maximum supported UDMA mode for AEC6280[R] is UDMA5 (not UDMA4)
> > and for AEC6880[R] it is UDMA6 (not UDMA5):
> > 
> > * Fix the problem by adding missing struct ata_port_info to artop_init_one().
> > 
> > * Use the right naming (s/626/628/).
> > 
> > * Bump driver version.
> > 
> > Fixes IDE->libata regression, problem was never present in IDE aec62xx driver.
> 
> Have you tested this ??

-ENODEV so no and testing is welcomed.

However I went over both drivers to make sure that this change is safe
and correct.

BTW presence of the above bugs would strongly indicate that pata_artop has
never been tested (properly) with AEC6x80[R], otherwise these bugs should
have been noticed and fixed much earlier.

Thanks,
Bart
