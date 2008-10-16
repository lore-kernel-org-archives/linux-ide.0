From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide-dma: fix ide_build_dmatable() for TRM290
Date: Thu, 16 Oct 2008 16:20:40 +0400
Message-ID: <48F73198.20209@ru.mvista.com>
References: <200809282241.26289.sshtylyov@ru.mvista.com> <48F72CC7.2040202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58970 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753157AbYJPMUo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 08:20:44 -0400
In-Reply-To: <48F72CC7.2040202@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

>> Apparently, 'xcount' being 0 does not mean 0 bytes for TRM290; it 
>> means 4 bytes, judging from the code immediately preceding this 
>> check.  So, we must never try
>> to "split" the PRD for TRM290.
>>
>> This is probably never hit anyway -- with the DMA buffers aligned to 
>> at least
>> 512 bytes and ATAPI DMA not being used for non block I/O commands...
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>   
>
>   Bart, unfortunately, drivers/ide/ide-dma-sff.c has the same mistake 
> -- you probably forgot to modify the patch splitting it from 
> ide-dma.c... :-/

   Even the one cleaning up ide_build_dmatable() actually...

MBR, Sergei


