From: Dave Maurer <dcmaurer1@cox.net>
Subject: Question about ata_piix driver and Intel ESB2 SATA support
Date: Sun, 17 Sep 2006 23:09:06 -0700
Message-ID: <200609172309.06414.dcmaurer1@cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38048 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965447AbWIRGJH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 02:09:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918060907.GXNA21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>
          for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 02:09:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a Mac Pro machine running Linux.  I currently have 5 SATA drives in the 
system, and only the first 4 SATA ports are being detected by the ata_piix 
driver.

I'm not familiar with the ata_piix driver, but I did skim through the code a 
bit.  It looks like the driver is not probing the 5th and 6th SATA ports 
provided by the chip.

The code probes the PCS register at offset 0x92.  With the ESB2 chip, the PCS 
register has been extended and starts at offset 0x91, where bits [3:0] have 
the present and enable bits for SATA ports 4, and 5.

I'm not sure how hard it would be to add support to probe the two extra ports.  
The mapping register is the same as ICH6, and I can't tell if the libata 
driver totally relies on this mapping to know what to probe.

It appears the Mac Pro firmware doesn't enable AHCI, as this is a known issue 
for people running XP on them, and nothing happens when I load up the AHCI 
driver.  I also don't know how many people have tried loading up motherboards 
with the ESB2 chip with 5 or 6 SATA drives, so I don't know if people have 
tried this before.

Could anyone shed some light on this?

Thanks!

Dave Maurer
dcmaurer1@cox.net
