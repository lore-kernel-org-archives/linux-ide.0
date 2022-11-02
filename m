Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF6C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  2 Nov 2022 07:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKBHe5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKBHez (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2022 03:34:55 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C123BFD
        for <linux-ide@vger.kernel.org>; Wed,  2 Nov 2022 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667374494; x=1698910494;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yPykXwyTMU59mP5AsJC9wBay2Aav65+5iZnyR79/25I=;
  b=bEH2gmOWezLVHI2MEfosJ5W+MKVBG8Ta5xMJYWxnxj3i8af0MevynmnS
   rkK06UiRKtA7ooFGebB0fMptldtCy4Bi28t7liPYUVEg/lu8Xihdm/4w0
   mVRygcRe3gKUGZmCsT6mBOdMrS/pabF1XX+vlxb3Xbt+lth3fiOSK33yy
   jWxXtftgqdJjpsdE+01Ah/9GdcTayZvpXLZR0YLhQBViC51wI+w4Kj5+v
   qXHH/tkGjYRQD94vXUAMJwSfPoawqON7dHYTi032kJrA8Nc5PzzJSiKDU
   4KjRVuWTEHRR3iRGsLlPPyw5Qy0X8IwOtIOH3ivdssROTAay0+8aptXXx
   w==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="220444134"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 15:34:53 +0800
IronPort-SDR: mWTM8HTdryDICaY6e/VQ8zgMucrVL32+hBi6NDiyNAkxlDVcITo8KFq/2Uu/SDQ6E6Ks5o1bkL
 6+x4m1+YX54AaiTogFh5dgoqk4rierBsiMeBEXN8N/2RFxLke9kWxR//JT5nJGyx8d9M78/qAD
 E5ZtAF/sNC1byGW/0Wykw2a431kbIo6pp+bQrI7Ok3UGUJvRsp0BBR1cJKmjl+8BzuehX+tRx1
 0/BCap6DrbG50YvLfrM8xGBhd2aF9rmUqHHzz72gJ+eq1KjEswyZe7R2JTfykBxX313AKEBh5k
 UIa1dGuum3w/UbZuHxWwH3vE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 23:54:06 -0700
IronPort-SDR: VdAja7njdUwldni+rnhiOT4nizZ457VD55hQ0f0tINlNnZBwMmYi3l7JXvuKgw3o8hTKJrfdvX
 zhRdcvUZ6zsTkt7sw8fQ/FoSOu5D794j3TBSF1MH8qdClQiyLRFF7Qa2FLOpSaR//eT0rYj4Sy
 QgXbhTO8puBOk2vo5+O7c9FKVf3oKkl072XyLjC13dbH/uqJ36ukIazphU6q/ohKUEriUzjF5P
 y40bfTwfADUF8H+DI+duVtkGj5afFsMynqXX9g+7nIQjF3sgaHAueJWAf4UfWgX7dRDdcTCfo0
 DMc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 00:34:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2JZ461LNz1RwqL
        for <linux-ide@vger.kernel.org>; Wed,  2 Nov 2022 00:34:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667374492; x=1669966493; bh=yPykXwyTMU59mP5AsJC9wBay2Aav65+5iZn
        yR79/25I=; b=DLPw0+AtTL8KndEw8niiWlxY1Jsw8w9cqBvr67FCpGPVLgLlWSN
        bFkZp/DhSqXE/azLKdBw5uo31aWul4p3dGFLctp6OiIBEvNVAHUnJvSv3MiyJzZa
        qQaUCQ//TjENlJRbkFHyfLTPAy6eXoizAQ1dxK04B72vXaRGBUn2qyI4qu9OsTBw
        Xc17QdJQcEEgTju/NlpI2B2ab4hRDNUhFtkOiB+X8ILGB7CuJxl03eOchc2rh7A2
        xuvFdrB8H9glyz9upA4Y46Xd5aDjxPTF09/omc7j/ev/YpriM2PdgixldIATdlwZ
        xcH9FQ/VZoPV5qut3NfVGL+bGgFIXLE9Fuw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rGFWBLPKATts for <linux-ide@vger.kernel.org>;
        Wed,  2 Nov 2022 00:34:52 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2JZ33Qvzz1RvLy;
        Wed,  2 Nov 2022 00:34:51 -0700 (PDT)
Message-ID: <b229d7af-69da-8ee7-9280-de5e2110630f@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 16:34:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
Cc:     s.shtylyov@omp.ru, arnd@arndb.de, axboe@kernel.dk
References: <20221029074931.3189275-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221029074931.3189275-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/29/22 16:49, Yang Yingliang wrote:
> If devm_platform_ioremap_resource() fails, it never return
> NULL pointer, replace the check with IS_ERR().
> 
> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Applied to for-6.1-fixes. Thanks !

> ---
> The previous patch link:
> https://lore.kernel.org/lkml/15e09c18-792b-931c-11c7-5ef284490eba@huawei.com/T/#t
> ---
>  drivers/ata/pata_palmld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
> index 400e65190904..51caa2a427dd 100644
> --- a/drivers/ata/pata_palmld.c
> +++ b/drivers/ata/pata_palmld.c
> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
>  
>  	/* remap drive's physical memory address */
>  	mem = devm_platform_ioremap_resource(pdev, 0);
> -	if (!mem)
> -		return -ENOMEM;
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
>  
>  	/* request and activate power and reset GPIOs */
>  	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);

-- 
Damien Le Moal
Western Digital Research

