From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata DMADIR support
Date: Mon, 17 May 2004 18:36:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A93E85.4010904@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8	840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com> <1084831524.3211.67.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19623 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261865AbUEQWhK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 18:37:10 -0400
In-Reply-To: <1084831524.3211.67.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>I am not convinced that there is no way to detect this condition at 
>>runtime, based on some hardware characteristic, or output.
> 
> 
> I agree.
> 
> Shall we try timeout, reset, and retry of the initial DMA op x12
> Inquiry?
> 
> If that fails for timeout with xD0 status, then we guess oh DMADIR and
> try again with Features = x05 Dma In, rather than our default of x01 Dma
> Out/classic?

I dunno.  Feel free to play around.  :)

Silicon Image is sending me a couple bridges, we'll see how they behave.


>>word 62
> 
> 
> Ouch, ouch, ouch.
> 
> I just dug up the fact that mask x0707 of word 62 used to mean single
> word DMA e.g. in page 54 of 111, ATA-2 of 1996-03-18, d0948r4c.pdf.
> 
> t13.org ATA/PI 7 redefining word 62 to mean DMADIR may become a
> pernicious way of searching out anyone who still thinks SWDMA exists.

SWDMA never existed for ATAPI devices.  Word 62 has -always- been 
reserved, until now.


> None of those facts have kept people over the years from writing host
> software that thinks the op decides the direction.  I think I remember
> seeing Linux-2.2 broken that way.

Yep.  Bart, our illustrious IDE maintainer, recently removed one such 
opcode table.

	Jeff



