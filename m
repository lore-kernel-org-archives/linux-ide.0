From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13308] ide-tape boot kernel panic
Date: Fri, 15 May 2009 10:05:00 GMT
Message-ID: <200905151005.n4FA50Xw028189@demeter.kernel.org>
References: <bug-13308-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56612 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbZEOKE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 06:04:59 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4FA50xK028190
	for <linux-ide@vger.kernel.org>; Fri, 15 May 2009 10:05:00 GMT
In-Reply-To: <bug-13308-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D13308





--- Comment #7 from Ortwin Gl=C3=BCck <odi@odi.ch>  2009-05-15 10:05:00=
 ---
I did a

tar cf /dev/ht0 .
mt -f /dev/ht0 rewind
tar tf /dev/ht0
mt -f /dev/ht0 eject

and experienced no problems.

Cheers,

Ortwin

--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are watching the assignee of the bug.