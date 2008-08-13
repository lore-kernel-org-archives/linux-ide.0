From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Wed, 13 Aug 2008 02:06:06 -0700 (PDT)
Message-ID: <20080813090606.D410411D109@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50689 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753952AbYHMJGi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 05:06:38 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7D966Gp002066
	for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 02:06:07 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943


tj@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|jgarzik@pobox.com           |tj@kernel.org
             Status|NEW                         |ASSIGNED




------- Comment #18 from tj@kernel.org  2008-08-13 02:06 -------
Can you please full kernel log?  Somehow it tried to add the same device twice
(or different devices with the same name) and apparently error handling in
duplicate case is incorrect.  Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
