From: Tejun Heo <tj@kernel.org>
Subject: Re: Re : Re : Re : Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Mon, 04 Aug 2008 07:41:50 +0900
Message-ID: <4896342E.1000007@kernel.org>
References: <92141.98412.qm@web26206.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33640 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757363AbYHCWm2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 18:42:28 -0400
In-Reply-To: <92141.98412.qm@web26206.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien?= <willy_the_cat@yahoo.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

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
