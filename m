From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata disk failure?
Date: Tue, 15 Feb 2005 11:50:33 -0500
Message-ID: <42122859.9060609@pobox.com>
References: <420D5FAE.7040109@linux.it> <20050212155420.GA13468@harddisk-recovery.com> <170b0d7e63345e9b7dba9341a87a8a01@club-internet.fr> <20050213150102.GB13468@harddisk-recovery.com> <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63927 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261790AbVBOQux (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Feb 2005 11:50:53 -0500
In-Reply-To: <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Guillaume_Laur=E8s?= <guillaume.laures@club-internet.fr>
Cc: linux-ide@vger.kernel.org, Erik Mouw <erik@harddisk-recovery.com>, debian-amd64@lists.debian.org

Guillaume Laur=E8s wrote:
> Hello,
>=20
> Here is a small report in attachement, done with 2.6.11-rc4.
>=20
>=20
> ---------------------------------------------------------------------=
---
>=20
>  * Hardware is nforce3 250GB, booting debian pure64 on pata (Maxtor 3=
0Gb 6E030L0) drive. The goal is to mount data found on a sata disk (sea=
gate 200Gb ST3200822AS). The pata drive holds / and lvm partition with =
/usr, /var /tmp and /home.
> The ultimate goal is to switch all this to the sata drive, which alre=
ady holds a (barely used) swap partition.
>=20
>  * Soon after boot the console displays:
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> ...
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> nv_sata: Primary device removed
> nv_sata: Primary device added
> nv_sata: Primary device added
> and the sata disk seems to spin down at the same time.
> This is currently on 2.6.11-rc4, although I got the same behaviour wi=
th 2.6.10 and 2.6.11-rc3. Removing power from the drive and pluging it =
again seems to make te drive work some time , until it spins down again=
=2E..

Seems like the hotplug code is triggering.  That signals to me there is=
=20
some connection problem.  Maybe you have a bad cable, or maybe the cabl=
e=20
is just seated improperly in one of the two SATA plugs.

It's also possible your motherboard or drive SATA plug is faulty, but I=
=20
would replace the cable first.

	Jeff



