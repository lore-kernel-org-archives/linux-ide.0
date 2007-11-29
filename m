From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Fri, 30 Nov 2007 03:11:16 +0900
Message-ID: <474F00C4.3010406@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468192463-git-send-email-htejun@gmail.com>	<20071129155956.4004ca89@the-village.bc.nu>	<474EEC06.70304@gmail.com> <20071129174027.7597bd4a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:46838 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126AbXK2SL0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 13:11:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2293845wah
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 10:11:25 -0800 (PST)
In-Reply-To: <20071129174027.7597bd4a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Albert Lee <albertcc@tw.ibm.com>

Alan Cox wrote:
> On Fri, 30 Nov 2007 01:42:46 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Alan Cox wrote:
>>>> * Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).
>>> Why 16 not 64K ?
>> Oops, forgot to answer here.  That would result in 16 sg entries for
>> draining which felt a bit too much. 
> 
> 16 sg entries but only one page of memory so its not a bit bump ?

The only added cpu cycle overhead is to setup sg entries and controller
DMA table accordingly which should be pretty small.  I was more worried
about reserving that many sg entries as it can affect bulk data
transfers.  I thought about appending draining sg's on left-over SGs.
ie. drain only min(nr_left_sgs, ATA_MAX_DRAIN_PAGES) pages but it ends
up dereferencing deep upto request_queue and things get a bit complex
because the way libata currently associates ata_device's with scsi_device's.

So, I thought 16k was a good trade off.  Not as comfortable as 64k tho,
I agree.  Would it be worth to add more complexity for this?

Thanks.

-- 
tejun
