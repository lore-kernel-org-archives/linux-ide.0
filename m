Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E85DC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Oct 2022 23:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJEXio (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Oct 2022 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJEXin (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2022 19:38:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EA85AA1
        for <linux-ide@vger.kernel.org>; Wed,  5 Oct 2022 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665013122; x=1696549122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r/lHLgkhhm2u5z9noISdUoAVCFjS4As6oslcwJQUah8=;
  b=Y9SN+DWOLinPmuVLfRe05Zjt/54Ksv3A4WG+jNi5qZSO55Pc1kLKOCnX
   IF2XhLMPlIceVIEUgyvi2kvDaEZNjiOI1Rn0GQuZOuFC54/xLYdRTWw4N
   HGxIA4bzqfjyfxqVwNiap/QLCUFBzgE3KxXcgxPeySEro/5PVF+35zeu/
   gEDH9IC91beCi8y5wwdb6IyhmBP7DJeXXh/HMJJguOHZlReMLAIPdOmDX
   85n/iCapN6hqYv5cBAA74n9vPuwVDjKWrbNhWZqxPuAWqpu2n2cI0jC7T
   j/1llMkyoYFBrazrHFV5P0uXrp2ck0A6snUh+tQ9Zz1ZZVNh0CZ3kbDsn
   w==;
X-IronPort-AV: E=Sophos;i="5.95,162,1661788800"; 
   d="scan'208";a="213486754"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 07:38:41 +0800
IronPort-SDR: qiEsSna0WmqtDOJ3l3KtSWLLiSyS56vsEuSZE8TSRFeVs2rJA7kjTOGiU1WVHJpTLvx9nmeCOf
 5KVfyKcd0b9G1V5Ch6JCjkPAQ8z/bqAIA1EKYkOeVlphF4r5svQ4ewk8NIfgITuRnu2SS5DWcn
 o3REhXHpDNdWSGOoN4yJLqIUEcKZGM7yLIgvSWt1X/GkqvGT5AwVlP8+iE5XycLat/8fSJY3Fd
 eGcEod+a6K2SGuDjRestjQIz2fQ0o5jiRKuVW4aWlT7/lN8cMRtRMEhu6G5VnRzkOPoogHkiKw
 7VMCBoRSCDAZbh9lOjzL3CmY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 15:58:28 -0700
IronPort-SDR: 3tgond5K1ce7JcRFn8QRFmJRrDG/qzdtc/26jnyBt2Dpf703S5CmPs3KBsL9Piqn0kpFWXHjBk
 UQsUXSyqlAz/dm/yG4rgjFKnm4C+VYauZCXNTvnhcFyV3geE+6mHxOyvQPya0MiKWRYxBrL3Ro
 ETrLzaJgoDFYhFAhARhcAS2fgmduEU/fjipDh0bQBGLSNEUqWUQJtkKZDsfyPBpTc46RjUam1F
 URJsfEMzQlRHhUj++WXz57rM2ntLryJtwxt6mFIn0UyOdnR+o1OSHOXF/NYmLtwj8nH6Ddb1CP
 scQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 16:38:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjWH51ygwz1Rwrq
        for <linux-ide@vger.kernel.org>; Wed,  5 Oct 2022 16:38:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665013120; x=1667605121; bh=r/lHLgkhhm2u5z9noISdUoAVCFjS4As6osl
        cwJQUah8=; b=CqwLeFxJMNbCnsy5/5z2OFsqVa8eN4qAtgcp9xRQ4FIDdU4Kap+
        /Ru6QQHbLhzUPXgUAkPH5axozd8Zxh5s2op7owGfzjsOaM1/FVqkepl6vu31e0/U
        V/3XaGfLTHhBVgQ93j5zIKWza1Dj9tYomJa/O/jpydNqNcPIDjeExDGd+OQNN5QZ
        gFq9gVsonWyM/jIk5mFCr6blHdAynER09wOaTMuZSL6xtVe2m3cDkaJMmBfl5MwG
        5FA+yFH3aftDONLvsJRLVkRTILuKWK/WXwnbRtGkUlxK2EzlzbJWpdClvHaFsmGX
        44ajE8YrzwW8NA5ydrF1MvCdCAZlW/FH+UQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id en2SkXB0X-e8 for <linux-ide@vger.kernel.org>;
        Wed,  5 Oct 2022 16:38:40 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjWH36m1dz1RvLy;
        Wed,  5 Oct 2022 16:38:39 -0700 (PDT)
Message-ID: <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 08:38:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/27/22 04:51, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Currently, if one wants to make use of FUA support in libata it is
> necessary to provide an explicit kernel command line parameter in order to
> enable it (for drives that report such support).
> 
> In terms of Git archaeology: FUA support was enabled by default in early
> libata versions but was disabled soon after.
> Since then there were a few attempts to enable this support by default:
> [1] (for NCQ drives only), [2] (for all drives).
> However, the second change had to be reverted after a report came of
> an incompatibility with the HDD in 2011 Mac Mini.
> 
> Enabling FUA avoids having to emulate it by issuing an extra drive cache
> flush for every request that have this flag set.
> Since FUA support is required by the ATA/ATAPI spec for any drive that
> supports LBA48 and so these days should be pretty widespread let's provide
> an ability to enable it by default in Kconfig.

This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
I do not see the need to add yet another config option.

Patch 1 looks good. I will queue it up once rc1 is out.

> 
> [1]: https://lore.kernel.org/lkml/45CFFF82.4030301@shaw.ca/
> [2]: https://lore.kernel.org/lkml/1336447443-4685-1-git-send-email-wenqing.lz@taobao.com/
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  drivers/ata/Kconfig       | 15 +++++++++++++++
>  drivers/ata/libata-core.c |  5 +++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 36833a8629980..fd39bb22963a3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -102,6 +102,21 @@ config SATA_PMP
>  	  This option adds support for SATA Port Multipliers
>  	  (the SATA version of an ethernet hub, or SAS expander).
>  
> +config ATA_FUA
> +	bool "ATA FUA support"
> +	help
> +	  Enables Forced Unit Access (FUA) support by default for drives that
> +	  have it.
> +	  Otherwise the FUA flag has to be emulated by flushing the drive cache.
> +
> +	  Regardless of this option, you can enable or disable such support at
> +	  kernel boot time by providing libata.fua=1 or libata.fua=0 kernel
> +	  command line parameter.
> +
> +	  If building a kernel for yourself, say Y.
> +	  If building a kernel for a distro that's supposed to run out of the
> +	  box on old and broken hardware say N.
> +
>  if HAS_DMA
>  
>  comment "Controllers with non-SFF native interface"
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b322006c85806..941836c4b5eda 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -127,9 +127,10 @@ int atapi_passthru16 = 1;
>  module_param(atapi_passthru16, int, 0444);
>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>  
> -int libata_fua = 0;
> +int libata_fua = IS_ENABLED(CONFIG_ATA_FUA);
>  module_param_named(fua, libata_fua, int, 0644);
> -MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
> +MODULE_PARM_DESC(fua,
> +		 "FUA support (0=off, 1=on), default " __stringify(IS_ENABLED(CONFIG_ATA_FUA)));
>  
>  static int ata_ignore_hpa;
>  module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);

-- 
Damien Le Moal
Western Digital Research

