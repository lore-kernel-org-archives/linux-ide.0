From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Thu, 6 May 2010 01:49:20 GMT
Message-ID: <201005060149.o461nKnx008956@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48585 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0EFBtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 21:49:21 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o461nKQd008957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 6 May 2010 01:49:20 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884





--- Comment #7 from Robert Hancock <hancockrwd@gmail.com>  2010-05-06 01:49:17 ---
Ah, it's one of those JMicron PATA controllers. I'm assuming you only have one
physical PATA connector on the board, so splitting the devices onto different
channels isn't an option.

Unfortunately I don't think there's much that can be done about this at the
kernel level, it's kind of an inherent limitation of PATA. The burning software
might be able to improve on things with different selection/ordering of
commands, but the kernel doesn't have any control over that, it just passes the
commands through to the drive.

Honestly I think the best solution here is to either add another PATA
controller to provide another channel, or replace one of the devices with a
SATA one.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
