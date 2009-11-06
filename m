From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Fri, 6 Nov 2009 13:05:16 GMT
Message-ID: <200911061305.nA6D5GLw002771@demeter.kernel.org>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:38004 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbZKFNFK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2009 08:05:10 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nA6D5GRV002772
	for <linux-ide@vger.kernel.org>; Fri, 6 Nov 2009 13:05:16 GMT
In-Reply-To: <bug-14310-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk




--- Comment #9 from Alan <alan@lxorguk.ukuu.org.uk>  2009-11-06 13:05:14 ---
You turn the FIFO off if you are probing. Always

You cannot know the media type until you probe, and you cannot properly probe
until you've set the interface to a sane known state. The media type should be
set to indicate no media at that point.

Agreed on reverting it - it generally only affects non PC platforms anyway -
the PC ones tend to come up with the controller either in PIO 0 or configured
to match the drive by the BIOS - both of which are generally acceptable.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
