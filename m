From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 00/07] sil24: misc fixes
Date: Fri, 12 Aug 2005 09:57:09 +0900
Message-ID: <42FBF3E5.5070301@gmail.com>
References: <20050730101344.1C985988@htj.dyndns.org> <42FBA54B.8030602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:22872 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932350AbVHLA5P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 20:57:15 -0400
Received: by wproxy.gmail.com with SMTP id i2so514769wra
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 17:57:15 -0700 (PDT)
In-Reply-To: <42FBA54B.8030602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  Hello, Jeff & Carlos.
>>
>>  These patches are misc fixes suggested by Jeff for rewritten sil24
>> driver.  The follwing issues are not fixed in this patchset.  I need
>> more info to work on these.
>>
>>  * Device signature access on reset.
>>  * How to discern completion interrupts from error ones.
>>  * 64bit activation
>>  * Removal of PORT_RST in sil24_init_one().
>>
>> [ Start of patch descriptions ]
> 
> 
> Just sent review comments on this patchset.  I'll now delete it from my 
> inbox, and wait for the next iteration.
> 
>     Jeff

  Cool, I'll soon repost acked patches + some trivial patches.  Edward 
Falk is currently working on new sil24 driver and will follow with 
patches implementing missing features.

  Thanks. ;-)

-- 
tejun
