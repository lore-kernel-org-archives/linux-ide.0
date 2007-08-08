From: Michael Sedkowski <sedmich@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 08 Aug 2007 11:29:37 +0200
Message-ID: <1186565377.4410.2.camel@nx6310>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
	 <8db1092f0708071309h5cf6f68bo80b44d9a2fbeabeb@mail.gmail.com>
	 <200708072233.52500.rjw@sisk.pl> <200708072241.24091.rjw@sisk.pl>
	 <8db1092f0708071428lde63dc7o2b422ed81797a16e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <8db1092f0708071428lde63dc7o2b422ed81797a16e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, trenn@suse.de, Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Dnia 07-08-2007, Wt o godzinie 23:28 +0200, Maciej Rutecki napisa=C5=82=
(a):
> > > Well, on my box (nx6325) with the appended (experimental) patch a=
pplied
> > > on top of 2.6.23-rc1 with the patchset from
> >
> > s/2.6.23-rc1/2.6.23-rc2/
> >
>=20
> HP nx 6310, _old_ shutdown 2.6.23-rc2+above patches:
>=20
> 1. Before:
> rutek:/home/maciek# /usr/sbin/smartctl --all -d ata /dev/sda | grep
> Power-Off_Retract_Count
> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
> Always       -       61
>=20
> 2. Try suspend to disk, double spin down doesn't exist
>=20
> 3. Normal shutdown, double spin down exists, BUT NOTE: I have still
> old shutdown utility from Debian package.
>=20
> 4. After:
> rutek:/home/maciek# /usr/sbin/smartctl --all -d ata /dev/sda | grep
> Power-Off_Retract_Count
> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
> Always       -       61
>=20
> (it doesn't change=3D61).
>=20
> I wait for Michael, He has new shutdown from Sidux, and the same note=
book.
>=20
Same here. On suspend to disk the problem disappeared, on shut down
remained unchanged, although it is a bit faster. The emergency unload
count remain unchanged. I have the updated shut down...

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
