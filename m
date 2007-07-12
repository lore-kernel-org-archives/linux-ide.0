From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 40-wire/80-wire detection
Date: Thu, 12 Jul 2007 17:28:41 -0400
Message-ID: <46969D09.4010607@garzik.org>
References: <527770.57572.qm@web58107.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56509 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933758AbXGLV2n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 17:28:43 -0400
In-Reply-To: <527770.57572.qm@web58107.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Block <chblock3@yahoo.com>
Cc: linux-ide@vger.kernel.org

Craig Block wrote:
> Linux kernel: version 2.6.22.1
> Chipset: VIA VT8363 + VT82C686A
> Hard drives: Quantum Fireball LCT10 (UDMA66)
> 
> I'm having a problem with the 80-wire/40-wire cable detection in the
> ata driver.  Even when I configure the kernel with IDEDMA_IVB set, I
> still get the 40-wire speed downgrade on hda.
> 
> Why did you guys put that 80-wire/40-wire cable detection in the ata
> driver anyway?  Since when is it your job to police me in making sure
> I'm using the correct cable on my drives.  

If you signal a 40-wire cable too fast, you get trouble with a capital T.

	Jeff



