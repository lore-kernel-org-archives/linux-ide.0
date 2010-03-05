From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15445] pata_jmicron incorrectly downgrades CompactFlash to
 UDMA/33
Date: Fri, 5 Mar 2010 02:32:32 GMT
Message-ID: <201003050232.o252WWwX031112@demeter.kernel.org>
References: <bug-15445-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39287 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab0CECcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 21:32:33 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o252WWEk031114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 5 Mar 2010 02:32:32 GMT
In-Reply-To: <bug-15445-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=15445


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #1 from Robert Hancock <hancockrwd@gmail.com>  2010-03-05 02:32:26 ---
Likely the card doesn't implement the cable detection protocol properly and so
it appears as a 40-wire cable. I think you can use the libata.force parameter
to force detection of a certain cable type (see
Documentation/kernel-parameters.txt). I'm not sure there's a good approach to
doing this automatically though, if the device IDs for the card aren't unique..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
