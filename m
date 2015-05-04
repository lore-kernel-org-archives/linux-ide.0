From: =?UTF-8?B?R8O8bnRlciBXYWxsZXI=?= <g.wal@web.de>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 18:37:20 +0200
Message-ID: <5547A040.4060505@web.de>
References: <5547685F.7000103@web.de> <yq16188tl8v.fsf@sermon.lab.mkp.net>	<55479C21.8020608@web.de> <yq1twvss43t.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:54660 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbEDQhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 May 2015 12:37:31 -0400
In-Reply-To: <yq1twvss43t.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Martin,
do you mind if I post the essence of your last two mails to my thread i=
n
the Ubuntu MATE forum? So the maintainers of that system can see what i=
s
going on.

Am 04.05.2015 um 18:24 schrieb Martin K. Petersen:
>>>>>> "G=C3=BCnter" =3D=3D G=C3=BCnter Waller <g.wal@web.de> writes:
>=20
> G=C3=BCnter> the second command, however, did not seem to produce any=
thing
> G=C3=BCnter> useful.  But beware: this is the old firmware, EXT0BB6Q,
>=20
> Yes, this confirms that the old firmware did not support queued
> TRIM. Whereas the new one does.
>=20
> I'll try to reach out to my contacts at Samsung again so we can get t=
his
> resolved.
>=20
> Until then, I have sent out a patch that blacklists queued TRIM for a=
ll
> Samsung 800-series drives. It appears to be generic to their
> implementation and not tied to a particular drive model.
>=20
