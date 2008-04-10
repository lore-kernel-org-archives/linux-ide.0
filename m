From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 06:57:51 -0700 (PDT)
Message-ID: <20080410135751.21E62108060@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52322 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754605AbYDJN6W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 09:58:22 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3ADvpZp009880
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 06:57:52 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #2 from alan@lxorguk.ukuu.org.uk  2008-04-10 06:57 -------
No real suprises there

CF devices and adapters are sometimes good enough for UDMA at 66MHz or better
but forget to report the cable detection. For those boards we keep tables and
if you provide the output of dmidecode that can be updated to include this
board (in the windows world vendors ship drivers so they can knobble the check
in their driver or .inf file)

High UDMA modes demand good cable and signal quality and we regularly see mixed
CF and disk on the same cable as failing (the CRC message is signal corruption
on the wire). I don't therefore think this is a software bug

The dmidecode and lspci -vvxxx output would be nice so we can let the kernel
know your system has a hardwired DMA capable CF slot and automate that bit.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
