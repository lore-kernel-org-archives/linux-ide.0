From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: SATA and hdparm
Date: Tue, 03 Aug 2004 02:22:03 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410EE8BB.7040508@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:38661 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S264795AbUHCBWE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Aug 2004 21:22:04 -0400
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-33.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1Bro0B-000DfG-0X
	for linux-ide@vger.kernel.org; Tue, 03 Aug 2004 01:22:03 +0000
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

When will I be able to use "hdparm -I /dev/sda" and "hdparm -S /dev/sda" 
and other commands like that?

I have Serial ATA drives, and when using them in PATA mode, those hdparm 
commands worked. Should I use something different when in Serial ATA mode?

Thanks

James
