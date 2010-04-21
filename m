From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15815] pata_legacy causes machine check
Date: Wed, 21 Apr 2010 12:11:47 GMT
Message-ID: <201004211211.o3LCBl63014315@demeter.kernel.org>
References: <bug-15815-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43877 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0DUMLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 08:11:48 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3LCBlwN014316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 21 Apr 2010 12:11:47 GMT
In-Reply-To: <bug-15815-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D15815





--- Comment #3 from J=C3=B6rg Sommer <joerg@alea.gnuu.de>  2010-04-21 1=
2:11:41 ---
I would like it if you disable this option on non-x68 architectures, be=
cause
it's difficult to know that you should not enable it. Maybe a distribut=
ion
enables it, because it's there and it's needed (useful) on x86.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.