From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9904] ASUS DVD-E616A - drive side 80-wire cable detection failed
Date: Mon,  3 Mar 2008 03:08:27 -0800 (PST)
Message-ID: <20080303110827.C4954108065@picon.linux-foundation.org>
References: <bug-9904-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45051 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760926AbYCCLI3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 06:08:29 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m23B8Y4F021276
	for <linux-ide@vger.kernel.org>; Mon, 3 Mar 2008 03:08:36 -0800
In-Reply-To: <bug-9904-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9904





------- Comment #4 from Manfred.Knick@T-Online.de  2008-03-03 03:08 -------
(In reply to comment #2)
> James, you are using different host driver so most likely this is not the same
> bug - please open a new bugzilla entry and post dmesg command output.

Just another example - maybe it helps:

ASUS M2N-SLI Deluxe with NVidia nForce 570 SLI MCP

Primary Master: Plextor PX-130A - fails to detect 80-wire
Primary Slave:  Plextor PX-760A + succeeds


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
