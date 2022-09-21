Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF32C32771
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 04:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIUEjy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 00:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiIUEj3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 00:39:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CC47D1E4
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663735157; x=1695271157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QU8NNkBAMsqxThn+jF6sCsOlO7Mv6BViePjr4RJ5x4o=;
  b=iVMo9Wz5plb88aIlE/8RU4gr9icJaLfO2U3mZiLzX4ULD+XsGHtACYF+
   FF6ZACnrBGRdsJqYS/eX3bELAP/fcy4AVxV80ZlGA6JHz4Aft7U0xqTL1
   ZunHq0WMc9pgqHiv7eSQmAdwG0v6kPVVFAP+WOmqOS2ZFYZ7lmAF4Qlh2
   yw5wBpi5S5XJWIZ74Zzdpxo3X7uXn4WWwQ/azg7eaz3ZIIm5AfgNDWVVP
   i9XwTKizcBpJhsoGF7D15ohPxIrJRg5ERy9rhJmoiGmXGGukw8qFNCEvS
   IS9/qOn7aFEkJd7zMeaSRuN3FvADYmiv3Ch3dG1rhczK0dSBbYNDCq6jb
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="217054102"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 12:39:17 +0800
IronPort-SDR: 301t8beJFHIs/bCaDQUeXE59cPsgY8UTdyse1blA8yfuv2ofcYSnb6rCERwq79ZaQCh5M+I0IW
 qZBaoo2LSdqeUs+SRUFxJMDJ6+07/lzP9HF+VKvL2vzH9456Iw9al6i0QSz1hQNHaIcrcLEPkm
 Mw4sN0XD788zEu6mqpQkrpLi7/JwIbV42QOoL3UgJzDsEMvWKlCTpEYeqc6eE5q9u/wAQk1LkN
 2CGMSE4Ilpb7pGkFP8K0YoyL9deHjB0nDqux4gWvkgSQS5vD0TWk3xrHTySRDRexnOMi9uCnqP
 qZvZMI8R56y+gFqDzdIc04Al
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 20:59:23 -0700
IronPort-SDR: qQ4/sfASNcXJR81Xk/40SDBTX4eT2jA0LWXdBuBMP6Aa1npocbbJ67boQsm9EYyHR94NzdpOV8
 cslOgGajuw4y5+Ay5kr6qWl/PlDfxC358HbqfgCMCRq1Yo8cWp+otPKcn+wYDlEPn7+UzeAzxG
 bG6RABxUkZ9m9QZdnmHG3OmlBfkfenJNevFAwQkfI61W5raBgRiCyNwLjkNzvZI9Z+vnk8vtcW
 eLedDSPQ2EmcgjmCHk0O1K5Op1CrI/sqKcDILOlBegvTsBLsP4jZRZi8jzov0KyYttI30AbgEt
 P8g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 21:39:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXQft5Hymz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 21:39:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663735158; x=1666327159; bh=QU8NNkBAMsqxThn+jF6sCsOlO7Mv6BViePj
        r4RJ5x4o=; b=eeH+5lyMTikqkmsd6I+9wY0ZnSpVeeYHqSo1iw9sLL3DhQjgQVo
        Bp1+kcuZKRTtlNZhawj4I83K8sZ4WTjMIHoPBoVT1U3hE41K9hVTx+DHhOj4CbMp
        RQu3Zfa1eBpZO2FBmfgIREpT1/a9tvgOfmhGGWXbkHGf5K0TkOEF+sLONSDC0pbJ
        t4FQiHmc+77s1fKY2WH5ZPHn0PbFDh5hwb1ihNSAHnrFOlfg4WsFojsfPo6v45io
        AA7rHHjC3LjBFRXIwn2CnqRMPIzynlExxAVi48LnblRVGDzgJc8L+nmQtxDT4FHd
        O7bP8SUmlsHP9enYqs/upomz3oMtHbfzgzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3vpNryvONseO for <linux-ide@vger.kernel.org>;
        Tue, 20 Sep 2022 21:39:18 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXQfr47gQz1RvLy;
        Tue, 20 Sep 2022 21:39:16 -0700 (PDT)
Message-ID: <a5b8d028-41a2-6a77-817b-37d9d7424594@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 13:39:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH linux-next] ata: libata-eh: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220920062929.214976-1-ye.xingchen@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220920062929.214976-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/20/22 15:29, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value ata_port_abort() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied to for-6.1. Thanks !

> ---
>   drivers/ata/libata-eh.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7c128c89b454..7dbca2a2f9ee 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1086,14 +1086,11 @@ static void __ata_port_freeze(struct ata_port *ap)
>    */
>   int ata_port_freeze(struct ata_port *ap)
>   {
> -	int nr_aborted;
> -
>   	WARN_ON(!ap->ops->error_handler);
>   
>   	__ata_port_freeze(ap);
> -	nr_aborted = ata_port_abort(ap);
>   
> -	return nr_aborted;
> +	return ata_port_abort(ap);
>   }
>   EXPORT_SYMBOL_GPL(ata_port_freeze);
>   

-- 
Damien Le Moal
Western Digital Research

