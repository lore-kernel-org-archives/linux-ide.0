From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16414] Panic during IO from both hard disk and CD-ROM on VIA
 IDE chipset using pata_via
Date: Mon, 19 Jul 2010 07:58:26 GMT
Message-ID: <201007190758.o6J7wQwU019835@demeter.kernel.org>
References: <bug-16414-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43466 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0GSH60 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jul 2010 03:58:26 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6J7wQdS019836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 19 Jul 2010 07:58:26 GMT
In-Reply-To: <bug-16414-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16414





--- Comment #1 from Ben Livengood <ben.livengood@gmail.com>  2010-07-19 07:58:10 ---
Created an attachment (id=27142)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=27142)
lspci -vvxx output

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
