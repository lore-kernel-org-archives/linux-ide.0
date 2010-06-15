From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Tue, 15 Jun 2010 19:12:35 GMT
Message-ID: <201006151912.o5FJCZN0020582@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:51223 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab0FOTMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2010 15:12:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o5FJCaCc020584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2010 19:12:36 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142





--- Comment #15 from Andrew Morton <akpm@linux-foundation.org>  2010-06-15 19:12:28 ---
(In reply to comment #12)
> Created an attachment (id=26776)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=26776) [details]
> kernel oops v3
> 
> this one is done via firewire

This seems impossible.  I think the oops happened in

int ide_complete_rq(ide_drive_t *drive, int error, unsigned int nr_bytes)
{
        ide_hwif_t *hwif = drive->hwif;

accessing 0x00000040, so `drive' is NULL.  But it's clearly non-NULL up in
cdrom_newpc_intr().  Possibly it's a miscompile.  But you've tried several
different kernel version, which I assume were compiled by someone at gentoo.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
