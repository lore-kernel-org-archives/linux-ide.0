From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pata_amd: add support for CS5535 controllers
Date: Fri, 3 Jul 2009 15:48:49 +0100
Message-ID: <20090703154849.23b62fe3@lxorguk.ukuu.org.uk>
References: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
	<1246630963-5831-2-git-send-email-otavio@ossystems.com.br>
	<20090703153110.3fa5dfbd@lxorguk.ukuu.org.uk>
	<be7a9f3d0907030733w460e63b1o5c48206ebb7e574e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51930 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757315AbZGCOrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 10:47:16 -0400
In-Reply-To: <be7a9f3d0907030733w460e63b1o5c48206ebb7e574e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: linux-ide@vger.kernel.org

On Fri, 3 Jul 2009 11:33:59 -0300
Otavio Salvador <otavio@ossystems.com.br> wrote:

> On Fri, Jul 3, 2009 at 11:31 AM, Alan Cox<alan@lxorguk.ukuu.org.uk> w=
rote:
> > On Fri, =A03 Jul 2009 11:22:43 -0300
> > Otavio Salvador <otavio@ossystems.com.br> wrote:
> >
> > We already have a CS5535 driver: drivers/ata/pata_cs5535.c
> >
> > That drives the hardware via the MSR interface which means it doesn=
't
> > rely so much on what firmware and firmware related magic happens to=
 be on
> > a given system.
>=20
> Right but why not also support it at pata_amd as it is done for cs553=
6?

Are they full compatible in the AMD case - I know they are not in the N=
S
case.

> If the native ones are the suitable ones then wouldn't be better to
> drop cs5536 from pata_amd and leave just the native ones as
> alternative?

=46or cs5536 I would have preferred to do that but there are existing u=
sers
and setups that use pata_amd for this purpose.

Alan
