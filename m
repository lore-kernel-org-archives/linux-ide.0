From: Dave Stubbs <dave.stubbs@utoronto.ca>
Subject: Kernel Panic sata_promise with atapi on dual Opteron
Date: Tue, 17 May 2005 01:07:59 -0400
Message-ID: <42897C2F.9060609@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [206.186.75.94] ([206.186.75.94]:36873 "EHLO
	mailstop.8inchfloppy.com") by vger.kernel.org with ESMTP
	id S261808AbVEQFHr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 May 2005 01:07:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Jeff,

Don't know if you've seen this before, but I thought I should mention it 
since I seem to be able to reproduce it quite reliably.

I am trying to get my new Plextor SATA DVD-RW drive working under 
linux.  I have it hooked up to a Promise SATAII150 TX4 controller, which 
sees it ok during BIOS init.  The system this is all running on is a 
Dual Opteron 246 system on a Tyan Tiger motherboard.

If I enable ATAPI support in include/linux/libata.h and recompile the 
kernel, I get the following when the module tries to load:

Kernel Bug at sata_promise:468
invalid operand 0000 [1] SMP

and then the kernel panics.

This happens the same with 2.6.11.8, 2.6.11.9, and 2.6.11-gentoo-r6.  It 
also happens whether sata_promise is compiled as a module or integrated.

Does this give enough information to make heads or tails of this? 

Thanks very much for your time,

Dave...
