From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Fri,  7 Nov 2008 19:13:05 -0800 (PST)
Message-ID: <20081108031305.B5957108040@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50223 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790AbYKHDNI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Nov 2008 22:13:08 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA83D5vH025482
	for <linux-ide@vger.kernel.org>; Fri, 7 Nov 2008 19:13:07 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #6 from eshaffer1@mac.com  2008-11-07 19:13 -------
(In reply to comment #5)
> (In reply to comment #2)
> > Could you try some newer kernel like 2.6.27 or 2.6.28-rc3?
> > 
> > Also did it work OK with some earlier kernel?
> > 
> > [ From the bugreport it seems that kernel from Live CD works OK? ]
> > 
> > Thanks.
> > 
> 
> I am happy to  attempt a newer kernel if I can. While technically minded, I am
> fairly new to Linux and can only load from Live CD or alt CD. Research to date
> hasn't shown updating kernel from CD as possible...?
> 
> Hardy (2.6.24-19) failed at the same point in the boot process as Intrepid. No
> other kernel attempted to date. 
> 
> The Hardy Live CD worked flawlessly, even wireless connection, which is why I
> installed. I presumed if the Live CD worked it meant an install would also.
> 
> I have also tried startx from terminal at root (hde3) on rescue cd, Ibex loads
> but keyboard and mouse are unresponsive.
> 

I have applied a firmware update to the AEC 6260M and the system will now
recognize the partitions, cylinder, block data etc. Unfortunately the boot
process still hangs at SCSI 0: with lost interrupts / DMA recovery messages. 


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
