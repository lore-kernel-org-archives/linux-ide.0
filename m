From: "Moritz Rigler" <moritz1234567@gmx.de>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use
 HORKAGE_NOSETXFER
Date: Wed, 07 Jan 2009 15:18:44 +0100
Message-ID: <20090107141844.232020@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52792 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753429AbZAGOSq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2009 09:18:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>There are two more reports linked from the thread.

>  http://ubuntuforums.org/showthread.php?t=3D986871
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/299865

There are also
https://bugs.launchpad.net/ubuntu/+bug/305724
http://ubuntuforums.org/showthread.php?t=3D1031170
http://forum.ubuntu-it.org/index.php?topic=3D230995.msg1741414
The problem appears at least on two models (Sony Vaio FW and Sony Vaio =
VGN-NS11S). So I really don't agree with your "one report, from one use=
r, with one configuration, on one controller, using one firmware set" s=
tatement, Alan.

I think that the particular laptop model I have (Sony Vaio VGN-NS11S) h=
as sold in large numbers only recently. So if you decide to do nothing =
there will likely be more reports soon. If you wait for that to happen =
a good share of the users encountering the problem will (unjustly) blam=
e it on Linux and just turn back to using preinstalled Vista (where the=
 drive works). I've already thought myself that it was perhaps unwise t=
o run Linux on a newly bought computer (where issues like this have not=
 been fixed yet).

>That said, Moritz, can you please post the output of "hdparm -I" with
>and without the quirk applied? =20
unpatched:
http://article.gmane.org/gmane.linux.ide/36819
patched:
http://article.gmane.org/gmane.linux.ide/36840

>And can you please use a preoper mail
>address?
Hope you like this one better.

Regards,
Moritz


--=20
Sensationsangebot verl=E4ngert: GMX FreeDSL - Telefonanschluss + DSL=20
f=FCr nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=3DOM.AD.PD003K1308T45=
69a
