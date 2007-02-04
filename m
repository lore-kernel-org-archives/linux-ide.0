From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: green light for kernel 2.6.20-rc7-git1
Date: Sun, 04 Feb 2007 17:16:24 +0100
Message-ID: <20070204161624.291480@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752429AbXBDQQ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Feb 2007 11:16:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@osdl.org, bunk@stusta.de, michaelc@cs.wisc.edu, jens.axboe@oracle.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, efault@gmx.de

Hi everybody,

I can confirm that nerolinux is running excellent again with 2.6.20-rc7=
-git1.
I want to thank everyone mentioned in the address header, especially Li=
nus himself and Mike Christie who did an excellent job. Fantastic!

My proposition to avoid terrible bugs like that one in the future is:
Every material, every change, even produced by Linus himself, should pa=
ss the mm-tree before being pushed into vanilla mainline.
I believe in quality, and quality needs manpower and testing. Manpower =
and testing need time. I=C2=B4ve spent waiting 7 weeks to get this bug =
fixed.
In other words: If you keep on pushing out kernel release candidates wi=
th rat race speed nobody takes advantage of. So I=C2=B4d appreciate you=
 to reflect this criticism for a moment. My apologies for reacting that=
 late. I should have reacted immediately after publishing of 2.6.20-rc1=
 instead of after 2.6.20-rc2.

Linus Torvalds wrote on Sunday, January 28th, 23:04:49 -0800
=E2=80=9CI've never used it before, but it triggers: ...........
However, it appears to be rather hard to debug, with nerolinux being so=
me=20
closed black box. Does anybody who knows nero know if there is some way=
 to=20
get debug information out of it to see what it tried to do?
Can somebody try to bisect this?=E2=80=9C

I feel sorry about the restrictive policy of some software companies av=
oiding to publish the sourcecode of their products. They publish Debian=
 (my preferred distro) and Redhat packages and that=C2=B4s it! It must =
be horrible to debug this.
My deep respect for everybody who managed to fix this in spite of that =
hindrance policy! And the case of nerolinux is not the first one I stum=
ble over:

A very good application called mainactor (published by main concept cor=
poration) does not run on AMD CPUs with VIA onboard chipset. You are fo=
rced to use Intel ICH hardware, or, if you don=C2=B4t, you cannot cut D=
VB movie material to prepare DVD videos!
Can anybody reading this tell me whether there is an open source altern=
ative that can compete with mainactor being able to cut mpeg2 movie str=
eams? I would be very thankful for a hint!

Has anybody reading this ever tried to produce a multisession DVD or CD=
 with two different systems (f. ex. Windoze and Linux) and two differen=
t applications (f. ex. k3b on Linux and Nero on Windoze), using rewrita=
ble raw material?
That=C2=B4s a disease, as you are running into the following trouble: D=
ifferent sessions cannot be recognized by the specific =E2=80=9Cother=E2=
=80=9D system.
But if I use nero on both different platforms my practical experiences =
have ever been fine ones.

Question: What does =E2=80=9Cbisecting=E2=80=9D mean please? Is it just=
 a synonym for debugging or does it describe another technique to fix b=
ugs? In case of the latter: What is the technique behind that expressio=
n?

Best regards and a thousands of thanks

Uwe

--=20
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!=20
Ideal f=C3=BCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
