From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 12 Aug 2008 16:18:21 +0200
Message-ID: <200808121618.21876.sr@denx.de>
References: <48A05152.7020508@harris.com> <48A19788.6050502@harris.com> <20080812140457.GA9103@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:49531 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYHLOSk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 10:18:40 -0400
In-Reply-To: <20080812140457.GA9103@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
Cc: "Steven A. Falco" <sfalco@harris.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks, Sam" <SSparks@aclaratech.com>

On Tuesday 12 August 2008, Anton Vorontsov wrote:
> > > Another possibility is that you got the wrong interrupt number
> > > in the device-tree...
> > >
> > > Ben.
> >
> > The platform is the AMCC Sequoia board.  We've built a little adapter to
> > connect a compact flash card to the processor bus.  I believe the
> > interrupt selection in the device tree is correct, and I've checked over
> > the u-boot settings for the IRQ line (active high, level sensitive).
>
> IDE IRQs are active-low.

IIRC, the CompactFlash interrupt is active-high.

Best regards,
Stefan
