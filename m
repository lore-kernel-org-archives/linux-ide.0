Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B78CC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 10:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiBBKpq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 05:45:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46454 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiBBKpp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 05:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643798745; x=1675334745;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+hI691CCzpU8nCQfgvIumZmpfrm7rMs2+QrL7/e6HrI=;
  b=WMndBsOVUIDDXWd2iF5B0HKRKcqI7lNcCib7agSyPzWOwF3mEX7uAS/H
   x9nmyJq/wm8T5VXvzhDjw4rkQBbUZS9pcx2KFEOWdPjMcKQWUUSp+U7xW
   jy0GANP4RGmIObK2Ebq1fmQ7LJpXo+u1y0XwAn0HWh/CK0leyTpPHNyJD
   nX6pOIC1OdlvHqRzUkCZPXrGCCvMOh7fVKXqVBKJ2DV+nWCrMH9nX4e7Z
   ehJUf9UkIB0ib2DpIKMSDAanbji3E+aMBNPFktbS5llNTgzsD9IjKYnsH
   YY0bKomlgn0r7MKQBsglxCpekkNH2mwi8GeEtV7nOLwOPUn3OPUtpy3jx
   A==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="296050632"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 18:45:45 +0800
IronPort-SDR: AqEidfPLMPzr5+an1j8vVDIV1RMLtt0DVQutwRlYhGN9U+D53l27HLNAwRewP3LLMSwG1PER00
 wIGvfXxfc/AJD8ZUVKGbDEqLmQJ65jIOmXI+vBfDwbyvPKz3FqRZDsAUmWcxO4JCbIzX5A9oS8
 FJP4jYI/nDustYS7Rk4d9V1ecwua4g2ViD0+5Fq754xC3wxVCJjImYURSidGifkJrKoL5Flk6N
 s14l9rLnhK4ghOg7Y+t/HBQEwfVByZ5s1/J7IqhbQeH8ZDdZ/pdmWi8+GobYxknqh5UAdRlXxd
 cg5mWrkOf+UYKCkYGBhVZlsv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:18:55 -0800
IronPort-SDR: i97QkeJhPH3bS/pMKKIHxgg9quc4gZwCR8mLw/Vy3KvinxaMZbksmdDkt68UErv5WJ7ksacADL
 jPlCN/Ar09PFs8I4xVpWO6nhurcVcgMXf3Tk+ujw6dSqHL0FCwLZG7UKi1xfkw4knkf8LJ1rfU
 eEw97bolHpDPzl0emefEhy3hsXACJOq1XRjgJdVFj7GBGgtu4gTGLWxT+/yFPSAzYtnGIiLE2m
 PAGWy42btjQK2lMQhXSH1skCKpl77VLpwLMjEe5Glbb2shmYEN4MqINHiRX4js7g1qK/fltisf
 x0w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:45:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpdkK07vTz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 02:45:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643798744; x=1646390745; bh=+hI691CCzpU8nCQfgvIumZmpfrm7rMs2+Qr
        L7/e6HrI=; b=uqOQZHHRvQLpF7y7QAqbkP7NpD+jwiPJHpwEm31/FG3oNqVA5bP
        23LvyWQHyU8v8eMBD8+nZmwW3UgB0fvO5Zv5PACzLjPMrU5Qdob4VUNANZTakcd6
        MoBnhlCIKkWI6gyy50V/0XSF6gnjFcp5x/iBd3SF5l8bl55jd3HfOG3yfWL1QzX7
        HGAiy7HruqwMFlbs50v7E/Xy/qyxns+nrhvLxwvC65R5814UwHVUnX1NcjI4Z+UT
        BYGYB07jS4MuJNXTZaZUoibOzRpCBb29onIOzBXz2E3yBOwDfx1bCVSqjV5jawx3
        Sq+bKHYq10R7sNS9KC2R31fwMHs976mFfTg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tYY_E3d7T_O0 for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 02:45:44 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpdkJ0gXxz1RvlN;
        Wed,  2 Feb 2022 02:45:43 -0800 (PST)
Message-ID: <bf9f47f1-08c4-370b-446a-1ae9efdc772a@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 19:45:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: Don't issue ATA_LOG_DIRECTORY to SATADOM-ML 3ME
Content-Language: en-US
To:     Anton Lundin <glance@acc.umu.se>, linux-ide@vger.kernel.org
References: <20220202100536.1909665-1-glance@acc.umu.se>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220202100536.1909665-1-glance@acc.umu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/2/22 19:05, Anton Lundin wrote:
> Back in 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
> a read of ATA_LOG_DIRECTORY page was added. This caused the
> SATADOM-ML 3ME to lock up.
> 
> In 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
> a flag was added to cache if a device supports this or not.
> 
> This adds a blacklist entry which flags that these devices doesn't
> support that call and shouldn't be issued that call.
> 
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Anton Lundin <glance@acc.umu.se>
> Depends-on: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")

I do not think so. See below.

> ---
>  drivers/ata/libata-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 87d36b29ca5f..e024af9f33d0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4070,6 +4070,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>  
> +	/*
> +	 * This sata dom goes on a walkabout when it sees the
> +	 * ATA_LOG_DIRECTORY read request so ensure we don't issue such a
> +	 * request to these devices.
> +	 */
> +	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_ID_DEV_LOG },

This flag only disables trying to access the identify device log page,
it does *not* avoid access to the log directory log page in general. The
log directory will still be consulted for other log pages beside the
identify device log page, from any function that calls
ata_log_supported() (e.g. ata_dev_config_ncq_send_recv() and
ata_dev_config_ncq_non_data())

So it will be a lot more solid to define a ATA_HORKAGE_NO_LOG_DIR flag
and test for it in ata_log_supported(), completely preventing any access
to the log directory page for this drive type.

> +
>  	/* End Marker */
>  	{ }
>  };

Note: if you need this fix sent to linux-stable, add "Cc: stable@..."
and a Fixes tag.

-- 
Damien Le Moal
Western Digital Research
