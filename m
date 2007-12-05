From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/14] libata: kill non-sg DMA interface
Date: Wed, 05 Dec 2007 10:02:10 +0900
Message-ID: <4755F892.4050603@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468192925-git-send-email-htejun@gmail.com> <4755AB1D.3090206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:1293 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXLEBCR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:02:17 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6635279wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:02:17 -0800 (PST)
In-Reply-To: <4755AB1D.3090206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Rusty Russel <rusty@rustcorp.com.au>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> With atapi_request_sense() converted to use sg, there's no user of
>> non-sg interface.  Kill non-sg interface.
>>
>> * ATA_QCFLAG_SINGLE and ATA_QCFLAG_SG are removed.  ATA_QCFLAG_DMAMAP
>>   is used instead.  (this way no LLD change is necessary)
>>
>> * qc->buf_virt is removed.
>>
>> * ata_sg_init_one() and ata_sg_setup_one() are removed.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Rusty Russel <rusty@rustcorp.com.au>
> 
> I would move the kill-non-sg-path changes to the front of the patchset

I was trying to put SG DMA stuff together but well I'll move this one
forward.

-- 
tejun
