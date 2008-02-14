From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9904] ASUS DVD-E616A - drive side 80-wire cable detection failed
Date: Thu, 14 Feb 2008 07:52:09 -0800 (PST)
Message-ID: <20080214155209.6AE4D108011@picon.linux-foundation.org>
References: <bug-9904-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34578 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752113AbYBNPwL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 10:52:11 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1EFq95Z015446
	for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 07:52:10 -0800
In-Reply-To: <bug-9904-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9904


chewi@aura-online.co.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chewi@aura-online.co.uk




------- Comment #1 from chewi@aura-online.co.uk  2008-02-14 07:52 -------
I can confirm that this is also happening here with my Western Digital
WD1200JB. The motherboard an ASUS Striker Extreme, which has an NVIDIA
(nForce?) IDE controller so the bug doesn't appear to be hardware-specific.
This is a new machine so I haven't tried any earlier kernel versions.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
