From: Gene Heskett <gene.heskett@gmail.com>
Subject: pata_via question.
Date: Fri, 21 Dec 2007 07:55:52 -0500
Message-ID: <200712210755.52792.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms040pub.verizon.net ([206.46.252.40]:53499 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXLUM4a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 07:56:30 -0500
Received: from coyote.coyote.den ([72.65.67.83])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JTE00KP2HAOC1I3@vms040.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Fri, 21 Dec 2007 06:56:49 -0600 (CST)
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>

Running 2.6.24-rc6 here.

I just installed a combo card, 3 sata ports, one pata port, VIA VT6421 chip on 
it.

I do not have an ide drive attached to it, and my bios does not acknowledge 
the presence of the card or the sata drive attached, meaning I have to keep a 
ide drive for use as the /boot partition.

I have built the pata_via module as well as the sata_via module and once 
booted it all works except the boot doesn't autoload the pata_via module, and 
when I manually load it with modprobe, or rmmod it, there is no mention of it 
in dmesg or the system messags log, nor does it effect the lspci output.  
Should it not at least report the chip number?

Or is it all covered by this:  from lspci, with or without pata_via loaded

01:0a.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID Controller 
(rev 50)

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Higher education helps your earning capacity.  Ask any college professor.
