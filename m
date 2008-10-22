From: Valerio Passini <valerio.passini@unicam.it>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Wed, 22 Oct 2008 15:30:49 +0200
Message-ID: <200810221530.50157.valerio.passini@unicam.it>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <20081022155025S.fujita.tomonori@lab.ntt.co.jp> <9ea470500810220427w30485f0fs5017c2da08fd1796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.unicam.it ([193.204.8.1]:38470 "HELO unicam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752504AbYJVOa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 10:30:57 -0400
In-Reply-To: <9ea470500810220427w30485f0fs5017c2da08fd1796@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Alle mercoled=EC 22 ottobre 2008, Boris Petkov ha scritto:

Hi all, first I've just subscribed to ide-linux to post the results I h=
ave=20
obtained from previous patches, as asked by Fujita (sorry I have=20
misunderstood your message and replied to bugzilla).

> more about the problem after we dump the relevant data. Valerio, can =
you
> try the following patch and send back the output after retrying to bu=
rn on
> your machine?
I will test this new patch as soon as possible. Should I try it on 2.6.=
27 or=20
on the newest  stable release subversion?

Another question. Should I enable some more level of debugging to give =
you=20
more information? Just in case tell me how-to.

> Honestly, I don't know. It might just as well be only a problem with =
this
> single drive since I'm not familiar with other similar regressions.
My drive is a fairly popular model produced by Samsung/Toshiba and inst=
alled=20
inside many laptops (Acer, Dell and many others): it's named TSST corp =
CDDVDW=20
TS-L632H. Probably if the problem is not only mine, you will get other =
bug=20
reports soon, but I admit I have upgraded the firmware 5 months ago so =
maybe=20
my bug is peculiar to me.
Is it possible that a strange combination of firmware in the device and=
 ide-cd=20
linux module can lead to my problem?  (Just guessing)

I want to recall that I had not any problem until the last  stable rele=
ase and=20
my DVD drive works well with ata-piix instead of piix as controller in=20
2.6.27.

Here are the previous test results I have posted on bugzilla which is n=
ot the=20
proper place...

1. I have applied the Boris' patch to 2.6.27 past Sunday and I=20
have used that patched kernel for burning CD without any problems (inde=
ed is=20
my default kernel now).

2. Applying Tomonori's patch doesn't reach the same result. The patched=
 kernel=20
with his fixes is behaving from an user point of view as the plain 2.6.=
27=20
kernel.
Burning a CD is problematic because the main processor is intensively w=
orking=20
and the device buffer reaches 0% quite often, obliging k3b to slowdown =
the=20
burning speed.

