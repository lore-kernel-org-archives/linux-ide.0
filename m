From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Sat, 03 Feb 2007 10:40:00 +0900
Message-ID: <45C3E7F0.6000506@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202174235.14b13f3e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:44646 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946213AbXBCBkH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 20:40:07 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1003258wxd
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 17:40:05 -0800 (PST)
In-Reply-To: <20070202174235.14b13f3e@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: ahaas@airmail.net, linux-ide@vger.kernel.org

Alan wrote:
>> * Control bits in the timing register wasn't cleared properly while
>>   programming PIO mode.
> 
> Yep and if the BIOS programmed the slave into DMA that might not be ideal.

How so?  The bit will be programmed by set_dmamode() right after
set_piomode() is complete.

>> * MWDMA mode programming cleared the wrong part of control bits.  I
>>   think this can fix your problem.
> 
> Your change does nothing here.
> 
> 	0x0F + 1 * 0xE1 = 0xF0
> 
> It's just a construct to avoid the use of the ugly C "?" operator. The
> rest of the code uses ? so the change makes sense for style, but it
> doesn't appear to be a bug.

(0x0F + 0xE1 * ap->port_no)

1. when ap->port_no == 0
	(0x0f + 0xe1 * 0) == 0x0f
2. when ap->port-no == 1
	(0x0f + 0xe1 * 1) == 0xf0

(ap->port_no ? 0x0f : 0xf0)

1. when ap->port_no == 0
	(0 ? 0x0f : 0xf0) == 0xf0
2. when ap->port_no == 1
	(1 ? 0x0f : 0xf0) == 0x0f

See the difference?  Smart one liners are dangerous.  ?* is _much_
better than cryptic arithmetic.

>> * MWDMA mode programming cleared udma_mask even when the controller
>>   doesn't support UDMA.  This doesn't matter for your case.
> 
> Or on the actual hardware.

I was trying to make it more consistent with pio counterpart.  We can
remove if() from set_piomode too.  Let's just keep things in sync
between stuff including ide piix driver.

-- 
tejun
