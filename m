From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 23:09:59 +0000
Message-ID: <bug-111151-11633-E8V9hNYaRB@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38650 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbcAWXKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jan 2016 18:10:02 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2EC8720306
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 23:10:01 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id C2290202FF
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 23:09:59 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D111151

--- Comment #9 from Andreas E <andi3@gmx.net> ---
SUCCESS !!!

Linux my-lubuntubox 4.4.0-040400-generic #201601101930 SMP Mon Jan 11 0=
0:49:33
UTC 2016 i686 athlon i686 GNU/Linux

That was it. Kernel 4.4.0 ONLY.

-=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=
=94--=E2=80=94--=E2=80=94--
All 4.2.0 to 4.3.4 =3D FAILED.
-=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=94--=E2=80=
=94--=E2=80=94--=E2=80=94--
4.4.0 =3D WORKS.

(there was nothing between 4.3.5 and 4.3.9 in
http://kernel.ubuntu.com/~kernel-ppa/mainline/ AFAICS)

This is the first time I can write a post after having successfully boo=
ted off
my _onboard_ SATA port.
So it does seem to be a kernel/module fault, and - for once - no user's
hardware fault.

Remember, ancient Linux versions worked as well as non-Linux OSes (DOS)=
=2E

Case closed (for me).
If you'd want anything else to know from me about this issue, feel free=
 to
ask.:-)

Thanks for your time, Alan.

--=20
You are receiving this mail because:
You are watching the assignee of the bug.