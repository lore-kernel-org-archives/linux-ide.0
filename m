From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide: add IDE_HFLAG_NO_DSC host flag
Date: Sun, 30 Dec 2007 18:17:40 +0100
Message-ID: <200712301817.40456.bzolnier@gmail.com>
References: <200712271838.00351.bzolnier@gmail.com> <477652A3.2020900@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:8159 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbXL3Rbk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 12:31:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2175200ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Dec 2007 09:31:38 -0800 (PST)
In-Reply-To: <477652A3.2020900@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 29 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > * Add IDE_HFLAG_NO_DSC host flag for hosts that doesn't support DSC overlap.
> 
> > * Set it in aec62xx (for ATP850UF only) and hpt34x host drivers.
> 
> > * Convert ide-tape device driver to check for IDE_HFLAG_NO_DSC flag.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/include/linux/ide.h
> > ===================================================================
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -1098,6 +1098,8 @@ enum {
> >  	IDE_HFLAG_CY82C693		= (1 << 27),
> >  	/* force host out of "simplex" mode */
> >  	IDE_HFLAG_CLEAR_SIMPLEX		= (1 << 28),
> > +	/* DSC overlap is unsupported */
> > +	IDE_HFLAG_NO_DSC		= (1 << 29),
> >  };
> 
>     Too many flags -- you'll run out of sizeof(unsigned) soon. :-)

Actually I'm already one bit short for WIP patches.... :)

I can compensate for it by using the same bit for IDE_HFLAG_CS5520
and IDE_HFLAG_VDMA for now (they are set only by cs5520 host driver)
but long-term we should get rid of some flags (IDE_HFLAG_ABUSE*,
especially IDE_HFLAG_ABUSE_DMA_MODES, sound like a good candidates
for extermination) or make flags field u64 (eeew)...

Bart
