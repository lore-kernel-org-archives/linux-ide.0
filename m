From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Tue, 30 Sep 2008 22:59:01 -0700 (PDT)
Message-ID: <20081001055901.E3AB210805B@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49911 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710AbYJAF7e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Oct 2008 01:59:34 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m915x3x0000447
	for <linux-ide@vger.kernel.org>; Tue, 30 Sep 2008 22:59:04 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #22 from tj@kernel.org  2008-09-30 22:59 -------
Sorry about the long delay.  Can you please post full kernel log w/ the card
reader removed.  It seems usbstorage is trying to register the SCSI device used
by the card reader.  Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
