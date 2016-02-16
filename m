From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Tue, 16 Feb 2016 15:13:32 -0800
Message-ID: <56C3AD1C.2000003@caviumnetworks.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org> <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
 <20160216144250.GD31343@rric.localdomain>
 <56C37524.5090000@caviumnetworks.com> <56C37AD3.4030407@caviumnetworks.com>
 <56C37D94.8080403@caviumnetworks.com>
 <20160216211410.GI25086@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0070.outbound.protection.outlook.com ([157.56.110.70]:20384
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932484AbcBPXNj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Feb 2016 18:13:39 -0500
In-Reply-To: <20160216211410.GI25086@rric.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: David Daney <ddaney@caviumnetworks.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, stripathi@apm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 02/16/2016 01:14 PM, Robert Richter wrote:
> On 16.02.16 11:50:44, Tirumalesh Chalamarla wrote:
>>
>>
>> On 02/16/2016 11:38 AM, David Daney wrote:
>>> On 02/16/2016 11:14 AM, Tirumalesh Chalamarla wrote:
>>>>
>>>>
>>>> On 02/16/2016 06:42 AM, Robert Richter wrote:
>>>>> On 15.02.16 13:30:41, Tejun Heo wrote:
>>>>>> On Sun, Feb 14, 2016 at 07:36:18PM -0800, Tirumalesh Chalamarla wrote:
>>>>>>> There is no need for special Driver, AHCI is sufficient for
>>>>>>> ThunderX, the
>>>>>>> file only contains this interrupt handler,
>>>>>>> is it preferable if this interrupt handler in libahci.c with others,
>>>>>>> instead
>>>>>>> of separate file?
>>>>>>
>>>>>> Yeap, just fold it in ahci.c with surrounding #ifdef guard.
>>>>>
>>>>> Yes, please use #ifdef CONFIG_CAVIUM_ERRATUM_22536 ... and add a
>>>>> kconfig entry for this to arch/arm64/Kconfig.
>>>>>
>>>> Are you sure, this is not a workaround that is based on alternative
>>>> framework rather on pci device and vendor
>>>>
>>>> do you think CONFIG_ARCH_THUNDER a good alternative?
>>>
>>> No.  CONFIG_ARCH_THUNDER should be removed all together.
>>>
>>> Grouping a bunch of unrelated features under a single config variable
>>> creates a very brittle system.  What are you going to do when a new
>>> hardware revision is released?  Create CONFIG_ARCH_THUNDER2?  Which one
>>> of these two would you select if building a kernel?  It is a choice that
>>> we don't want to force users (kernel builders) to have to waste mental
>>> energy on.
>>>
>>> Instead, let's try to make things work out of the box without having to
>>> set a bunch of random config variables.
>>>
>>> If a generic arm64 kernel won't get too bloated, I would suggest just
>>> enabling the compilation of the code unconditionally (at least for
>>> arm64).  The use of the code would still be gated by the PCI version
>>> probe that is part of the patch.
>>>
>>
>> exactly, that is my initial choice with v1, and only depends on vendor and
>> device id.
>>
>> but it seems a config is needed. how about ARCH_ARM64 then?
>
> CONFIG_CAVIUM_ERRATUM_22536 is exactly that you need. It is not only
> used for core interrupts, e.g. also for gicv3 devices (and now also
> for ahci). Non-core errata (e.g. CONFIG_CAVIUM_ERRATUM_23144) are not
> enabled in the arm64 cpu errata framework (not handled in
> arch/arm64/kernel/cpu_errata.c).
>
> Thus,
>
> #ifdef CONFIG_CAVIUM_ERRATUM_22536
> 	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
> 		ahci_thunderx_init(&pdev->dev, hpriv);
> #endif
>
> is the correct enablement of the workaround by device id.
>
> And, CAVIUM_ERRATUM_* is very easy to handle, enable and document.
>
The code will only run for Thunder and AHCI, becuase its PCI.

> -Robert
>
