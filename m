From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Tue, 16 Feb 2016 11:14:44 -0800
Message-ID: <56C37524.5090000@caviumnetworks.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org> <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
 <20160216144250.GD31343@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0078.outbound.protection.outlook.com ([207.46.100.78]:7424
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753850AbcBPTOu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Feb 2016 14:14:50 -0500
In-Reply-To: <20160216144250.GD31343@rric.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 02/16/2016 06:42 AM, Robert Richter wrote:
> On 15.02.16 13:30:41, Tejun Heo wrote:
>> On Sun, Feb 14, 2016 at 07:36:18PM -0800, Tirumalesh Chalamarla wrote:
>>> There is no need for special Driver, AHCI is sufficient for ThunderX, the
>>> file only contains this interrupt handler,
>>> is it preferable if this interrupt handler in libahci.c with others, instead
>>> of separate file?
>>
>> Yeap, just fold it in ahci.c with surrounding #ifdef guard.
>
> Yes, please use #ifdef CONFIG_CAVIUM_ERRATUM_22536 ... and add a
> kconfig entry for this to arch/arm64/Kconfig.
>
Are you sure, this is not a workaround that is based on alternative 
framework rather on pci device and vendor

do you think CONFIG_ARCH_THUNDER a good alternative?



> -Robert
>
