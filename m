From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata atapi work #5
Date: Fri, 14 May 2004 15:09:16 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A5195C.2000402@pobox.com>
References: <1084560167.8752.7.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61625 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262114AbUENTJ3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 15:09:29 -0400
In-Reply-To: <1084560167.8752.7.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>-				if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
>>+				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
>>...
>>-	ATA_QCFLAG_POLL		= (1 << 5), /* polling, no interrupts */
> 
> 
> Back in PATA, when I set x02 ATA_NIEN, I mis/remember I saw INTRQ float,
> rather than becoming reliably deasserted.
> 
> Is life better in SATA?

On pure SATA, you just have a bit in a FIS, as I mentioned in one of the 
other emails (in this current email flurry :)).

On bridged SATA, where either the host controller or the device, or 
both, have an on-device SATA<->PATA bridge, the bridge must deal with 
INTRQ.  On the whole it is _much_ more clean.

Read up in the SATA docs on the difference between a "command FIS" and a 
"control FIS".  Here's a quick intro...

Both are Host-to-Device Register FIS's.  The former is sent to the 
device when the Command shadow register is written.  The latter is sent 
to the device when the Device Control register is written.  Both types 
of H2D Register FIS, command and control, send a complete copy of the 
taskfile shadow registers to the device at that time.

Reading your emails, you sound like a "hardware guy" to me :)  SATA is 
_very_ different from PATA at the hardware level.  What used to be chip 
selects and signals are now bits in a data structure that is sent -- 
much like an ethernet frame -- over a serial link.

	Jeff



