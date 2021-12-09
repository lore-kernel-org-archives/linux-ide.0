Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D8C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 02:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhLIC0e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 21:26:34 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3157 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLIC0e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 21:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639016581; x=1670552581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/3M1U8wFfCrZqPpZ31wETcYZ2/CS+oD7IA2iXyN90yQ=;
  b=oZAWKU6xhauw+Xbbaj0/INXCzb0wZy4kuE9i+IBouSotl+1FKmCdRDMb
   HVA5pZbSUIRDY9cbBqzciV0PPA1uDNwGsRj5SjVWlHS/r5U59pPD9TGEl
   F9JATxNcXLtGOad9/wLJ1fp5rt9lRbaH3cUfAlyB3g4It+TAQw1eZ68Oj
   uc9Q0TYyER4lqvoaLJXdp+axrLhF1wXtz0lkQrKoyZHeT4F7zfbhu+NMc
   wSExmKr18IqfPacxMGYZg3Ux9D93cYoE85LgFqX4W1ATKBrIv+9SzZGCo
   GqDjQ5FWJlXk2yMBV1eqQz8FdxS9XVnS/dB6aSibCO7/OWcnp7wScLGCR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,191,1635177600"; 
   d="scan'208";a="299643125"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 10:23:01 +0800
IronPort-SDR: m8h4iXGMNsAjmkhd7xQMFE9Na9i8hjUANzFOI2Jkbtw7Or6q/b6KIuzWi+/aEeik/VEvum0XNT
 4Kwsoru+bkHN7eSSw01T4IJvEwM0G91nlf6mk9RmeyUIcAnU965O/gUiVr0sQVfj7c2L5VsdUS
 Ob8l3mJ0uZPK55eBPFoT2PP2ZsItAC2mKkjurB69y7ZxqKIUA8t9cU42+O26ITRNbj8hSMtZv5
 10J6UHavqj+sJfCw0vzMZYtCFLTr6lFGE2Xsrb+FttpLjji/9oZJyRmg0SlJILgISUrrbh9QH5
 F154BoNcsg7Jd46xrNsHqLXj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:57:34 -0800
IronPort-SDR: aPZ7NeiP4GcFUfeqxf6zhMLyURRhQrcPamQz1S8r9ldLVPZyVHMsbXaRB/Ix1D3OZSh1uZz/Rq
 8KP+tvaAEipPcrM8948DtIcj3EZKrdpbKpl5JRj0hHElLgos2rs+prfXUdFCKUCfWLWe7EHLH/
 M4fT0Y+Z7iak3skZ1rvOyEDolfXQZFKNShYoaObO+IKD40nMuq5muh076KoDukrvWjgU2QNzZG
 zfxwgH/riIpwFqOtGsRFiBBb37cU1OAR6uwKtWqsnIM/R+is+/1w5ngtef3OnEbG+2Qcbmys5P
 fxI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:23:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8d9c5hQcz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 18:23:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639016580; x=1641608581; bh=/3M1U8wFfCrZqPpZ31wETcYZ2/CS+oD7IA2
        iXyN90yQ=; b=Bl9N4KwnwvhKq5z4cYXnamhbA9LBz66CnTr/d66oE23R4+nNv3t
        v5OdNYGD8dePHuj3AkMcA6PCK54i4xh462gBPR4mheS0ZMSwqHFy9K8L4M97RpxC
        LZHGyIfRUjt4rJVPHSBqRQaWw/MkJ2IjXjTAO+4rSI/jWQGEgDSEIQefx5/i6Kzn
        6wEKCM28IgnfOcCff1ez1Tj/HWHrjS+uypg7hBBjPehTO47kLOw5K2+XSPH8qk4i
        CwQpd49RI+7MCj3vLkto6pI0XgwWIq35c40kUxYQJYgmPsWMjjWdldk8REV4LrX8
        Fm7l6w228Qf2n/halszPo48v+bgYYqRDouw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 61J24H46hkpb for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 18:23:00 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8d9b5x72z1RtVG;
        Wed,  8 Dec 2021 18:22:59 -0800 (PST)
Message-ID: <c96c4afa-f7bd-7562-8a48-6dca585fedb5@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 11:22:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] libata: add horkage for ASMedia 1092
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211208065853.5270-1-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208065853.5270-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/08 15:58, Hannes Reinecke wrote:
> The ASMedia 1092 has a configuration mode which will present a
> dummy device; sadly the implementation falsely claims to provide
> a device with 100M which doesn't actually exist.
> So disable this device to avoid errors during boot.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9c05177e09c2..f1a2f0a4ce05 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4416,6 +4416,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },
>  	/* Odd clown on sil3726/4726 PMPs */
>  	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
> +	/* Similar story with ASMedia 1092 */
> +	{ "ASMT109x- Config",	NULL,		ATA_HORKAGE_DISABLE },
>  
>  	/* Weird ATAPI devices */
>  	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
> 

Applied to for-5.16-fixes with CC stable added.
Thanks !

-- 
Damien Le Moal
Western Digital Research
