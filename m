From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 07 Feb 2007 17:10:52 +0300
Message-ID: <45C9DDEC.508@ru.mvista.com>
References: <45C9A23E.3030201@imc-berlin.de>	<20070207115826.2e3609e3@localhost.localdomain>	<45C9D34E.1060007@imc-berlin.de>	<20070207135309.66942d25@localhost.localdomain>	<45C9D8F8.2000303@ru.mvista.com> <20070207141149.5c0c709b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34261 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161322AbXBGOKz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 09:10:55 -0500
In-Reply-To: <20070207141149.5c0c709b@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>, linux-ide@vger.kernel.org

Hello.

Alan wrote:

>>>>>Only relevant for DMA really

>>>>So rqsize is only needed for DMA accesses?

>>    Not really, it affects both PIO and DMA.

> Yes but its not relevant. The question was about performance, and your
> performance will suck equally with PIO regardless of the request size
> limit.

    Performace would suck even more with the single sector transfers. :-)

> Alan

MBR, Sergei
