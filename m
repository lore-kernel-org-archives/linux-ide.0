From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may show errors in pata_amd | pata_acpi
 unless CRS is turned off by pci=nocrs
Date: Fri, 05 Feb 2016 20:01:58 +0000
Message-ID: <bug-111901-11633-sDb1nqLmnG@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39779 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbcBEUCC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 15:02:02 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id DC2FF20389
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 20:02:00 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0DE1C2039C
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 20:02:00 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

Felix Miata <mrmazda@earthlink.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mrmazda@earthlink.net

--- Comment #4 from Felix Miata <mrmazda@earthlink.net> ---
Created attachment 202991
  --> https://bugzilla.kernel.org/attachment.cgi?id=202991&action=edit
.tgz of lspci -vv & hwinfo output from Biostar M7NCD Ultra motherboard

adding CC here as 
https://bugzilla.redhat.com/show_bug.cgi?id=1302071#c22
may have been this issue with this NForce2 400 Ultra motherboard:
http://www.biostar-usa.com/mbdetails.asp?model=M7NCD%20ULTRA

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
