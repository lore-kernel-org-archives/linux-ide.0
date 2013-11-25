From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] ata: Fix acpi_bus_get_device() return value check
Date: Mon, 25 Nov 2013 10:58:00 -0500
Message-ID: <20131125155800.GB24344@htj.dyndns.org>
References: <1384939706-6292-1-git-send-email-wangyijing@huawei.com>
 <1384939706-6292-4-git-send-email-wangyijing@huawei.com>
 <CAOS58YNk9DLx-Ps7CYSrMjsbUf68tbHvqsyYbwjWg8c8KkajEw@mail.gmail.com>
 <5292A923.6040409@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60136 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab3KYQDF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Nov 2013 11:03:05 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so2877568yhz.22
        for <linux-ide@vger.kernel.org>; Mon, 25 Nov 2013 08:03:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5292A923.6040409@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

On Mon, Nov 25, 2013 at 09:34:27AM +0800, Yijing Wang wrote:
> On 2013/11/23 6:39, Tejun Heo wrote:
> > On Wed, Nov 20, 2013 at 4:28 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> >> Since acpi_bus_get_device() returns plain int and not acpi_status,
> >> ACPI_FAILURE() should not be used for checking its return value.  Fix
> >> that.
> >>
> >> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> >> Cc: Tejun Heo <tj@kernel.org>
> >> Cc: linux-ide@vger.kernel.org
> > 
> > Applied to libata/for-3.13-fixes.  Thanks.
> 
> Hi Tejun,
>    Sorry for disturb you, this patch has a build warning found by linux-next kbuild test.
> 
> All warnings:
> 
>    drivers/ata/libata-zpodd.c: In function 'odd_can_poweroff':
> >> drivers/ata/libata-zpodd.c:91:14: warning: unused variable 'status' [-Wunused-variable]
>      acpi_status status;
> 
> 
> So I send a new patch "[PATCH v2] ata: Fix acpi_bus_get_device() return value check" to you,
> can you help to update it.

I already fixed it up last week.

Thanks.

-- 
tejun
