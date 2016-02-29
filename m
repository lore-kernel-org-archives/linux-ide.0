From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: Re: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
Date: Mon, 29 Feb 2016 14:00:00 -0800
Message-ID: <56D4BF60.8010508@caviumnetworks.com>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160229211704.GA3965@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0086.outbound.protection.outlook.com ([207.46.100.86]:59744
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750910AbcB2WAH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Feb 2016 17:00:07 -0500
In-Reply-To: <20160229211704.GA3965@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Thanks.


On 02/29/2016 01:17 PM, Tejun Heo wrote:
> On Tue, Feb 16, 2016 at 12:08:49PM -0800, tchalamarla@caviumnetworks.com wrote:
>> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>>
>> Due to Errata in ThunderX, HOST_IRQ_STAT should be
>> cleared before leaving the interrupt handler.
>> The patch attempts to satisfy the need.
>>
>> Changes from V2:
>> 	- removed newfile
>> 	- code is now under CONFIG_ARM64
>>
>> Changes from V1:
>> 	- Rebased on top of libata/for-4.6
>>          - Moved ThunderX intr handler to new file
>>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>
> Applied to libata/for-4.5-fixes w/ minor adjustments to comments.
>
> Thanks.
>
