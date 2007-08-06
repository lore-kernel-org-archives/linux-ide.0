From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 6 Aug 2007 21:25:25 +0200
Message-ID: <200708062125.26387.rjw@sisk.pl>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com> <46B75459.9020204@gmail.com> <1186424492.4355.1.camel@nx6310>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1186424492.4355.1.camel@nx6310>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Michael Sedkowski <sedmich@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday, 6 August 2007 20:21, Michael Sedkowski wrote:
> Dnia 07-08-2007, Wt o godzinie 02:03 +0900, Tejun Heo napisa=C5=82(a)=
:
> > Rafael J. Wysocki wrote:
> > >>> Sidux is a Debian Unstable based distro with it's own set of pa=
tches
> > >>> including the shut down patch provided here:
> > >>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224
> > >> You'll probably have to ask Sidux what changes they made that co=
uld cause
> > >> the double spin down, even if halt(8) is never passed the -h fla=
g.
> > >=20
> > > Well, I've been observing the same behavior on nx6325 for some ti=
me and I
> > > use openSUSE 10.2.  I think this is kernel-related.
> >=20
> > Hmmm... If the problem only shows up on nx6325, it might be that AC=
PI is
> > pulling unnecessary stunt.  Please apply the attached patch and rep=
ort
> > when the disk spins down and up.
> >=20
> > Thanks.
> >=20
>=20
> Disk spins down on "Pre-shutdown prepare" and then goes up and down o=
n
> "Power down".

Same thing on my box.

In kernel_shutdown_prepare(SYSTEM_POWER_OFF) we call device_shutdown(),=
 so it
looks like the drive is powered off by one driver's .shutdown() routine=
=2E

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
