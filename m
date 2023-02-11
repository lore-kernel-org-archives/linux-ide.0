Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE23C05027
	for <linux-ide@archiver.kernel.org>; Sat, 11 Feb 2023 03:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBKDLz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Feb 2023 22:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKDLy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2023 22:11:54 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44503199EF
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2023 19:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676085112; x=1707621112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jnYrIAyLiLB6n7E5Ks/+GELpUMw3KMHdn1kuZ0eLaJc=;
  b=jKLa5GuPpp6Vb9XQxHqcqQYB2BGzPoH6jK+T2QdBNbJrXTBO7Jnv8zkN
   9AWOrsKfpcpVi5/OGkD3NEK7OdFv8qiggdXFJYtJiMQGo2vgr41z63r3m
   zqsmOSQr87Mlrxi7E6ORG9oPpmuG4DUmixl0D7slBKaylljrjS2+52dft
   ker97uer+lxG2DI4wPYbaMDzyypk6c6ji32rMaAJaBYPC5fCbwUfAL+dT
   5SKHOtXQzT04r4Ta8taN94CDCDC96i/yIrYwGAowZ4uXvGbIyAx5uPlep
   K+yXJwZnRWIglfEllhHaasgZ0bYgwnUnYzGpzqbP8VoI7oHMze2Cimw68
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,287,1669046400"; 
   d="scan'208";a="222843646"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2023 11:11:50 +0800
IronPort-SDR: nxRYUNHlhwAwcalbtnZp7DMVEjSSgzwlENrzHV3rx/rTQxOUV5Vu4WfsIgp31MlmhZaIYZ7RXz
 UG7Y/6Vu1tQgTwFJtQ/J+SzOPqSGD9UstihUrYoh15G2YhmtbxUnl6oQdiWmpEY7edqUNaxrqv
 ZbblbWvjodGx2uBDJ6wJAIC3A4VoPcCLq7QT09wobfn/LfE9DHCvxFWZ13jRPR0avUDz0Uih+T
 3r/tZNq82gvpyFVG9OwdUvbAiBesnOzQxeZgxSb5/IgBQYcSy4Unk2FMANmFXw0Jyp682yQsmN
 Dqs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2023 18:29:03 -0800
IronPort-SDR: 3LjlhvQdToLSpYsarJKusSCK+8Rxfv+nkyDp8fmWnd+IxzG46Zkv8hgAnwUoGOMncbtNA+JRLI
 E8tYo1NHPr6rzeG+ZEJbjomWqiUHLgzc8CzzcMGKzHYX3zfY1u0JsEO+6T7OqrdT+JcCUNgnBv
 w5W94imFIlT/Caf7Hs+bEjy5H7HYGPPNf2FASxr0ZZfAnX7D36rts6o6BANyQscXETIOzgBS9d
 P0l49ZvXEhnRHa5Wwg5zhVacHWvmr5/2q25hB6yBBn/+I8q+UdgX689sRwaWwQjcKYAdjd0nSH
 Bt8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2023 19:11:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PDFxy6Dddz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2023 19:11:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676085110; x=1678677111; bh=jnYrIAyLiLB6n7E5Ks/+GELpUMw3KMHdn1k
        uZ0eLaJc=; b=tOYgXGFU0/0Gp4yZOiZSFS84Rncdi6+ds7GQOTeh8ar5hTqjGk4
        CrG4/y0W/HYefw19wyyLOsqSsdorPLL8GnZvMeRP4LlPMsXc6cxYO872lesMCg78
        clIiTBrNO2VmBOncHF7Hfhcm+rmt9bVBWd9nbice0y0TQNzy3fP5Bhz1xbkwRkgr
        Dao0NwlIDOhZ+ydVu5WVWocMSrnMIVncmlh8M7FfQ8N54J/1oGsXXTxYqpXDNLbJ
        k6mGS2D5r0y6D/WZflNrd3N0lZxgtO9Tl+CyZHBtJViQElOqQPZtltmP7XSOGl1q
        YEscr6AJexLtOlXrBUKQxp4VGnuaiIHI+Nw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id unuQOpsHGdju for <linux-ide@vger.kernel.org>;
        Fri, 10 Feb 2023 19:11:50 -0800 (PST)
Received: from [10.225.163.108] (unknown [10.225.163.108])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PDFxx5svxz1RvLy;
        Fri, 10 Feb 2023 19:11:49 -0800 (PST)
Message-ID: <dce110de-649d-cde8-9401-346675c95263@opensource.wdc.com>
Date:   Sat, 11 Feb 2023 12:11:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung
 MZ7LH
To:     Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org
References: <20230210215151.812839-1-chutzpah@gentoo.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230210215151.812839-1-chutzpah@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/11/23 06:51, Patrick McLean wrote:
> Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
> SATA controllers:
> 
> ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
> ata1.00: failed command: SEND FPDMA QUEUED
> ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
>          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
>          0x4 (timeout)
> 
> Since this was seen previously with SSD 840 EVO drives in
> https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
> fix for these drives as the EVOs have, since they likely have very
> similar firmwares.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2ea572628b1c..c4c89d24f84c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4045,6 +4045,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM |
>  						ATA_HORKAGE_NO_NCQ_ON_ATI },
> +	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NO_NCQ_ON_ATI, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM },
>  

Looks OK, but ATA_HORKAGE_NO_NCQ_ON_ATI is for PCI vendor ID 1002h. AMD
also has vendor ID 1022h. Did you check you adapter vendor ID & tested
this patch ?

-- 
Damien Le Moal
Western Digital Research

