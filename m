Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4107BC43334
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 07:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiFHHix (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiFHGr5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 02:47:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620C1CC629
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654670874; x=1686206874;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Oxi/muQk+pRRBgU5jcnCX1DnfpVY00s+HKZ+qpw9zFA=;
  b=lsfW3UdOsL7GbBI7gOog80DR7MJZR8VslR+cKhuBDiVt9HRKM2H/4xgH
   eSXjXHJ7JKLqPlYRR2UMJsbhs3bWqdWc3KNdSNRyvYyX7KuaGMGf9Q9/R
   RL5svF6pVZ8lvTW/MfzENlpfJ+nT4l8Df6SnAPjgHxiEResosYEvMEvVu
   pZYD4JFGbKgCCu3/sX3PsV3VM3LBMaRAXbpRYa04X3huZT8x7ZB2S3NbX
   tPwm5oKtCHQYSsI25gLO9mwPCXh+ZEPzwpQ/XXc1RgXR55AnJd49w29p2
   qtKcQO3DRT1eeWowWhSApxy+a+PUio+Aqc8yvSjy0HaqVgsXjZiddE5VT
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="314617004"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 14:47:53 +0800
IronPort-SDR: 4yBwoV4NnhTAqpgO/rFHfFU1/a3b4yr67Dhbb9vpoXo5sf5yccBhSDUIAG39bKJ1flIK6yrlzU
 3Rkj7t/uXPP0LQ7LYRHAqzxrTLd/dmK0eQqOBR6QoTTIu3gXyqWY2Upl/wypdix4xU138TN3v6
 uzrTVkH9yIbCcmK9OMc39mLuRmALcG3TyqAW3gghFgkDaaaaVXJEG9gP0Mh5VySOVi6Fe7IRq3
 iqwdfgZgricm6IrUIAdjQjclV+rhtJ4d7ju1WRvOgeDOYW9tOUcWeGLlOTz7TyxXASkW5xb8QX
 W0HlpzjvIDLzLB4EaqQFKG5L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:06:42 -0700
IronPort-SDR: nr8inssr8r8j/WUffYgvAZK8aEG/rd9Zf8b0Umqcb6wwIYdjJdWkfd3TD+1lAB0ucWoOz58Trh
 lkZQSJPciMoLsHvB0B6bipECJck0lsuiHbVpLNsqQBiy3aeRSMk03d1SnQHBPrTIqIu/M3hFLJ
 h8P0ZTE0S0vRwlNyCueW/gtmj50xGb3D2BxLwjJw/mL+Whw4MhTXML8wbgu1wccblgA5hFj/Kf
 6Z/NLESgUr3SgcEeb8wlawlK9/d1NiFe0tiU1CsK9BkSTJWeYQ4beawIyTFOmjEHWmW+6pAG+N
 NMw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:47:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHyTj3CDQz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:47:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654670873; x=1657262874; bh=Oxi/muQk+pRRBgU5jcnCX1DnfpVY00s+HKZ
        +qpw9zFA=; b=sm/XTiparlPcgoGZpNlpv+m/Hx7bkNiaEovlH6uI5VUfs7nUQ0x
        fIopx84ejqZ9yHKTG0kIWI+6V85jTjN9CYkq3sypuRYNK4Z6bhih4ZOcnXoK19aj
        YKPS6PaQq6X//kKLbJEkAiYqgx9QJGRUnI7lftIsXUHspsNe/LaYq4ElPwbppUEU
        6zv1BUUUpk7POT9ogkWe0P+k4hA4Mun7phbMHPiiEYPxVbWdD1P3jaOfN4HiW550
        Yu71lJJNhaAJsEsJq/4LnHxTVbyfkBWwmZSMJZ5L2z9GYsGyh95uYaZDQvYtfHZN
        oxOqDsnZVXJM5MhTOlhoW+YY4oRawdGSO6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HRdLvP51Yf-z for <linux-ide@vger.kernel.org>;
        Tue,  7 Jun 2022 23:47:53 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHyTh5JQxz1Rvlc;
        Tue,  7 Jun 2022 23:47:52 -0700 (PDT)
Message-ID: <2a523107-9838-0940-1402-3b6bdad7e1e1@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 15:47:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-core: fix sloppy typing in ata_id_n_sectors()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/14/22 05:50, Sergey Shtylyov wrote:
> The code multiplying the # of cylinders/heads/sectors in ata_id_n_sectors()
> to get a disk capacity implicitly uses the *int* type for that calculation
> and casting the result to 'u64' before returning ensues a sign extension.
> Explicitly casting the 'u16' typed multipliers to 'u32' results in avoiding
> a sign extension instruction and so in a more compact code...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-core.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -1107,11 +1107,13 @@ static u64 ata_id_n_sectors(const u16 *i
>  			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
>  	} else {
>  		if (ata_id_current_chs_valid(id))
> -			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
> -			       id[ATA_ID_CUR_SECTORS];
> +			return (u32)id[ATA_ID_CUR_CYLS] *
> +			       (u32)id[ATA_ID_CUR_HEADS] *
> +			       (u32)id[ATA_ID_CUR_SECTORS];
>  		else
> -			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
> -			       id[ATA_ID_SECTORS];
> +			return (u32)id[ATA_ID_CYLS] *
> +			       (u32)id[ATA_ID_HEADS] *
> +			       (u32)id[ATA_ID_SECTORS];
>  	}
>  }
>  

Applied to for-5.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
