From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: SATA disks disabled on boot
Date: Fri, 30 Jan 2015 08:53:10 -0500
Message-ID: <54CB8CC6.5040801@ubuntu.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com> <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com> <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com> <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com> <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt> <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com> <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com> <54C8ECA2.3020705@ubuntu.com> <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:56538 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbbA3Nx1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2015 08:53:27 -0500
Received: by mail-qg0-f48.google.com with SMTP id z60so38134523qgd.7
        for <linux-ide@vger.kernel.org>; Fri, 30 Jan 2015 05:53:27 -0800 (PST)
In-Reply-To: <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TnVubyBNYWdhbGjDo2Vz?= <nunomagalhaes@eu.ipp.pt>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/29/2015 5:04 PM, Nuno Magalh=C3=A3es wrote:
> As far as the BIOS goes, it's consistent on the Toshibas as far as=20
> SATA information goes: Extended IDE drive: auto, Access mode: auto=20
> Cylinder: 65535, Head: 16, Landing Zone: 65534, Sector 255 for
> both.
>=20
> With the WDs, not so much. For WD1: Extended IDE drive: auto,
> Access mode: large (this one i changed from the "auto" default to
> see if it would change anything) Cylinder: 4095, Head: 240, Landing
> Zone: 65534, Sector 255

That information went obsolete in the late 1990s and doesn't really
exist any more.  I am very surprised to be hearing of it again nearly
20 years later.  I don't recall seeing even bogus information of this
type displayed in a bios made after the year 2000 or so.

> WD2 has no data, it's all 0 (since this is the drive where i
> recently enabled PUIS, is this expected? Anyway i'm going to
> disable it)

Likely, yes.  Until it is spun up most of the information in the
IDENTIFY_DEVICE page is blank, except for a bit that says this drive
has powerd up in standby, most of the information here is incomplete
until spun up, and if you want me to spin up, issue a SET_FEATURES
command ( some drives will auto spin up on attempted access, my WDs
require the explicit command ).  An older, dumber bios wouldn't
recognize this and issue the command to start the drive.

> I was expecting all drives to have the same values for these
> fields. They all do report 1000GB (except WD2) and i believe they
> all emulate 512K even though they're 4KB. It's kinda weird the
> landing zone value is greater than the cylinder but that's just me
> guessing. Isn't the landing zone the MBR?

Again, it doesn't really matter since C/H/S, LZ, and precomp all
stopped having any meaning nearly 20 years ago.

> With this information, do you think AHCI mode could help? How can i
> enable that?

Most BIOS with integrated SATA chips have an option somewhere to
toggle it between legacy IDE mode, AHCI mode, and often RAID mode.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUy4zGAAoJENRVrw2cjl5RtLgH/3yDtgK+Umyw+yVx0BEqpQ23
/ZiCRBVPc5Hd+zBvgY8KbgBiEVaaKnpM0nLaOszY9p8e86/UjPK8BUoX4JZZD2dJ
=46vuiXZyHDUARbGcN37O8kFISj2Wu7FIlvmbyBj86t49HQHW+9zesDd297GQ5Vq9f
f5wCRl2lmr4p9zh93NIikze7TtSum2JK2XsaUaIuz1qQ3V4B/qSYz/71Gcvn4PHx
/9cMVIvnymVDhfZKkA5KzAGjwsO2xPLqg/8BfI8Un6tPIu14IMBuoFXrxSkdH6dL
=46VpZM53hTp6YzWMTUGNbSvotWU4NPlT8He6z8qv1d5f7PaehmjJruxS/yBvZmS4=3D
=3Dd1fJ
-----END PGP SIGNATURE-----
