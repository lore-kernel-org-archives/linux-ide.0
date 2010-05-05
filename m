From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Wed, 5 May 2010 14:56:42 GMT
Message-ID: <201005051456.o45EugU4008645@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42553 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934420Ab0EEO5B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 10:57:01 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o45EuiQM008663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 5 May 2010 14:56:44 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884





--- Comment #4 from Dan Hollocher <danielhollocher@gmail.com>  2010-05-05 14:55:42 ---
Created an attachment (id=26235)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=26235)
/var/log/kern.log from the sda/testing install, after I burned a cd

the I/O errors on sr0 happen when I put a disk in the drive  (I've seen this
with 3 RW disks.  I don't have any other non-RW disks).  The kjournald thing
happened when I started k3b.  I'm pretty sure the later I/O errors happened
when the disk burning was completed.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
