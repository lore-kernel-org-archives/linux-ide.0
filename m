From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Mon, 24 Nov 2008 12:40:51 -0800
Message-ID: <492B1153.5080001@caviumnetworks.com>
References: <49261BE5.2010406@caviumnetworks.com>	<49280FC5.3040608@ru.mvista.com> <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:65334 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYKXUlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 15:41:04 -0500
In-Reply-To: <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Alan Cox wrote:
>>    But if you're saying that there is only DMA completion inetrrupt, you 
>> *cannot* completely emulate SFF-8038i BMDMA since its interrupt status 
>> is the (delayed) IDE INTRQ status. I suggest that you move away from the 
>> emulation -- Alan has said it's possible.
> 
> I don't see whats wrong with treating it that way if it keeps the amount
> of code needed down.
> 

For exactly that reason, I intend to continue to try to emulate it.

David Daney
