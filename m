From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9728] Serverworks initialisation fails
Date: Fri, 11 Jan 2008 07:40:19 -0800 (PST)
Message-ID: <20080111154019.EF25810806A@picon.linux-foundation.org>
References: <bug-9728-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48151 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759982AbYAKPkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 10:40:21 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BFeKuj005718
	for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 07:40:21 -0800
In-Reply-To: <bug-9728-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9728





------- Comment #1 from trond.myklebust@fys.uio.no  2008-01-11 07:40 -------
Created an attachment (id=14413)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=14413&action=view)
Looks like an unterminated DMI table...

The following patch, which terminates the ide_acpi_dmi_table appears to
fix the problem.
Credit goes to Jeff Garzik...


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
