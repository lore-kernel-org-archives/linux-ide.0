From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] libata: sata_down_spd_limit should return if driver has
 not recorded sstatus speed
Date: Mon, 27 Nov 2017 14:54:02 -0600
Message-ID: <2e644bb8-95a4-61b7-c456-7b3e38349007@redhat.com>
References: <1510697845-58071-1-git-send-email-dmilburn@redhat.com>
 <20171127191948.GH983427@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbdK0UyD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 27 Nov 2017 15:54:03 -0500
In-Reply-To: <20171127191948.GH983427@devbig577.frc2.facebook.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

On 11/27/2017 01:19 PM, Tejun Heo wrote:
> Hello, David.
> 
> On Tue, Nov 14, 2017 at 04:17:25PM -0600, David Milburn wrote:
>> During hotplug, it is possible for 6Gbps link speed to
>> be limited all the way down to 1.5 Gbps which may lead
>> to a slower link speed when drive is re-connected.
> 
> Can you please explain the scenario with more details?

Yes, in this particular case (I had a second reporter, but,
they didn't respond to my questions), when disconnecting
the drive, the error handler limits the speed to 1.5 Gpps
by setting bit 4 of the control register. And when the drive
is reconnected the status register show a link speed of 3Gbps,
even though before hot unplug it was running a 6Gbps.

> 
>>   	/* Mask off all speeds higher than or equal to the current
>> -	 * one.  Force 1.5Gbps if current SPD is not available.
>> +	 * one. At this point if current SPD is not available and we
>> +	 * previously recorded the link speed from the Status register,
>> +	 * the driver has already masked off the highest bit so mask
>> +	 * should already be set to 1 or 0. Otherwise, we should
>> +	 * not force 1.5Gbps on a link where we have not previously
>> +	 * recorded speed from Status register, just return in this case.
>>   	 */
>>   	if (spd > 1)
>>   		mask &= (1 << (spd - 1)) - 1;
>>   	else
>> -		mask &= 1;
>> +		return -EINVAL;
> 
> I get that the current behavior might not be ideal in certain
> scenarios but the above seems weird, especially given the we have
> link->sata_spd for cases where we can't access the spd value.
> 

Yes, but link->sata_spd is initialized to 0, and the only time the
driver records "link->sata_spd" from the status register is in 
ata_eh_reset(). And on hot unplug, the driver sets the mask to 1
dropping the link from 6 to 1.5Gbps. And, if the driver doesn't
downgrade the link speed by writing to the control register, the link
comes back at 6Gbps on hot plug. It maybe particular controller/configs
behave differently since it is not always reproducible.

Thanks,
David


