From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: SATA disks disabled on boot
Date: Tue, 03 Feb 2015 14:45:28 -0500
Message-ID: <54D12558.6000805@ubuntu.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com> <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com> <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com> <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com> <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt> <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com> <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com> <54C8ECA2.3020705@ubuntu.com> <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com> <54CB8CC6.5040801@ubuntu.com> <CADqA9uajygUCniypA2xqbi6HKBH6Conv=66u4BxPuuGP+v7gMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43082 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161045AbbBCTqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2015 14:46:09 -0500
Received: by mail-qa0-f46.google.com with SMTP id j7so35439747qaq.5
        for <linux-ide@vger.kernel.org>; Tue, 03 Feb 2015 11:46:09 -0800 (PST)
In-Reply-To: <CADqA9uajygUCniypA2xqbi6HKBH6Conv=66u4BxPuuGP+v7gMg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TnVubyBNYWdhbGjDo2Vz?= <nunomagalhaes@eu.ipp.pt>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/3/2015 2:32 PM, Nuno Magalh=C3=A3es wrote:
> The BIOS shows the regular Primary/Secondary IDE Master/Slave (to=20
> which only the CDROM is attached) alongside SATA. It doesn't seem
> like SATA is the option, bu rather that both IDE and SATA are seen
> as current usable interfaces (at the time the BIOS was released:
> 2010). It does have NVRAID, which is disabled (i use mdadm).

Typically there is a knob that toggles between three states: IDE,
AHCI, and RAID.  RAID really is AHCI just with a different PCI
identifier that causes windows to load their proprietary driver that
does the software raid.  If you only have an on/off switch for the
raid, then try switching it on.

> There is no mention of AHCI that i could find.
>=20
> Regardless, as long as linux sees the HDDs on boot (which it does
> even with PUIS), does the BIOS have any influence in this issue?

Only in that it is configuring the controller to behave like a legacy
IDE controller instead of a proper SATA one, and that does cause some
differences in how the kernel handles the drives.  It *shouldn't*
cause the problem you are seeing, but it does prevent the system from
issuing a hard reset to the drives, which *may* cause them to come arou=
nd.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJU0SVYAAoJENRVrw2cjl5R984H/Rr/xSVa7x8az1kq0v+bUp1D
tIU1gWBRumBMcTGgkHYiePLdr9OFRK867N23UrxG14PbbmiJymr4hi4DbaCqWUYc
MzatgvehwK4Y3Lm2Wi3uO27On1O6nior8yPr4i7d/bWWAYC7csX9y522Pbv0hJvx
gpZTHarFeU0bXhqKKm9NGvaJuFmwvZosw7dF3pVK01S8crNtYoxX/iLLown2H8PJ
OTiIfnZKQwlxwh4DM6v17QQRzesQH8nwZ3PoWysE0WVdcH7bbDRQTn+kIByk4ihD
UdtYE1OybaTpIhdzQFTEw6pDS+BVIcu3yqLqrMFzUyiZU9jwwtTpMC4/g2zY31I=3D
=3Dbxbp
-----END PGP SIGNATURE-----
