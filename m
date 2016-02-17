From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Wed, 17 Feb 2016 13:46:47 -0800
Message-ID: <56C4EA47.6010908@caviumnetworks.com>
References: <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
 <20160216144250.GD31343@rric.localdomain>
 <56C37524.5090000@caviumnetworks.com> <56C37AD3.4030407@caviumnetworks.com>
 <56C37D94.8080403@caviumnetworks.com>
 <20160216211410.GI25086@rric.localdomain>
 <56C3AD1C.2000003@caviumnetworks.com> <20160217112931.GB31970@arm.com>
 <56C4C2AE.90009@caviumnetworks.com> <20160217200029.GB4751@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0071.outbound.protection.outlook.com ([157.56.111.71]:60144
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423221AbcBQVqy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Feb 2016 16:46:54 -0500
In-Reply-To: <20160217200029.GB4751@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, David Daney <ddaney@caviumnetworks.com>
Cc: Will Deacon <will.deacon@arm.com>, stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Richter <rric@kernel.org>, linux-arm-kernel@lists.infradead.org


On 02/17/2016 12:00 PM, Tejun Heo wrote:
> Hello, David.
>
> On Wed, Feb 17, 2016 at 10:57:50AM -0800, David Daney wrote:
>> If the ahci/ata maintainers insist, we can add that.
>
> I don't mind whether it is CONFIG_ARM64 or something more specific but
> I think it's a good idea to gate it some way.
>
Already posted a V3, could you please comment on that.

Thanks,
Tirumalesh.

>> <sarcasm>
>
> If at all possible, please write plain arguments.
>
>> Should we also add some CONFIG_ variables for:
>>
>>    ahci_mcp89_apple_enable()
>>    ahci_sb600_enable_64bit()
>>    ahci_p5wdh_workaround()
>
> And I think these should be gated behind CONFIG_X86.  The lack of
> gating is historic, not intentional.
>
> Thanks.
>
