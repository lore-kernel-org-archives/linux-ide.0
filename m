From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Sun, 15 Mar 2009 23:20:05 -0700 (PDT)
Message-ID: <20090316062005.B57B1108040@picon.linux-foundation.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33452 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995AbZCPGVO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 02:21:14 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2G6K6lU014740
	for <linux-ide@vger.kernel.org>; Sun, 15 Mar 2009 23:20:42 -0700
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




------- Comment #5 from bbpetkov@yahoo.de  2009-03-15 23:20 -------
Hi,

please do

objdump -d drivers/ide/ide-tape.o > ide-tape.dsm
make drivers/ide/ide-tape.s

and send me .dsm and .s files.

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
