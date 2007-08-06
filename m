From: Michael Sedkowski <sedmich@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 06 Aug 2007 20:21:32 +0200
Message-ID: <1186424492.4355.1.camel@nx6310>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>
	 <1186411815.4355.7.camel@nx6310>
	 <20070806150159.GC31615@khazad-dum.debian.net>
	 <200708061732.03425.rjw@sisk.pl>  <46B75459.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46B75459.9020204@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Dnia 07-08-2007, Wt o godzinie 02:03 +0900, Tejun Heo napisa=C5=82(a):
> Rafael J. Wysocki wrote:
> >>> Sidux is a Debian Unstable based distro with it's own set of patc=
hes
> >>> including the shut down patch provided here:
> >>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224
> >> You'll probably have to ask Sidux what changes they made that coul=
d cause
> >> the double spin down, even if halt(8) is never passed the -h flag.
> >=20
> > Well, I've been observing the same behavior on nx6325 for some time=
 and I
> > use openSUSE 10.2.  I think this is kernel-related.
>=20
> Hmmm... If the problem only shows up on nx6325, it might be that ACPI=
 is
> pulling unnecessary stunt.  Please apply the attached patch and repor=
t
> when the disk spins down and up.
>=20
> Thanks.
>=20

Disk spins down on "Pre-shutdown prepare" and then goes up and down on
"Power down".

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
