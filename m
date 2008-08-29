From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11047] pata_it821x with Maxtor 7270AV: irq 11: nobody cared
Date: Fri, 29 Aug 2008 07:16:09 -0700 (PDT)
Message-ID: <20080829141609.C255710805B@picon.linux-foundation.org>
References: <bug-11047-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53188 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757870AbYH2OQo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Aug 2008 10:16:44 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7TEG9vC024953
	for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2008 07:16:10 -0700
In-Reply-To: <bug-11047-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11047


tj@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |tj@kernel.org
             Status|NEW                         |ASSIGNED




------- Comment #1 from tj@kernel.org  2008-08-29 07:16 -------
Does "acpi=noirq" help?  If not, does "irqpoll" help?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
