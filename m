From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Sat, 24 Jan 2009 06:19:37 -0800 (PST)
Message-ID: <20090124141937.3205910800F@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58453 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753456AbZAXOTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jan 2009 09:19:40 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0OEJbtQ030365
	for <linux-ide@vger.kernel.org>; Sat, 24 Jan 2009 06:19:38 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D12320


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
         AssignedTo|io_ide@kernel-bugs.osdl.org |bbpetkov@yahoo.de
             Status|NEW                         |ASSIGNED




------- Comment #23 from bbpetkov@yahoo.de  2009-01-24 06:19 -------
Hi,

here's a fix, finally. It is against 29-rc2 + current (24.01) pata-tree=
=2E

@M=C3=A1rton: can you please apply and test, thanks. The patch applies =
on plain
2.6.28 too, albeit with a little fuzz.

@Bart: We should probably backport that one to 2.6.28 after enough test=
ing,
right?

Thanks,
Boris.


--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
