From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Sun, 23 Nov 2008 20:10:42 +0300
Message-ID: <49298E92.9070605@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com> <49280FC5.3040608@ru.mvista.com> <49282187.8090602@ru.mvista.com> <492851BA.3060306@caviumnetworks.com> <4929730B.2070904@ru.mvista.com> <492975B9.2000807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:36533 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751528AbYKWRKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 12:10:53 -0500
In-Reply-To: <492975B9.2000807@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chad Reese <kreese@caviumnetworks.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Hello, I wrote:

>>> +     * stoppng and restarting the DMA, we'll let the hardware do 
>>> it. If the
>>
>>   stopping
>>
>>> +     * DMA is really stopped early due to an error condition, a later
>
>   I'm not sure which error condition is meant here: ERR=1 in the 
> status register, some internal DMA error, both?
>
>>> +     * timeout will force us to stop.
>>
>>   Sigh... So any command error will result in a timeout. I wonder 
>> what hardware genius decided that CF doesn't need an IRQ...

   Ah, I forgot thet libata should be supporting polling mode, so should 
handle ERR=1 case. In this case the comment about the timeout 
contradicts your words about an interrupt being generated on DMA error.

>   So, Octeon DMA can actually generate an error interrupt?

MBR, Sergei


