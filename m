From: Craig Block <chblock3@yahoo.com>
Subject: IRQ Delivery Problem for MCP65
Date: Fri, 27 Jul 2007 21:53:46 -0700 (PDT)
Message-ID: <151241.60877.qm@web58114.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web58114.mail.re3.yahoo.com ([68.142.236.137]:43317 "HELO
	web58114.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751275AbXG1Exr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 00:53:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Hello,

I'm having trouble getting Linux to see any hard drives on an ASUS M2N-X
motherboard with an MCP65 (nForce 520) chipset.  When the kernel probes the
AHCI controllers, it hangs for a minute or so on each one and returns the
following;

ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)

Thanks in advance for any help you can lend,

  - Craig


       
____________________________________________________________________________________
Got a little couch potato? 
Check out fun summer activities for kids.
http://search.yahoo.com/search?fr=oni_on_mail&p=summer+activities+for+kids&cs=bz 
