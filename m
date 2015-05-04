From: =?UTF-8?B?U3ZlbiBLw7ZobGVy?= <sven.koehler@gmail.com>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 19:27:28 +0300
Message-ID: <55479DF0.9090405@gmail.com>
References: <5547685F.7000103@web.de> <yq16188tl8v.fsf@sermon.lab.mkp.net>	<mi84f3$vjo$1@ger.gmane.org> <yq1y4l4s47z.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37414 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbEDQ1a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:27:30 -0400
Received: by widdi4 with SMTP id di4so116069577wid.0
        for <linux-ide@vger.kernel.org>; Mon, 04 May 2015 09:27:29 -0700 (PDT)
In-Reply-To: <yq1y4l4s47z.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org


Am 04.05.2015 um 19:21 schrieb Martin K. Petersen:
>>>>>> "Sven" =3D=3D Sven K=C3=B6hler <sven.koehler@gmail.com> writes:
>=20
>>> # hdparm -I /dev/sdN # smartctl -l gplog,0x13 /dev/sdN
>=20
> Sven> I'm not sure the smartctl is helpful, since my machine has been
> Sven> running with discard disabled for about half a day now.
>=20
> It is helpful. It shows us that Samsung has indeed enabled queued TRI=
M
> functionality in this firmware update.

Are you saying that previous firmwares didn't claim that the drive
supports queued TRIM. But the new firmware does - even though the
feature appears to be broken?


Regards,
  Sven

