From: Martin Rogge <marogge@onlinehome.de>
Subject: Re: [PATCH] cmd64x: don't clear the other channels interrupt
Date: Thu, 15 Nov 2007 20:23:19 +0100
Message-ID: <200711152023.19360.marogge@onlinehome.de>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200711112252.58538.bzolnier@gmail.com> <200711132158.36205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:50758 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760819AbXKOTXR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 14:23:17 -0500
In-Reply-To: <200711132158.36205.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, milon@wq.cz

On Tuesday 13 November 2007 21:58:36 Bartlomiej Zolnierkiewicz wrote:
> On Sunday 11 November 2007, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 09 November 2007, Sergei Shtylyov wrote:
> > > Make sure to not clear the other IDE channel's interrupt when clearing
> > > an IDE interrupt via the MRDMODE register.
> > >
> > > Thanks to Bart for finding a coding mistake.
> >
> > Could you resend with "Signed-off-by:" and "Tested-by:" tags?
> >
> > [ A reference to the problematic commit and crediting Martin for
> >   patiently bisecting the issue would score an extra points. :) ]
>
> Well, I dealt with it myself and just added "From:" (together
> with "Tested-by:"-s and an enhanced patch description)...
>
> For the future please always run your patches through
> scripts/checkpatch.pl before posting, this prevents missing
> "Signed-off-by:" (and few other issues :).
>
> Thanks,
> Bart

Thank you all for help and resolution. And all the bisecting, with or without 
git, I didn't really mind doing since it is for the greater good. I've even 
learnt something new since my linux-m68k days. :)

cu Martin

