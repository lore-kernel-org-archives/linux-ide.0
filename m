From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/14] libata: implement ATAPI per-command-type DMA horkages
Date: Fri, 30 Nov 2007 01:10:37 +0900
Message-ID: <474EE47D.4080004@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<1196346820396-git-send-email-htejun@gmail.com> <20071129160400.106d8c5b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:26652 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXK2QKt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:10:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1590036rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 08:10:48 -0800 (PST)
In-Reply-To: <20071129160400.106d8c5b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Alan Cox wrote:
> On Thu, 29 Nov 2007 23:33:36 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> ATAPI DMA is filled with mines.  Sector aligned READ transfers usually
>> work but many other commands transfer non-sector aligned or variable
>> number of bytes, and there are devices and controllers which have
>> problems dealing with such non-aligned DMA transactions.
>>
>> This patch implement ATAPI per-command-type DMA horkages and EH logic
>> to set those quickly.  This way, failures localized to certain command
>> type don't affect other operations (most importantly READs) and
>> working configuration is found quickly such that the device can be
>> used.
> 
> This I think makes sense. We want to fail rapidly when we discover DMA
> problems with ATAPI and non core commands. OTOH we want to be pretty
> resistant to randomly dropping into PIO on stuff we know works reliably.
> 
>> +	ATAPI_DMA_HORKAGE_WRITE		= (1 << 28), /* PIO for WRITEs */
>> +	ATAPI_DMA_HORKAGE_READ_CD	= (1 << 29), /* PIO for READ_CDs */
>> +	ATAPI_DMA_HORKAGE_READ_DVD_STR	= (1 << 30), /* PIO for READ DVD STR */
>> +	ATAPI_DMA_HORKAGE_MISC		= (1 << 31), /* PIO for MISC commands */
>> +
>>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>>  	    renumber */
>>  	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
> 
> What are the locking rules for ->horkage at this point ?

It's owned by EH.  Only EH sets it.

-- 
tejun
