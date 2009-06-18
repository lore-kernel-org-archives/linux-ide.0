From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13575] After S3 resume IDE reports SRST failed (errno=-16)
Date: Thu, 18 Jun 2009 18:56:52 GMT
Message-ID: <200906181856.n5IIuqAA029701@demeter.kernel.org>
References: <bug-13575-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41272 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbZFRS4t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 14:56:49 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5IIuq0G029702
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 18:56:52 GMT
In-Reply-To: <bug-13575-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13575


Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bzolnier@gmail.com
          Component|IDE                         |Serial ATA
         AssignedTo|io_ide@kernel-bugs.osdl.org |jgarzik@pobox.com




--- Comment #1 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-06-18 18:56:51 ---
This system uses libata so I'm reassigning the bug-report accordingly.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
