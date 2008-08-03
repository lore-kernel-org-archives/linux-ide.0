From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re : Re : Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Sun, 3 Aug 2008 17:42:36 +0100
Message-ID: <20080803174236.6b552dbe@lxorguk.ukuu.org.uk>
References: <991193.276.qm@web26206.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52439 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756647AbYHCQ7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 12:59:52 -0400
In-Reply-To: <991193.276.qm@web26206.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbg==?= <willy_the_cat@yahoo.com>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, 3 Aug 2008 16:28:59 +0000 (GMT)
S=C3=A9bastien <willy_the_cat@yahoo.com> wrote:

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
