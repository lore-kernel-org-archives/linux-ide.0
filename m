From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux: sata_nv: adma support
Date: Tue, 25 Aug 2015 14:58:04 +0200
Message-ID: <20150825125804.GE16715@pali>
References: <201412232051.07067@pali>
 <CADLC3L2N2TcO4FR1Bqt2n=g5G+i=dv_y_OhYHA9yXg79Bb6JPg@mail.gmail.com>
 <201508012209.27974@pali>
 <CADLC3L01LMS4yTXBMj7Xke90aP=LK-HhUH9vM80_sMgLk+sg_w@mail.gmail.com>
 <55DC4F65.70402@start.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35238 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbbHYM6H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Aug 2015 08:58:07 -0400
Content-Disposition: inline
In-Reply-To: <55DC4F65.70402@start.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@start.ca>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tuesday 25 August 2015 07:20:05 Mark Lord wrote:
> On 15-08-01 09:45 PM, Robert Hancock wrote:
> >On Sat, Aug 1, 2015 at 2:09 PM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> >>On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
> >>>On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail=
=2Ecom>
> >>>wrote:
> >>>>Hello,
> >>>>
> >>>>I have nvidia nforce4 motherboard with nvidia sata controller:
> ..
> >>>It looks like something is trying to issue a command to disable AP=
M
> >>>power management on the drive, and the command fails (likely becau=
se
> >>>it doesn't support that command).
> ..
> >>  /sbin/hdparm -B254 $DRIVE
> >>
> >>And that -B254 cause above error message in dmesg log. Output from
> >>hdparm is:
> >>
> >>  /dev/sda:
> >>   setting Advanced Power Management level to 0xfe (254)
> >>   APM_level      =3D not supported
> ..
> >>  $ sudo hdparm -I /dev/sda | grep -i power
> >>             *    Power Management feature set
>=20
> That's not the same as APM ("Advanced" Power Management).
>=20
> >However, these NVIDIA SATAs are black boxes, and rather buggy ones a=
t that,
> >so it's possible there's an unknown issue there.
>=20
> I wonder if NVIDIA simply bought out the IP from Pacific Digital
> when they went bust?  Pacific Digital invented the original "ADMA",
> and the pdc_adma.c driver in the kernel knows all about it.
> If the IP is pretty similar (identical?) then we could probably
> improve things.
>=20

Can you check if nvidia ADMA code and that Pacific Digital ADMA code is
similar or not?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
