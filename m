From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 19:04:41 +0100
Message-ID: <45BF88B9.3050802@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de>	<20070130164401.295f9913@localhost.localdomain>	<45BF7658.1090204@imc-berlin.de>	<20070130172629.70ad628d@localhost.localdomain>	<45BF7E21.7010605@imc-berlin.de> <20070130180727.594b35d0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:3123 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965672AbXA3SEn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 13:04:43 -0500
In-Reply-To: <20070130180727.594b35d0@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan wrote:
>> Hmm. Don't think so. Since the use of ioremap() I think the MMU treats the
>> area as none-cacheable, right?
> 
> Thats only the first half of the story. If you don't decode byte level
> fetches in the FPGA or the code is doing something like
> 
> 
> 		read 16 bit value
> 		shift 8
> 		return half
> 
> for 8 bit reads you'll get wrong answers.

I have connected HDD's A[2..0] to CPU's A[3..1] and do something like

        for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
                hw.io_ports[i] = ide_virt_base + (i << 1);
        }

thus all HDD registers are accessed on a 16bit aligned address. Thus
ide_inb() should return the correct value.
And btw are things like identify driver use 8bit transfers?

How could one then explain

current capacity is 78140160 sectors would be           0x000004A85300
native  capacity is 185074430006016 sectors would be    0xA852FFA85300

? First three bytes ok, then the other three bytes rubbish?

Steven



