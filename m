From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 25 Nov 2009 10:28:26 GMT
Message-ID: <200911251028.nAPASQVY001567@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53357 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638AbZKYK2U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 05:28:20 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAPASQsb001569
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2009 10:28:26 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


slesru@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |slesru@gmail.com




--- Comment #17 from slesru@gmail.com  2009-11-25 10:28:22 ---
I'd like to add that this problem exists on hdd drive, ubuntu 9.10, dell 120l :

[ 6702.000206] ata1: lost interrupt (Status 0x58)
[ 6702.004018] ata1: drained 32768 bytes to clear DRQ.
[ 6702.093725] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 6702.093739] ata1.01: cmd a0/00:00:00:00:00/00:00:00:00:00/b0 tag 0
[ 6702.093740] cdb 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 6702.093742] res 58/00:01:00:00:00/00:00:00:00:00/b0 Emask 0x2 (HSM
violation)
[ 6702.093746] ata1.01: status: { DRDY DRQ }
[ 6702.093859] ata1: soft resetting link
[ 6702.340796] ata1.00: configured for UDMA/100
[ 6702.372409] ata1.01: configured for UDMA/33
[ 6702.391202] ata1: EH complete

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
