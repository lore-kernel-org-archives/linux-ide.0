From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 3/4] ata: Fix acpi_bus_get_device() return value check
Date: Mon, 25 Nov 2013 09:34:27 +0800
Message-ID: <5292A923.6040409@huawei.com>
References: <1384939706-6292-1-git-send-email-wangyijing@huawei.com>	<1384939706-6292-4-git-send-email-wangyijing@huawei.com> <CAOS58YNk9DLx-Ps7CYSrMjsbUf68tbHvqsyYbwjWg8c8KkajEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:4038 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3KYBei (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Nov 2013 20:34:38 -0500
In-Reply-To: <CAOS58YNk9DLx-Ps7CYSrMjsbUf68tbHvqsyYbwjWg8c8KkajEw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide <linux-ide@vger.kernel.org>

On 2013/11/23 6:39, Tejun Heo wrote:
> On Wed, Nov 20, 2013 at 4:28 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Since acpi_bus_get_device() returns plain int and not acpi_status,
>> ACPI_FAILURE() should not be used for checking its return value.  Fix
>> that.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: linux-ide@vger.kernel.org
> 
> Applied to libata/for-3.13-fixes.  Thanks.

Hi Tejun,
   Sorry for disturb you, this patch has a build warning found by linux-next kbuild test.

All warnings:

   drivers/ata/libata-zpodd.c: In function 'odd_can_poweroff':
>> drivers/ata/libata-zpodd.c:91:14: warning: unused variable 'status' [-Wunused-variable]
     acpi_status status;


So I send a new patch "[PATCH v2] ata: Fix acpi_bus_get_device() return value check" to you,
can you help to update it.


Thanks!
Yijing.


