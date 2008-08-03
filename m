From: =?iso-8859-1?Q?S=E9bastien?= <willy_the_cat@yahoo.com>
Subject: Re : Re : Re : Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Sun, 3 Aug 2008 21:39:56 +0000 (GMT)
Message-ID: <92141.98412.qm@web26206.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26206.mail.ukl.yahoo.com ([217.12.10.243]:28557 "HELO
	web26206.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757054AbYHCVj6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 17:39:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy_the_cat@yahoo.com
Cc: tj@kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org



Re-Hi,

You are right, it's a css dvd. I use dvdbackup and work fine without an=
y I/O errors.
Ok, "we are learning every old" (French proverb).

I finaly found a dvd9 which pass throught udf filesystem correctly, but=
 it seems that there's no general way to see if there is or there is no=
t a CSS part in the media.

I apologies. Sorry for disturbing. Many thanks for all.
S=E9bastien

nota : you can keep your connect if you want heo !
p.s. : rc1-git4 works fine on my box ! :)


----- Message d'origine ----

De : Alan Cox <alan@lxorguk.ukuu.org.uk>
=C0 : S=E9bastien <willy_the_cat@yahoo.com>
Cc : Tejun Heo <tj@kernel.org>; jgarzik@pobox.com; linux-ide@vger.kerne=
l.org
Envoy=E9 le : Dimanche, 3 Ao=FBt 2008, 18h42mn 36s
Objet : Re: Re : Re : Re : dvd-9 trouble with TSSTcorp SH-S203D

On Sun, 3 Aug 2008 16:28:59 +0000 (GMT)
S=E9bastien <willy_the_cat@yahoo.com> wrote:

> Hi,
>=20
> Thanks for reply and follow the discuss.
>=20
> > Partial access to a movie file. I assume you've checked the disc in
> > question is not copy protected. We don't support decrypting copy
> > protected disks for all the obvious reasons.
>=20
>=20
> Don't know about what you talk, sorry.
> Is that you mean that I try a DVD-9 for Region 1, for instance, althr=
ough that I have a DVD Reader for Region 3 and want to deal with all th=
is ?
> No, not at all.
>=20
> DVD-9 bought in Europe as all material too.
> Suppose that DVD-CD* Cumbo is for Region 2, and all DVDs I have are l=
egaly acquired and are all for Region 2 also.
> CD* and DVD-5 works perfectly.

There are two layers of DVD authentication on devices that choose it. T=
he
first is region coding (which is irrelevant nowdays at least in europe =
as
everyone buys region free players or two drives). The second is CSS whi=
ch
controls access at the sector level without a cryptographic handshake
between the drive and the DVD playing application. Without the CSS part=
s
of the media are errored by the drive firmware.

Alan



      _________________________________________________________________=
____________=20
Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.=
yahoo.fr



      _________________________________________________________________=
____________=20
Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.=
yahoo.fr
