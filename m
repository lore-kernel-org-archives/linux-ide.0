From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12437] My DVD+\-RW ROM can not write any disc
Date: Sun, 18 Jan 2009 08:35:31 -0800 (PST)
Message-ID: <20090118163531.BDEAB10800C@picon.linux-foundation.org>
References: <bug-12437-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39816 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756080AbZARQgG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2009 11:36:06 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0IGZVh2013059
	for <linux-ide@vger.kernel.org>; Sun, 18 Jan 2009 08:35:32 -0800
In-Reply-To: <bug-12437-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12437





------- Comment #6 from eiskalt.erwischt@mail.ru  2009-01-18 08:35 -------
  Sorry, realy latest working kernel is 2.6.27.9 . ide-cd complain that tray is
open because k3b make it opened(k3b waiting for blank DVD+RW)! I try to format
DVD+RW disks and it was successful.
  I change all BIOS settings to default, format DVD+RW and after fresh reboot
burning was successful. But when i make quick format in Windows XP, and try to
burn disk, I get error messages like in my 1st post! Borislav, do you have any
ideas about it?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
