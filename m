From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Wed, 15 Feb 2006 18:05:50 -0500
Message-ID: <43F3B3CE.5060105@pobox.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de> <43F38D49.4080601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.magma.ca ([206.191.0.250]:35716 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S1751156AbWBOXHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 18:07:14 -0500
In-Reply-To: <43F38D49.4080601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> On Thu, Feb 16 2006, Tejun Heo wrote:
>>
>>> Jens Axboe wrote:
>>>
>>>> On Wed, Feb 15 2006, Tejun Heo wrote:
>>>>
>>>>
>>>>> max_hw_sectors/max_sectors separation patch made into the tree,
>>>>> increase max_sectors to its hardware limit.
..
> Its set to 200 for a libata-related reason that I now forget :(
> 
> It had nothing to do with controllers or devices, hence the FIXME.
> 
> As an aside, I wonder if the PRD limit is unnecessarily low.  I don't 
> remember seeing anything that claimed we were limited to 256 s/g entries 
> in the old IDE docs?
> 
>     Jeff

Well, originally I wrote ide-dma.c with a 256 PRD limit,
because that corresponds to the absolute worst case of
only one sector per PRD.  The pre-LBA48 protocol cannot
read/write more than that with a single command.

But nowadays..

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
