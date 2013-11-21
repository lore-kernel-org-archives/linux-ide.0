From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH 3/4] ata: Fix acpi_bus_get_device() return value check
Date: Thu, 21 Nov 2013 16:30:25 +0800
Message-ID: <528DC4A1.9070702@gmail.com>
References: <1384939706-6292-1-git-send-email-wangyijing@huawei.com> <1384939706-6292-4-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54225 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3KUIan (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Nov 2013 03:30:43 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so2353288pad.17
        for <linux-ide@vger.kernel.org>; Thu, 21 Nov 2013 00:30:43 -0800 (PST)
In-Reply-To: <1384939706-6292-4-git-send-email-wangyijing@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Hanjun Guo <guohanjun@huawei.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 11/20/2013 05:28 PM, Yijing Wang wrote:
> Since acpi_bus_get_device() returns plain int and not acpi_status,
> ACPI_FAILURE() should not be used for checking its return value.  Fix
> that.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org

Acked-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> ---
>  drivers/ata/libata-zpodd.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> index 68f9e32..3d9f82d 100644
> --- a/drivers/ata/libata-zpodd.c
> +++ b/drivers/ata/libata-zpodd.c
> @@ -95,8 +95,7 @@ static bool odd_can_poweroff(struct ata_device *ata_dev)
>  	if (!handle)
>  		return false;
>  
> -	status = acpi_bus_get_device(handle, &acpi_dev);
> -	if (ACPI_FAILURE(status))
> +	if (acpi_bus_get_device(handle, &acpi_dev))
>  		return false;
>  
>  	return acpi_device_can_poweroff(acpi_dev);
> 

