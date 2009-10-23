From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Fri, 23 Oct 2009 18:32:07 GMT
Message-ID: <200910231832.n9NIW76D011400@demeter.kernel.org>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34093 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbZJWScD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 14:32:03 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9NIW7RX011402
	for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2009 18:32:07 GMT
In-Reply-To: <bug-14310-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310


Jiri Bohac <jbohac@jikos.cz> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jbohac@jikos.cz




--- Comment #3 from Jiri Bohac <jbohac@jikos.cz>  2009-10-23 18:32:03 ---
I can still reproduce this on 2.6.31.5, where the
e13ee546bb06453939014c7b854e77fb643fd6f1 fix is included. Reverting
6029336426a2b43e4bc6f4a84be8789a047d139e helps.

Without reverting 6029336426a2b43e4bc6f4a84be8789a047d139e the system hangs on
"ide-cd driver 5.00", but sometimes I also get {DriveReady SeekComplete Error}
errors on hda before the hang -- never seen them without 
6029336426a2b43e4bc6f4a84be8789a047d139e.

A few interesting lines of output before the hang: (hand-copied, no serial
console here)

hda: ST38421A <strange_nonASCII_triangle_character_here> , ATA DISK drive
hdc: LTN5269, ATAPI CD/DVD-ROM drive
hdc: tPIO > 2, assuming tPIO=2
hdc: tPIO > 2, assuming tPIO=2
..
..
<hda seek errors>
..
possibly failed opcode: 0xc6
hda: lost interrupt
hda: 
<hda seek error>
possibly failed opcode: 0x20
 unknown patrition table
ide-cd driver 5.00
<hang>

I don't have regular access to this machine, but if help is needed, I can
arrange access to the machine.

Can we re-open this bug?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
