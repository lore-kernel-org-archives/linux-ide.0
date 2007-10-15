From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata-core: Drop in the final bit of IORDY handling
Date: Tue, 16 Oct 2007 00:32:35 +0400
Message-ID: <4713CE63.2010006@ru.mvista.com>
References: <20071015192040.5a11bcf7@the-village.bc.nu>	<4713C2B1.7090701@ru.mvista.com> <20071015212502.73ffc51c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:12051 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750807AbXJOUcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 16:32:22 -0400
In-Reply-To: <20071015212502.73ffc51c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:

>>>+ 	/* Ancient devices may need us to avoid IORDY */
>>>+ 	if (ata_pio_need_iordy(dev))
>>>+ 		tf.nsect = dev->xfer_mode;
>>>+ 	else
>>>+ 		tf.nsect = 0x01;

>>    This is wrong logic as I've alredy pointed out: according to the ATA-2 
>>setting *any* PIO mode via 0x08..0x0c commands assumes IORDY is enabled.
>>We should only set mode 0x01 (default w/IORDY disabled) if device supports 
>>IORDY and the host doesn't.

> ata_pio_need_iordy is false if

> - the controller does not support iordy

    Hm, I'm sorry -- it turned out that I was looking at 2.6.21...

> or

> - mode <= PIO 2 and the device does not support iordy

> I can tighten that if to
> 
> 	if (!ata_pio_need_iordy(dev) && ata_has_iordy(dev->id))
> 		tf.nsect = 0x01;
> if you prefer ?

    Yeah, that'd be better. :-)

> Alan

MBR, Sergei
