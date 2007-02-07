From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 07 Feb 2007 15:03:07 +0100
Message-ID: <45C9DC1B.2070602@imc-berlin.de>
References: <45C9A23E.3030201@imc-berlin.de>	<20070207115826.2e3609e3@localhost.localdomain>	<45C9D34E.1060007@imc-berlin.de>	<20070207135309.66942d25@localhost.localdomain>	<45C9D8F8.2000303@ru.mvista.com> <20070207141149.5c0c709b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:60908 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161315AbXBGODK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 09:03:10 -0500
In-Reply-To: <20070207141149.5c0c709b@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Alan wrote:
> On Wed, 07 Feb 2007 16:49:44 +0300
> Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
>> Hello.
>>
>> Alan wrote:
>>
>>>>> Only relevant for DMA really
>>>> So rqsize is only needed for DMA accesses?
>>     Not really, it affects both PIO and DMA.
> 
> Yes but its not relevant. The question was about performance, and your
> performance will suck equally with PIO regardless of the request size
> limit.

Ok: I rephrase my question:

Could it be that my HDD behaves strangly (i.e. doing

	hda: status timeout: status=0xd0 { Busy }
	ide: failed opcode was: unknown
	hda: no DRQ after issuing MULTWRITE_EXT
	ide0: unexpected interrupt, status=0x80, count=1
	ide0: reset: success

) sometimes when rqsize is set to 65536 altough I only do PIO transfer?

Steven
