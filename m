From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Sat, 1 May 2010 01:29:42 GMT
Message-ID: <201005010129.o411Tgn7022000@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34593 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab0EAB3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Apr 2010 21:29:43 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o411Tgqb022002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sat, 1 May 2010 01:29:42 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #2 from Robert Hancock <hancockrwd@gmail.com>  2010-05-01 01:29:37 ---
You can't have a command outstanding on both the master and slave drive on a
PATA channel at the same time. If the software issues a command like "erase
disc" to the drive, during the time that command is outstanding no commands can
be issued to the other drive on that channel, it's the way PATA works.

Now, there may be a difference in what commands the burning software is using
or the ordering that results in some of them taking longer than it does in
Windows or something. (I don't know the MMC commands that well but I think some
of them do have a mode where you can issue the command and poll periodically to
see if it's done rather than blocking on the operation until it finishes.) That
isn't anything the kernel can do anything about, though - if something issues a
command to one drive on the channel that takes a long time, anything wanting to
access the other drive just has to wait.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
