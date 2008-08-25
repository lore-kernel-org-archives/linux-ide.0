From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11426] reproducable panic when reading cdrom (atapi dma)
Date: Mon, 25 Aug 2008 12:48:35 -0700 (PDT)
Message-ID: <20080825194835.5A748108008@picon.linux-foundation.org>
References: <bug-11426-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35073 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755223AbYHYTsh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 15:48:37 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PJmZmE011639
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 12:48:36 -0700
In-Reply-To: <bug-11426-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11426


akpm@osdl.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |venkatesh.pallipadi@intel.co
                   |                            |m
         AssignedTo|io_ide@kernel-bugs.osdl.org |acpi_power-processor@kernel-
                   |                            |bugs.osdl.org
          Component|IDE                         |Power-Processor
            Product|IO/Storage                  |ACPI
         Regression|0                           |1




------- Comment #3 from akpm@osdl.org  2008-08-25 12:48 -------
A divide-by-zero in acpi_idle_enter_simple()

Marked as regression, reassigned to acpi people.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
