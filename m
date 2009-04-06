From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13026] cs5536 is broken
Date: Mon, 6 Apr 2009 20:42:48 GMT
Message-ID: <200904062042.n36KgmnA007895@demeter.kernel.org>
References: <bug-13026-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43456 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZDFUmu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 16:42:50 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n36Kgm85007896
	for <linux-ide@vger.kernel.org>; Mon, 6 Apr 2009 20:42:48 GMT
In-Reply-To: <bug-13026-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13026


Sergei Shtylyov <sshtylyov@ru.mvista.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bzolnier@gmail.com,
                   |                            |sshtylyov@ru.mvista.com
         AssignedTo|io_ide@kernel-bugs.osdl.org |sshtylyov@ru.mvista.com




--- Comment #1 from Sergei Shtylyov <sshtylyov@ru.mvista.com>  2009-04-06 20:42:47 ---
(In reply to comment #0)
> Subject    : 2.6.29.1 BUG: unable to handle kernel NULL pointer dereference at
> (null)
> Submitter  : Arnd Hannemann <hannemann@nets.rwth-aachen.de>
> Date       : 2009-04-06 18:11
> References : http://marc.info/?l=linux-kernel&m=123904159829771&w=4
> Handled-By : Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Patch      : http://marc.info/?l=linux-kernel&m=123904273731477&w=4
> 
> This entry is being used for tracking a regression from 2.6.28.  Please don't
> close it until the problem is fixed in the mainline.

This is not a regression from 2.6.28 -- the driver just wasn't there at this
time, it only got merged in 2.6.29 timeframe. It's not even a regression from
2.6.29 -- the driver was merged already broken. :-)

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
