From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Thu, 16 Feb 2006 00:04:06 +0900
Message-ID: <43F342E6.9060909@gmail.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:36440 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945961AbWBOPE3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 10:04:29 -0500
Received: by pproxy.gmail.com with SMTP id s49so1540344pyc
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 07:04:28 -0800 (PST)
In-Reply-To: <20060215130725.GP4203@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Wed, Feb 15 2006, Tejun Heo wrote:
> 
>>max_hw_sectors/max_sectors separation patch made into the tree,
>>increase max_sectors to its hardware limit.
>>
>>Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>---
>>
>>Jeff, first of all, thanks for the pointer.  I have two more
>>questions.
>>
>>* I make ATA_MAX_SECTORS_LBA48 65535 (the 0000h case is supposed to be
>>  broken, right?); however, the comment says 65534.  Should it be
>>  65534?
> 
> 
> Since we never noticed any breakage on !sectors on lba28, I think we can
> safely assume that !sectors will work fine for lba48 as well. So why not
> just make it full 64k, eg 65536? ->max_hw_sectors is an unsigned int
> now, so 64k wont overflow it.
> 

Hello, Jens.

libata currently sets max_sectors to 200 (ATA_MAX_SECTORS) on lba28. 
Are you talking about IDE driver?  IDE driver seems to set max_sectors 
to 256 on probe and make it 2048 while setting up ide disk if lba48.

Hmmm... Can we really trust all the firmwares?  I just feel that some 
drive out there ought have screwed up about nsect == 00h/0000h case.

Thanks.

-- 
tejun
