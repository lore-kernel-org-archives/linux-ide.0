From: Paul Rolland (=?UTF-8?B?44Od44O844Or44O744Ot44Op44Oz?=)
	<rol@witbe.net>
Subject: Re: regarding frequent head unload problem
Date: Mon, 29 Sep 2008 20:41:46 +0200
Message-ID: <20080929204146.19033711@tux.DEF.witbe.net>
References: <48E08B99.1070508@kernel.org>
	<20080929110017.341a5255@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.witbe.net ([81.88.96.48]:49239 "EHLO smtp.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbYI2Smz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 14:42:55 -0400
In-Reply-To: <20080929110017.341a5255@tux.DEF.witbe.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Paul Rolland (=?UTF-8?B?44Od44O844Or44O744Ot44Op44Oz?=)" <rol@witbe.net>, "Ivan N. Zlatev" <contact@i-nz.net>, Robert Krawitz <rlk@alum.mit.edu>, Omar A <aliencoder@gmail.com>, Pascal Vandeputte <pascal@asmodeus.be>, Carlos Bessa <carlos.bessa@gmail.com>, Andy Vaselaar <andrew.vaselaar@trinity.edu>, webmaster@dragontower.de, Christian Wolf <wolfchri@gmail.com>, "A. Klitzing" <aklitzing@online.de>, Stefan Henriet <aladin7501-01@yahoo.de>, IDE/ATA development list <linux-ide@vger.kernel.org>rol@witbe.net

Hello,

On Mon, 29 Sep 2008 11:00:17 +0200
Paul Rolland (=E3=83=9D=E3=83=BC=E3=83=AB=E3=83=BB=E3=83=AD=E3=83=A9=E3=
=83=B3)  <rol@witbe.net> wrote:

> Hello,
>=20
> On Mon, 29 Sep 2008 17:02:33 +0900
> Tejun Heo <tj@kernel.org> wrote:
>=20
> > Hello,
> >=20
> > I'm writing to everyone who reported to me or linux-ide about frequ=
ent
> > head unload problem and the report is not yet committed to
> > storage-fixup.conf.

>=20
> I also have the following :
> [root@tux ~]# while : ; do smartctl --all /dev/sda | grep ^193; sleep=
 60;
> done 193 Load_Cycle_Count 0x0012 075 075 000  Old_age Always  - 25758=
4=20
> 193 Load_Cycle_Count 0x0012 075 075 000  Old_age Always  - 257590=20
> 193 Load_Cycle_Count 0x0012 075 075 000  Old_age Always  - 257593
>=20

Please note that hdparm -B255 /dev/sda also fixes the issue... Now adde=
d
to rc.local ;)

Regards,
Paul

--=20
Paul Rolland                                E-Mail : rol(at)witbe.net
CTO - Witbe.net SA                          Tel. +33 (0)1 47 67 77 77
Les Collines de l'Arche                     Fax. +33 (0)1 47 67 77 99
=46-92057 Paris La Defense                    RIPE : PR12-RIPE

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navig=
ateur=20
"Some people dream of success... while others wake up and work hard at =
it"=20

Alcoholics Anonymous is when you get to drink under someone else's name=
=2E
