From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Mon, 13 Oct 2008 01:25:30 -0700 (PDT)
Message-ID: <20081013082530.4400711D10A@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52804 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755887AbYJMI0E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 04:26:04 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9D8PUkD004991
	for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 01:25:31 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D11742





------- Comment #2 from anonymous@kernel-bugs.osdl.org  2008-10-13 01:2=
5 -------
Reply-To: valerio.passini@unicam.it

Alle luned=C3=AC 13 ottobre 2008, hai scritto:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D11742
>
>
>
>
>
> ------- Comment #1 from bbpetkov@yahoo.de  2008-10-12 23:44 -------
> Can you send me your .config and dmesg pls?
>
> Thanks.

Of course I can. Here they are.
Cheers

Valerio

Here some information about the attached config files.

config-2.6.27 it's my custom config with some drivers compiled statical=
ly=20
(i.e: SATA and ext3), many unnecessary modules removed to speed up=20
compilation and other options to fit better my architecture (core duo 2=
=20
64bit).

config-2.6.27b it's more similar to the Debian configuration of stock k=
ernel=20
(2.6.26), I just made some changes to fit architecture and removed driv=
ers=20
obviously (IMO :) ) not related to my problem (bug 11742) like ALSA mod=
ules,=20
V4L modules and so on. I have just tried to check if it worked better b=
ut it=20
didn't.

dmesg.txt is related to the kernel made with the first config in attach=
ment=20
(config-2.6.27)


--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
