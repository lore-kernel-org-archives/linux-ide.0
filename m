From: =?iso-8859-1?Q?S=E9bastien?= <willy_the_cat@yahoo.com>
Subject: Re : Re : Re : Re : Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Sun, 3 Aug 2008 23:08:36 +0000 (GMT)
Message-ID: <781438.27763.qm@web26204.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26204.mail.ukl.yahoo.com ([217.12.10.241]:23093 "HELO
	web26204.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754486AbYHCXIi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 19:08:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


> > nota : you can keep your connect if you want heo !

> No need to keep it around.  Please kill it.

ok, done.

> how come SCSI didn't report the sense data?  Anyways, you probably wa=
nt to look for libdvdcss.

SCSI ? Hmm, it's probably like Mister A. Cox said : the handshake proce=
ss.
But, we are not supposed to only read movies ... and the kernel is not =
here to see what it deal with, as I understand.

There is even a version 2 of libdvdcss now.
Yes, will have a look at when I will have got the time.

Again, I apology and sorry for the disturbs.
Thanks for answering.

See ya.
Best regards.
S=E9bastien



----- Message d'origine ----
De : Tejun Heo <tj@kernel.org>
=C0 : S=E9bastien <willy_the_cat@yahoo.com>
Cc : jgarzik@pobox.com; linux-ide@vger.kernel.org
Envoy=E9 le : Lundi, 4 Ao=FBt 2008, 0h41mn 50s
Objet : Re: Re : Re : Re : Re : dvd-9 trouble with TSSTcorp SH-S203D

S=E9bastien wrote:
> You are right, it's a css dvd. I use dvdbackup and work fine without =
any I/O errors.
> Ok, "we are learning every old" (French proverb).
>=20
> I finaly found a dvd9 which pass throught udf filesystem correctly, b=
ut it seems that there's no general way to see if there is or there is =
not a CSS part in the media.
>=20
> I apologies. Sorry for disturbing. Many thanks for all.
> S=E9bastien
>=20
> nota : you can keep your connect if you want heo !

No need to keep it around.  Please kill it.

Ah.. so it was the copy protection thing.  The firmware failed the
command and reported it via sense data.  Hmmm... how come SCSI didn't
report the sense data?  Anyways, you probably want to look for libdvdcs=
s.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      _________________________________________________________________=
____________=20
Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.=
yahoo.fr
