From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16481] WARNING: Unbalanced enable for IRQ 19
Date: Thu, 16 Dec 2010 21:33:55 GMT
Message-ID: <201012162133.oBGLXt6o007291@demeter1.kernel.org>
References: <bug-16481-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:49380 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab0LPVd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Dec 2010 16:33:56 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id oBGLXuQZ007299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 16 Dec 2010 21:33:56 GMT
In-Reply-To: <bug-16481-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16481





--- Comment #2 from Daniel Smolik <marvin@mydatex.cz>  2010-12-16 21:33:53 ---
Compile kernel without ATA/ATAPI/MFM/RLL support (DEPRECATED) solve my problem.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
