From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Sun, 23 Nov 2008 20:14:34 +0300
Message-ID: <49298F7A.4070909@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>	<49280FC5.3040608@ru.mvista.com> <20081122145204.52270dbe@lxorguk.ukuu.org.uk> <49281FD4.4090006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:36622 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751532AbYKWROo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 12:14:44 -0500
In-Reply-To: <49281FD4.4090006@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Hello, I wrote:

>>>    But if you're saying that there is only DMA completion inetrrupt, 
>>> you *cannot* completely emulate SFF-8038i BMDMA since its interrupt 
>>> status is the (delayed) IDE INTRQ status. I suggest that you move 
>>> away from the emulation -- Alan has said it's possible.
>>>     
>>
>> I don't see whats wrong with treating it that way if it keeps the amount
>> of code needed down.
>
>   Well, as ata_sff_host_intr() doesn't get called, probably nothing 
> indeed...

   Hm, it does get called but only with BSY=0, so all this seems more 
tricky than I thought...

MBR, Sergei


