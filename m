Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA6C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 09:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiCRJtQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiCRJtP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 05:49:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53225C5A
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647596876; x=1679132876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/o/IiJn7rsrfijn2A5hGce8LJhCF5P0c7MlgE6Und8A=;
  b=nPBq5h+Fx4W3N3NS9B8KQYPucLfJ9LxT9JKF1taJSxc7QmNytQra+eL4
   OIpk/jbL4KEq0Hf9Ycz7/iaispbK2AkQyB/80S+mPbEyiLL0z86vjLBUZ
   26Ll4PAyi61M8W5RhbtU9rsa1oBddiyCgrLdJzAPou151X4eUoTfuTYDN
   o7R1yBl6NlzDIvPi6RvMjVx3zar8zfKkO7Tees/lrTSpGMqPIqm8I+f2R
   8n+nx1GRFU4uzsiHL2dTahN+5QW5J7CGNIZRWna0HQ6PThqoPmXR6k0zQ
   b3hbP9GMr8ktrOHLfkKeDUFmq6vwABPZt+EvD9AYwCTTyBYbeczsbwlQS
   A==;
X-IronPort-AV: E=Sophos;i="5.90,191,1643644800"; 
   d="scan'208";a="194604353"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2022 17:47:56 +0800
IronPort-SDR: dYqBhbYyXuQwfrA0kjNdB+U+SrxDIpTIuR/AtrU1QwignmEv/jJaACFT+jnUj4bEooZbCqeDC1
 vHjWb0RYtSTr1k7qQCXx/lBpULg3in0TXVWNYGZvIGqaW5pVcMerPtlfeqelMTczTfDPCwuYWL
 zjA8qEM5ED2mKOfEDxvHdNsT0ExG78URo3tu9q0cKujKrXZPNKEd7pQfRZoLPEW7Q7dsldMjfD
 f4iivQRl8t1ompPsLQ0whvXJNol96UiMutfIsBWjOdnngw8sgSh5F53onzBLlqlVhFiZSyXRYt
 VUSJ3EhDWFX9xXJjvhGNICIM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:19:00 -0700
IronPort-SDR: vu5zo4KvtQ/u7gDY+edG9wNvJ6i6KyKHKKsp4I/kPNJtylteYoltJdVdHm0IaOTZ0JjFTQ4jz9
 n6Ej744Qy2Eko9EcXlLxIxPtztfLyKpf3anjePITnZ7dphwmPfdrMe+jAnXgPnNeloJRaqd1fv
 FjYyPS4cJXgM5wicb3d4QppnBtsGO/lyf4DH4Hmw0nuJWHWdpSczNDWyOtSsBK3FiZUqRdvLGV
 lbrim8LbnchuZsyIIKH9sTojR3NXE6VqrCMoznwtoM64nkpTV8dD8tFhfiDx/hzcFcR/DDk0yA
 uEY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:47:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KKfMJ1D8Wz1SVnx
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:47:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647596875; x=1650188876; bh=/o/IiJn7rsrfijn2A5hGce8LJhCF5P0c7Ml
        gE6Und8A=; b=olq3+IZoilyf/AwjN3XYA+RIv1BZAWXF7iD2NUWC14/Lmo5s2Kh
        Ww3PwbMpOdSxLgxueuTUBAO9aW88ijEgGw4X3x509nThAw48BE2WTby2DL6t/AiC
        /GEBaIsuAHN/3+rd3/GL5nlpRDNVJuOiJyz9Y3S+EV8ka3JZeAfml2/4Vkrm03v6
        OFUA9AMfAYrTGfkTdzN6R3w97C1ZLVEKMTdTO+mEmyg8+1yLJa/OXiN5+2sU/rYM
        p4rXaKklDymGgDOCCrqsYq796GiVKCuoSyzp/V5kYooke7L+OQfQXOJOoiUSBGe5
        NFBRGHOrPuYw3V0IzgkUKbmYIN0TTuqCpaw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FSlOtouWRX_c for <linux-ide@vger.kernel.org>;
        Fri, 18 Mar 2022 02:47:55 -0700 (PDT)
Received: from [10.225.163.107] (unknown [10.225.163.107])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KKfMG4wynz1Rvlx;
        Fri, 18 Mar 2022 02:47:54 -0700 (PDT)
Message-ID: <f6202fb4-5afc-550a-bc77-698e94a9a1ac@opensource.wdc.com>
Date:   Fri, 18 Mar 2022 18:47:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
 <87d0ecd21aad4760d5889b2183ad0d21a73e55c6.1647594132.git.chunkeey@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87d0ecd21aad4760d5889b2183ad0d21a73e55c6.1647594132.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/18/22 18:03, Christian Lamparter wrote:
> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.
> 
> Initially this was discovered because it caused a crash
> with the sata_dwc_460ex controller on a WD MyBook Live DUO [1].
> 
> The reporter "ticerex" which has the unique opportunity that he
> has two Samsung 840 EVO SSD! One with the older firmware "EXT0BB0Q"
> which boots fine. But the newer/latest firmware "EXT0DB6Q" caused
> the headaches.
> 
> This failure is not limited to sata_dwc_460ex, it also happens on
> ahci controllers (Asmedia) as found in this forum unraid thread [2].
> (This was with a "Samsung SSD 840 EVO 120GB" with firmware "EXT0BB6Q")
> 
> [1] <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/11>
> [2] <https://forums.unraid.net/topic/77007-disks-not-showing-up/#comment-711295>
> 
> Cc: <stable@kernel.org> # 5.10+
> Reported-by: ticerex (OpenWrt Forum)

Let's drop this. You mentioned the reporter in the commit message, that is
good enough and there is the forum link for reference.

> Link: https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> "Please use my forum nick."
> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
> 
> The other patch in this series addresses the drivers crash.
> 
> Note: This "READ LOG DMA EXT failed" also happens on the newer
> Samsung 870 EVOs too:
> <https://bugzilla.kernel.org/show_bug.cgi?id=201693#c29>.
> I guess there needs to be a database maybe based on the firmware
> revision? For now I've settled with the "840 EVO" since I have
> found a old, but updated Samsung 840 EVO 120GB in my spare-parts
> box that I can test with.

If we go down to the FW revision, the blacklist size could get very big
very quickly... The difference between READ LOG DMA EXT and READ LOG EXT
is negligible anyway and that is not the hot path. So no worries.

> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0c854aebfe0b..760c0d81d148 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4014,6 +4014,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_NO_DMA_LOG |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |


-- 
Damien Le Moal
Western Digital Research
