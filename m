From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Thu, 27 May 2010 09:57:14 +0100
Message-ID: <20100527085714.GK4720@trinity.fluff.org>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com> <1274948524-2970-5-git-send-email-kgene.kim@samsung.com> <AANLkTikr8txaKEE0FO4d-nA-cpQv3zIQ8TALqM539fhz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikr8txaKEE0FO4d-nA-cpQv3zIQ8TALqM539fhz@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

On Thu, May 27, 2010 at 05:43:47PM +0900, Jassi Brar wrote:
> On Thu, May 27, 2010 at 5:22 PM, Kukjin Kim <kgene.kim@samsung.com> w=
rote:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based =
on the
> > Libata subsystem and references the earlier patches sent for IDE su=
bsystem.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > =A0drivers/ata/Kconfig =A0 =A0 =A0 =A0| =A0 =A09 +
> > =A0drivers/ata/Makefile =A0 =A0 =A0 | =A0 =A01 +
> > =A0drivers/ata/pata_samsung.c | =A0591
>=20
> Fasten your seat belts before reading further....
>=20
> Rather than generic 'samsung', I would suggest the driver named
> after the SoC, that is supported first(chronologically) in mainline k=
ernel.
> All newer SoCs should be simply taken to contain the controller of th=
at SoC.
> Otherwise, the same naming problem comes back to haunt us should
> Samsung decides to use a different IP in future SoCs. What would we
> call that driver? pata_samsung_v2.c ?

I'm not so bothered, but it could be pata_samsung_cfcon or anything,
a new block could be called pata_samsung_v2 or fred for all I really
care about this.
=20
> my two sparks
> Jassi

--=20
--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
