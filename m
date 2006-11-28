From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix scsi_host_template in drivers
Date: Tue, 28 Nov 2006 17:50:09 +0900
Message-ID: <456BF841.5010102@gmail.com>
References: <20061122060411.GW2184@htj.dyndns.org> <456BF685.3090004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:34632 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S935691AbWK1IuP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 03:50:15 -0500
Received: by nz-out-0102.google.com with SMTP id s1so807274nze
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 00:50:15 -0800 (PST)
In-Reply-To: <456BF685.3090004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This patch fixes the followings regarding sht usage in libata drivers.
>>
>> * sht->max_sectors is overrided unconditionally in ->slave_configure.
>>   There's no reason to set it to any value.
>>
>> * Many LLDs are missing sht->slave_destroy.  The method is mandatory
>>   to support device warm unplugging (echo 1 > /sys/.../delete).
>>   Without it, libata might access released scsi device.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>
>> Another candidate for #upstream-fixes.
> 
> if you want stuff in #upstream-fixes, you have to cut the patch down to 
> its bare minimum.  the max_sectors change in this case is a cleanup.
> 
> I ACK the patch, but ask:  would you prefer to split the patch, or just 
> this into #upstream?

I'll split.

-- 
tejun
