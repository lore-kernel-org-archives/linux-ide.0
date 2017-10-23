From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH 0/2] libata: hotplug link speed
Date: Mon, 23 Oct 2017 14:38:59 -0500
Message-ID: <9ea3400c-238f-6bdb-ac50-8e9d4cd25dfe@redhat.com>
References: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
 <20171021165331.GX1302522@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751733AbdJWTjB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 23 Oct 2017 15:39:01 -0400
In-Reply-To: <20171021165331.GX1302522@devbig577.frc2.facebook.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

On 10/21/2017 11:53 AM, Tejun Heo wrote:
> Hello, David.
> 
> On Thu, Oct 19, 2017 at 01:30:34PM -0500, David Milburn wrote:
>> During hotplug, it is possible for 6Gbps link speed to
>> be limited all the way down to 1.5 Gbps which may lead
>> to a slower link speed when drive is re-connected.
>>
>> This behavior has been seen on a Intel Lewisburg SATA
>> controller (8086:a1d2) with HGST HUH728080ALE600 drive
>> where SATA link speed was limited to 1.5 Gbps and
>> when re-connected the link came up 3.0 Gbps. ata_dev_init
>> initializes link->spd to 0, but, the 0001 patch will
>> reset it once the link comes online. The 0002 patch will
>> allow the error handler to reset link->spd only if the
>> link is online; otherwise, it will always get set to 0.
>>
>> This patch set was retested on above configuration and
>> showed the hotplugged link to come back online at max
>> speed (6Gbps). I did not see the downgrade when testing
>> on Intel C600/X79, but retested patched linux-4.14-rc5
>> kernel and didn't see any side effects from these
>> changes. Also, successfully retested hotplug on port
>> multiplier 3Gbps link.
> 
> While the problem seems valid, I'm not sure the patches are in the
> right direction.  Isn't the root cause the decision we're making in
> sata_down_spd_limit() where the code is explicitly choosing 1.5Gbps if
> spd information isn't available?  It'd make more sense to make better
> decisions there rather than faking the information going into them.
> 

Ok, I will take a closer look at sata_down_spd_limit().

Thanks,
David
