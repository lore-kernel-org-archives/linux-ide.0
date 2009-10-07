From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 23:13:51 -0400
Message-ID: <4ACC076F.7020000@rtr.ca>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>	 <4ACB3741.2030101@gmail.com> <1254852272.1471.172.camel@giskard>	 <4ACBA33C.7090606@rtr.ca>  <1254873978.1471.463.camel@giskard> <1254879618.1471.525.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752967AbZJGDOa@vger.kernel.org>
In-Reply-To: <1254879618.1471.525.camel@giskard>
Sender: linux-kernel-owner@vger.kernel.org
To: Bernie Innocenti <bernie@codewiz.org>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>
List-Id: linux-ide@vger.kernel.org

Bernie Innocenti wrote:
> El Tue, 06-10-2009 a las 20:06 -0400, Bernie Innocenti escribi=C3=B3:
>>> The early revs of these chips did have a number of errata specific =
to PCI-X.
>> I checked the revision (09) against the sata_mv source and I couldn'=
t
>> spot anything relevant to us.
>=20
> NEWSFLASH: today we replaced the 4x500GB Seagate drives with 4x1.5TB
> drives and reconstruction of the array has been running for 2h withou=
t a
> glitch.
>=20
> One interesting difference is that the 500GB drives were being
> configured in 1.5Gbps SATA mode.  Another notable difference is the
> sequential read speed: ~70MB/s vs ~130MB/s with the 1.5TB model.
>=20
> Could the PCI bus errors be a red herring?
=2E.

Dunno.  Rev.9 =3D=3D "C0" in Marvell terminology,
and that's the latest/final rev for the 6081 chip,
with most of the PCI-X bugs fixed or worked around.
So not much to go on there.

The Bus error report was real, though.
But with 3.0gb/sec sata connections, the chip will be
using some different internal clocks and timings,
which could be enough to avoid triggering the PCI errors.

I guess.  Let's hope so, anyway.

Cheers
