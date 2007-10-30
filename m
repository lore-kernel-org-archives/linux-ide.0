From: Kuckuck Kuckuck <gentoopower@yahoo.de>
Subject: AW: AW: Possible NCQ problem with Seagate ST3250620NS/nForce 4
Date: Tue, 30 Oct 2007 23:35:59 +0000 (GMT)
Message-ID: <956026.32373.qm@web26014.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26014.mail.ukl.yahoo.com ([217.12.10.88]:47297 "HELO
	web26014.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752993AbXJ3XgB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 19:36:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?Q?Jens_Pr=FCfer?= <jens.pruefer@gmx.de>
Cc: linux-ide@vger.kernel.org

Hi Jens
I just noticed, that my problem wasn't fixed by the new psu but by the =
blacklist entry in libata in my currently installed kernel 2.6.23.
I guess besides me a few other people reported the freeze with the Sams=
ung HD401LJ and therefore they added my drive to the blacklist,=20
of course now my machine doesn't lock up anymore:-)

Darn, did I fell for this one:-)



>Hi Kuckuck,

>sorry for the late reply, but I have been on the road the last few
 days.

>> Someone from the list mentioned that a bad/weak PSU may be
 responsible
>> for the trouble. It was hard for me to believe that this was the
 case,
>> since my system only uses 130W at full load and my former 350W PSU
 had
>> 170W output power.=20

>I am also using very high quality compontents. ASUS A8N-SLI Premium=20

I gut the A8N-E, great Board.
So just use the sata_nv.adma=3D0 switch right now to disable ncq and wa=
it for the drive to be blacklisted
which will eventually happen if some more people got the problem.

>mainboards in both cases (see blelow), SeaSonic PSU 450 W, passively
 cooled=20
>low-end GPU (NVidia 8500GT), no frills, nothing to bring down either
 power=20
>line (5 V or 12 V) of the PSU.=20

>However, I am running into the same problems on a different machine
 with a
>SAMSUNG SP2504C SATA drive.







       __________________________________  Ihre erste Baustelle? Wissen=
swertes f=FCr Bastler und Hobby Handwerker. www.yahoo.de/clever
