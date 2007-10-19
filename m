From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Sat, 20 Oct 2007 00:26:23 +0400
Message-ID: <471912EF.4020208@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de> <200710172115.13068.marogge@onlinehome.de> <47167335.1020903@ru.mvista.com> <200710192158.03836.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:56779 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761274AbXJSU0N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 16:26:13 -0400
In-Reply-To: <200710192158.03836.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Hello.

Martin Rogge wrote:

>>    BTW, can you try adding #define DEBUG to the driver meanwhile?..

> Yoda said: Try not. Do or do not. There is no try.

    :-)

> So I did it. To be precise, I #defined both DEBUG and CMD_DEBUG. However, I am 
> not sure the result is conclusive.

> On a good kernel I get a lot of lines of the type

> hda: dma_stat: 0x24 irq_stat: 0x44 mask: 0x04
> hdc: dma_stat: 0x24 irq_stat: 0x5c mask: 0x10

    Yeah, this is what's emitted by the dma_end() method which used 
CFR/ARTTIM23 PCI config. regs. to chack the interrupt status.

> and variations thereof. On a broken kernel the middle part changes to

> hda: dma_stat: 0x24 mrdmode: 0x00 mask: 0x04

    Hm... this means that the chip doesn't work as documented in the spec, 
i.e. MRDMODE reg. seems write only, like on older chips.  Could you post the 
output of 'lspci -v'?

> Hope this is of any help,

    It is of great help. :-)

> cu Martin

MBR, Sergei
