From: Isak Styf <isak@styfsoftware.se>
Subject: Via VT6421 PATA support
Date: Sat, 17 Mar 2007 15:03:40 +0100
Message-ID: <BA4CEFA0-4132-412E-815C-687B253AF6A2@styfsoftware.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay1.bredband.net ([195.54.107.83]:45335 "EHLO
	mailrelay1.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965583AbXCQOa2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 10:30:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi!

I am wondering why VT6421 PATA support is still on the todo list in  
sata_via.c although patches have been posted that makes it work?

I am currently looking at 2.6.20-1.2925.fc6. I had hoped that the  
support would be added in that kernel, but unfortunately it seems to  
have been left out. Why is this? Have you been notified about any  
stability issues?

I am now running a manually patched 2.6.19-1.2895, but i would of  
course prefer to have this functionality in the stock kernel.

The patch i am currently using is this one:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-12/msg00985.html

     /// Isak Styf

