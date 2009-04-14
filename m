From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13086] pata_via can't initialize 2nd HDD on VIA VX800 chipsets
 (problem in via_tf_load)
Date: Tue, 14 Apr 2009 06:02:43 GMT
Message-ID: <200904140602.n3E62h2d028178@demeter.kernel.org>
References: <bug-13086-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60663 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZDNGCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 02:02:44 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3E62hmA028179
	for <linux-ide@vger.kernel.org>; Tue, 14 Apr 2009 06:02:43 GMT
In-Reply-To: <bug-13086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13086


Andrew Morton <akpm@linux-foundation.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk
          Component|IDE                         |Serial ATA
         AssignedTo|io_ide@kernel-bugs.osdl.org |jgarzik@pobox.com




--- Comment #1 from Andrew Morton <akpm@linux-foundation.org>  2009-04-14 06:02:42 ---
Reassigned to ata/pata.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
