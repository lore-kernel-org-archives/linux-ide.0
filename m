From: Brian King <brking@linux.vnet.ibm.com>
Subject: Recent ipr breakage (ata_do_eh api change)
Date: Fri, 04 May 2007 10:15:00 -0500
Message-ID: <463B4DF4.70908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:35310 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbXEDPQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 11:16:31 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l44FGVOW013655
	for <linux-ide@vger.kernel.org>; Fri, 4 May 2007 11:16:31 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l44FGU7V178308
	for <linux-ide@vger.kernel.org>; Fri, 4 May 2007 09:16:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l44FGTTS028678
	for <linux-ide@vger.kernel.org>; Fri, 4 May 2007 09:16:29 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, thlin@linux.vnet.ibm.com

I just noticed that the following patch (git-libata-all-ipr-fix)
is currently in mainline which results in inducing a compiler warning:

http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=120bda35ff8514c937dac6d4e5c7dc6c01c699ac;hp=771b8dad9653d2659e0ffcc237184cb16c317788

This looks like a fix for a compile problem with the libata-all
branch. I did some poking around and it looks like the ata_do_eh
api change is in Jeff's #all branch, but not in #upstream, so
I am assuming the ipr patch mentioned above should be reverted
in mainline for now.

Thanks,

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
