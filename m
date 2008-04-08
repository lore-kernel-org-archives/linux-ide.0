From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10425] Problem with pata_marvell kernel module : kernel 2.6.24.4 in Mandriva 2008.1 RC2 don't detect my IDE harddisk connected to a Marvell 88SE6111 IDE Controller
Date: Tue,  8 Apr 2008 09:13:21 -0700 (PDT)
Message-ID: <20080408161321.50CBE108038@picon.linux-foundation.org>
References: <bug-10425-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56857 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752388AbYDHQNY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 12:13:24 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m38GDLRF013377
	for <linux-ide@vger.kernel.org>; Tue, 8 Apr 2008 09:13:22 -0700
In-Reply-To: <bug-10425-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10425


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |alan@lxorguk.ukuu.org.uk
             Status|NEW                         |ASSIGNED




------- Comment #1 from alan@lxorguk.ukuu.org.uk  2008-04-08 09:13 -------
The driver has only been tested with the chipsets listed. I've been unable to
extract documentation from Marvell to support the others. If you can work with
the Mandrake people and verify that the relevant identifier works then that
would be useful and the id can then get added for the 6111. 

The newer chips sort of do AHCI so are handled better by the AHCI driver
(6141/6145) now it has some workarounds for where they differ from the
standard.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
