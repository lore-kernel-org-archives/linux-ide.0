From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Wed, 19 May 2010 06:29:09 GMT
Message-ID: <201005190629.o4J6T9wX018650@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37647 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0ESG3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 02:29:10 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4J6T9O7018651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 06:29:09 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #19 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05-19 06:28:57 ---
Zenith88,

Stop whining, post your `dmesg`, `lspci` and `lspci -vvv` data or even start a
new bug report WITH the required information.

P.S. And I have to agree with you IO subsystem in Linux needs a lot of work.
"IO wait" time is just an inexcusable mess.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
