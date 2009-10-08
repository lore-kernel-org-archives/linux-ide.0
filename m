From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Thu, 08 Oct 2009 12:42:14 -0400
Message-ID: <1255020134.30440.698.camel@giskard>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>
	 <4ACB3741.2030101@gmail.com> <1254852272.1471.172.camel@giskard>
	 <4ACBA33C.7090606@rtr.ca>  <1254873978.1471.463.camel@giskard>
	 <1254879618.1471.525.camel@giskard>  <4ACC076F.7020000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932758AbZJHQnA@vger.kernel.org>
In-Reply-To: <4ACC076F.7020000@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>
List-Id: linux-ide@vger.kernel.org

El Tue, 06-10-2009 a las 23:13 -0400, Mark Lord escribi=F3:
> Dunno.  Rev.9 =3D=3D "C0" in Marvell terminology,
> and that's the latest/final rev for the 6081 chip,
> with most of the PCI-X bugs fixed or worked around.
> So not much to go on there.
>=20
> The Bus error report was real, though.
> But with 3.0gb/sec sata connections, the chip will be
> using some different internal clocks and timings,
> which could be enough to avoid triggering the PCI errors.
>=20
> I guess.  Let's hope so, anyway.

Our prayers have not been answered :-(

I tried several things:

 - Forcing all the 500GB Seagate drives to 3.0Gbps does not help

 - Replacing the 500GB drives with 1.5TB drives seems to make
   the PCI error much less frequent

 - Moving the controllers to different slots (on different busses)
   does not help

 - Happens with both 2.6.26 (from lenny) and 2.6.30 (from sid)

 - Unplugging one of the controllers appeared to lead to a stable
   configuration, but yesterday I left the machines reconstructing
   the arrays and this mornings one of them is not answering
   to pings ;-(

I want to try reducing the frequency of the PCI-X bus, but the BIOS doe=
s
not seem to provide a setting for it.  Is there another way?

--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/
