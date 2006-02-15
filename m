From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Thu, 16 Feb 2006 00:30:02 +0900
Message-ID: <43F348FA.5070504@gmail.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:7056 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945983AbWBOPcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 10:32:07 -0500
Received: by pproxy.gmail.com with SMTP id o67so1611809pye
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 07:32:07 -0800 (PST)
In-Reply-To: <20060215151200.GW4203@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Thu, Feb 16 2006, Tejun Heo wrote:
>>
>>libata currently sets max_sectors to 200 (ATA_MAX_SECTORS) on lba28. 
>>Are you talking about IDE driver?  IDE driver seems to set max_sectors 
>>to 256 on probe and make it 2048 while setting up ide disk if lba48.
> 
> 
> Yes I mean the IDE driver. The 200 sector value in libata has always
> struck me as being extremely odd and a very bad choice. It's somewhere
> in between reasonable defaults, which isn't very nice. I'd suggest just
> making it 256 as well, unless Jeff has a reason why it's set to 200.
> 
> 
>>Hmmm... Can we really trust all the firmwares?  I just feel that some 
>>drive out there ought have screwed up about nsect == 00h/0000h case.
> 
> 
> Apparently Windows uses it, so I'd say that should pretty much guarantee
> that it will work for us. And as I mentioned, there has never been a
> case where the IDE driver value of 256 triggered a drive bug (one time
> one was suspected, it turned out to be something else though).
> 

Well, then it's Jeff's call.  Thanks for the explanation.  :-)

-- 
tejun
