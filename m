From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12290] hda: ide_cd_check_ireason: wrong transfer direction!
Date: Thu, 25 Dec 2008 04:06:56 -0800 (PST)
Message-ID: <20081225120656.6BEC8108043@picon.linux-foundation.org>
References: <bug-12290-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47141 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbYLYMHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Dec 2008 07:07:16 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBPC6uqQ028470
	for <linux-ide@vger.kernel.org>; Thu, 25 Dec 2008 04:06:57 -0800
In-Reply-To: <bug-12290-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12290





------- Comment #1 from udovdh@xs4all.nl  2008-12-25 04:06 -------
Created an attachment (id=19483)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=19483&action=view)
messages file of EN12000 w/ 2.6.27.10

To show how soon the error orccurs and what happens after that


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
