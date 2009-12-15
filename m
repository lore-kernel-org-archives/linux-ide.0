From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 15 Dec 2009 11:27:53 GMT
Message-ID: <200912151127.nBFBRrYT010882@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42442 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759936AbZLOL1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 06:27:54 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBFBRrIn010883
	for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 11:27:53 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D14583





--- Comment #37 from Kay Sievers <kay.sievers@vrfy.org>  2009-12-15 11:=
27:48 ---
On Tue, Dec 15, 2009 at 01:58,  <bugzilla-daemon@bugzilla.kernel.org> w=
rote:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D14583

> It's probably *lib*atasmart - it doesn't have anything to do with lib=
ata. =C2=A0Anyways,
> deviation from the command sequence used by smartmontools seems to ca=
use two
> problems till now.
>
> * HSM violations on certain firmwares.
>
> * Spinning up drives in standby mode (smartmontools uses CHK_POWER to=
 check
> power state before issuing SMART commands).
>
> If someone is gonna report this to the upstream developer, please inc=
lude both.

Pinged Lennart with a pointer to this bug. Thanks!

--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are watching the assignee of the bug.