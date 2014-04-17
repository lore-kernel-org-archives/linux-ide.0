From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH 1/1] ahci: Do not receive interrupts sent by dummy ports
Date: Thu, 17 Apr 2014 12:50:50 -0500
Message-ID: <5350147A.10403@redhat.com>
References: <cover.1397750166.git.agordeev@redhat.com> <dbaed51ffe73dec1966eba256c3b42ed22ed58f3.1397750166.git.agordeev@redhat.com> <20140417170641.GR15326@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbaDQRvM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2014 13:51:12 -0400
In-Reply-To: <20140417170641.GR15326@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 04/17/2014 12:06 PM, Tejun Heo wrote:
> On Thu, Apr 17, 2014 at 06:06:15PM +0200, Alexander Gordeev wrote:
>> In multiple MSI mode all AHCI ports (including dummy) get
>> assigned separate MSI vectors and (as result of execution
>> pci_enable_msi_exact() function) separate IRQ numbers,
>> (mapped to the MSI vectors).
>>
>> Therefore, although interrupts from dummy ports are not
>> desired they are still enabled. We do not request IRQs
>> for dummy ports, but that only means we do not assign
>> AHCI-specific ISRs to corresponding IRQ numbers.
>>
>> As result, dummy port interrupts still could come and
>> traverse all the way from the PCI device to the kernel,
>> causing unnecessary overhead.
>>
>> This update disables IRQs for dummy ports and prevents
>> the described issue.
>>
>> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: David Milburn <dmilburn@redhat.com>
>> Cc: linux-ide@vger.kernel.org
>
> David, can you please test the patch?
>


Hi,

I have re-tested successfully, this patch prevents the crash
when using kdump, and I boot tested a system that boots off
ahci and has dummy ports present, no problems seen.

Thanks,
David


