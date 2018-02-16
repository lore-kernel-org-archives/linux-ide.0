From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: libata: disable LPM for Crucial BX100 SSD drives
Date: Fri, 16 Feb 2018 11:34:14 +0100
Message-ID: <dce01c88-b1dc-dc9c-4073-3b407633d012@redhat.com>
References: <20180215190023.25575-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35821 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbeBPKeR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2018 05:34:17 -0500
Received: by mail-wm0-f53.google.com with SMTP id x21so2279419wmh.0
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2018 02:34:17 -0800 (PST)
In-Reply-To: <20180215190023.25575-1-kai.heng.feng@canonical.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 15-02-18 20:00, Kai-Heng Feng wrote:
> After Laptop Mode Tools starts to use min_power for LPM, a user found
> out Crucial BX100 SSD can't get mounted.
> 
> Crucial BX100 SSD drives don't work well with min_power. This also
> happens to med_power_with_dipm.
> 
> So let's disable LPM for Crucial BX100 SSD drives.

First of all thank you for your patch for this.

Compared to a similar patch which I just submitted for MX100 device
2 things stand out:

1) The entry my patch adds needed to be above the queued TRIM
entries because there is a more generic entry matching the SSD
below, it might be good to group all entries together there.

2) Your reporter has a 500GB model and as mentioned in my
patch I've noticed that all reporters (there are multiple
for my model) all have the 500GB version, so I think we should
restrict this to the 500GB version for now ?

I also noticed that your reporter reports a firmware
version of "MU02" and so does mine, where as the
"queued TRIM" blacklist entries all check for a version
of "MU01", could it be that the non 500GB and 500GB
versions have different firmware ?  What about the queued
trim quirks, do we maybe also need that for the MU02 version?

Regards,

Hans



> 
> BugLink: https://bugs.launchpad.net/bugs/1726930
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/ata/libata-core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3c09122bf038..577cf820eed4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4592,6 +4592,14 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>   	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>   
> +	/*
> +	 * Crucial BX100 SSD has broken min_power and med_power_with_dipm
> +	 * support.
> +	 *
> +	 * https://bugs.launchpad.net/bugs/1726930
> +	 */
> +	{ "CT*BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
> +
>   	/* End Marker */
>   	{ }
>   };
> 
