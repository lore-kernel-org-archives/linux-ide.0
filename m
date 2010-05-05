From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Wed, 5 May 2010 23:23:55 GMT
Message-ID: <201005052323.o45NNtXj015938@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54084 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab0EEXX5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 19:23:57 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o45NNtXL015939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 5 May 2010 23:23:55 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884





--- Comment #5 from Robert Hancock <hancockrwd@gmail.com>  2010-05-05 23:22:48 ---
That part of the log isn't very interesting, obviously someone's trying to read
from the disc and the drive's saying no (possibly because the disc's still
blank). Can you post the output of dmesg after bootup?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
