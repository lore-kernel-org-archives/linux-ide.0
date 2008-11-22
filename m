From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Sat, 22 Nov 2008 18:05:56 +0300
Message-ID: <49281FD4.4090006@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>	<49280FC5.3040608@ru.mvista.com> <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:23621 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758144AbYKVPGD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 10:06:03 -0500
In-Reply-To: <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Hello.

Alan Cox wrote:

>>    But if you're saying that there is only DMA completion inetrrupt, you 
>> *cannot* completely emulate SFF-8038i BMDMA since its interrupt status 
>> is the (delayed) IDE INTRQ status. I suggest that you move away from the 
>> emulation -- Alan has said it's possible.
>>     
>
> I don't see whats wrong with treating it that way if it keeps the amount
> of code needed down.

   Well, as ata_sff_host_intr() doesn't get called, probably nothing 
indeed...

MBR, Sergei


