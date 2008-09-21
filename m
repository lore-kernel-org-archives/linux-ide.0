From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Sun, 21 Sep 2008 13:13:56 -0700 (PDT)
Message-ID: <20080921201356.8EC8A108057@picon.linux-foundation.org>
References: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33593 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752528AbYIUUOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Sep 2008 16:14:04 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8LKDuZ9031409
	for <linux-ide@vger.kernel.org>; Sun, 21 Sep 2008 13:13:57 -0700
In-Reply-To: <bug-11602-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602





------- Comment #4 from nm127@freemail.hu  2008-09-21 13:13 -------
I agree that my analysis in comment #0 was wrong. I understand that the cdrom
drive itself reports the mechtype wrongly, so this seems to be a firmware
problem of the "Optiarc DVD RW AD-7543A". 

Currently I cannot find any firmware updates for this device.
http://sonynec-optiarc.eu/en/support-service/downloads/fw_dvd-writer-ad-series.html

Should I ask the Optirac to provide one? If yes, what is the name of the
standard which they should to fulfill?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
