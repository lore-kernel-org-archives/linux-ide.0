From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Recommended SATA controller?
Date: Mon, 8 Mar 2004 01:18:52 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403080118.52688.bzolnier@elka.pw.edu.pl>
References: <opr4idafayq1sf88@mail.broadpark.no> <404BAF1D.9070103@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59861 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262351AbUCHALP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Mar 2004 19:11:15 -0500
In-Reply-To: <404BAF1D.9070103@superbug.demon.co.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>, Arve Knudsen <aknuds-1@broadpark.no>
Cc: linux-ide@vger.kernel.org


Hi.

On Monday 08 of March 2004 00:24, James Courtier-Dutton wrote:
> Arve Knudsen wrote:
> > Hi
> >
> > As it seems the Silicon Image driver won't be radically improved anytime
> > soon(?), I'm thinking of purchasing a dedicated SATA controller. Can

Which driver are you refferring to (siimage.c or sil_sata.c?).
They can't be improved because of lack of chipset errata info from SiI
(available under NDA only).

> > anyone recommend me a fairly cheap 2-port controller that's known to
> > work well with Linux (2.6-series)? Stability is imperative, I just had a
> > solid freeze and I'm afraid it might have to do with disk activity
> > (playing MP3s while compiling). Might Promise (Ultra 150) or Adaptect
> > (1210 SA) be worth considering?

Adaptec 1210SA is using Silicon Image chipset.
I haven't heard about problems with Promise chipsets.

> > Thanks
> >
> > Arve Knudsen
>
> The SATA controller on the ICH5 chips seems to work fine here. I have an
> ABIT IC7-G motherboard with SATA controller on the ICH5 chip, all built
> into the motherboard.

Unfortunately Athlon motherboards with ICH5 are very hard to find. ;-)
[ Silicon Image commonly is used on nForce2 motherboards ]

Regards,
Bartlomiej

