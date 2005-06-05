From: Wes Newell <w.newell@verizon.net>
Subject: SIS180 PATA drive support
Date: Sun, 05 Jun 2005 15:58:21 -0500
Message-ID: <42A3676D.7080408@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:25822 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261617AbVFEU4G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Jun 2005 16:56:06 -0400
Received: from [192.168.0.2] ([71.240.164.117])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IHM001YRQ5HID2C@vms042.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sun, 05 Jun 2005 15:56:06 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Is there any driver that supports the PATA ports on this controller? 
Been told by Jeff Garzick that sata_sis does not support PATA drives. 
For ref. I've got a Jetway S755MAX MB, kernel 2.6.11-6mdk. I've tried 
making a new driver by changing if (trueid == 0x5518) to 0x0180 in 
sis5513.c and adding a new module named s180ata to kconfig. And while I 
did accomplish that and it compiled the new module ok, it crapped out 
painfully. I'm sure not knowing what I'm doing and not being a C 
programmer had a lot to do with that, but It appears to me that support 
for the pata ports of the sis180 could accomplished this way if done 
properly. Anyway, I'm at your mercy. I'd appreciate any reply, even if 
it's just get lost and forget about pata support.:-)

thanks

