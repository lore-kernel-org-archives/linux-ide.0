From: Craig Block <chblock3@yahoo.com>
Subject: 40-wire/80-wire detection
Date: Thu, 12 Jul 2007 14:09:20 -0700 (PDT)
Message-ID: <527770.57572.qm@web58107.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web58107.mail.re3.yahoo.com ([68.142.236.130]:41321 "HELO
	web58107.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964901AbXGLVQB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 17:16:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Linux kernel: version 2.6.22.1
Chipset: VIA VT8363 + VT82C686A
Hard drives: Quantum Fireball LCT10 (UDMA66)

I'm having a problem with the 80-wire/40-wire cable detection in the
ata driver.  Even when I configure the kernel with IDEDMA_IVB set, I
still get the 40-wire speed downgrade on hda.

Why did you guys put that 80-wire/40-wire cable detection in the ata
driver anyway?  Since when is it your job to police me in making sure
I'm using the correct cable on my drives.  

This is a pefect example of why I feel Linux isn't worth the trouble. 
If it weren't free of cost, I wouldn't go near it.  But then again, I
guess you get what you pay for so I shouldn't complain.

Regards,

  - Craig


       
____________________________________________________________________________________
Looking for a deal? Find great prices on flights and hotels with Yahoo! FareChase.
http://farechase.yahoo.com/
