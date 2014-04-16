From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Wed, 16 Apr 2014 11:28:11 -0500
Message-ID: <534EAF9B.4090506@redhat.com>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com> <20140415163309.GB30990@htj.dyndns.org> <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com> <20140415182001.GF30990@htj.dyndns.org> <20140416073919.GB2349@dhcp-26-207.brq.redhat.com> <20140416151932.GF1257@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40751 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbaDPQ2W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2014 12:28:22 -0400
In-Reply-To: <20140416151932.GF1257@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-ide@vger.kernel.org

On 04/16/2014 10:19 AM, Tejun Heo wrote:
> Hello,
>
> On Wed, Apr 16, 2014 at 09:39:19AM +0200, Alexander Gordeev wrote:
>> On Tue, Apr 15, 2014 at 02:20:01PM -0400, Tejun Heo wrote:
>>> On Tue, Apr 15, 2014 at 01:18:12PM -0500, David Milburn wrote:
>>>> This patch also solves the problem, would this better?
>>>
>>> Yes, this is a lot better.  Alexander, does this look good to you?
>>
>> Yep, apart from a minor comment below.
>> Also, we're not going to see complains on spurious interrupts, aren't we?
>
> The irq isn't even requested, it won't reach the kernel at all.
>
>>> Also, shouldn't this cc stable?
>
> Yeap, I think so.
>
>>>> -		rc = devm_request_threaded_irq(host->dev,
>>>> -			irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
>>>> -			desc, host->ports[i]);
>>>> +			rc = devm_request_threaded_irq(host->dev,
>>>> +						       irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
>>>> +						       desc, host->ports[i]);
>>
>> We could dereference 'pp->irq_desc' here and get rid of 'desc' variable.
>
> David, can you please update the patch accordingly?

Hi,

Sure, I have successfully re-tested, I will re-submit the
patch.

Thanks,
David
