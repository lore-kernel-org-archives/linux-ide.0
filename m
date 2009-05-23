From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an
 "82801DB (ICH4) IDE Controller"
Date: Sat, 23 May 2009 11:54:13 GMT
Message-ID: <200905231154.n4NBsDSm021672@demeter.kernel.org>
References: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:45176 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954AbZEWLyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 May 2009 07:54:11 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4NBsDYG021673
	for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 11:54:13 GMT
In-Reply-To: <bug-13365-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365





--- Comment #8 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-23 11:54:13 ---
On Saturday 23 May 2009 10:11:07 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13365
> 
> 
> 
> 
> 
> --- Comment #7 from Alan <alan@lxorguk.ukuu.org.uk>  2009-05-23 08:11:06 ---
> Christopher - please open a separate bug for what is almost certainly an
> unrelated issue.

Well, the kernel config posted by Jacob has:

    # CONFIG_IDE is not set

so it would be useful to verify his 2.6.27 (last good) kernel config first.

> This actually looks like something is causing memory corruption. It's probably
> not the ATA or IDE drivers but something stomping on the cache which is why I

Certainly not IDE drivers.  Please move this bug over to libata.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
