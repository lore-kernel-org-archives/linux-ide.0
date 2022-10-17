Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A27C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 02:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJQCnM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJQCnJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 22:43:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE894685F
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665974586; x=1697510586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7p1TMFScOznFktsWCSCUifkFaarpweirabw7CA2YiUQ=;
  b=STmf7LtCvxlNxNduPm1pNlCbDy8YL6/KHPt/aMjrjxxhTA6PJlgkxShJ
   ILkgCfaADtJZg//BYWVWdk4E7LurJs4b4/E584YrjlwNtbJnBOn9XOf0Q
   3z3UkJPnH+2wqaPur1qPjg53PjpfbiyvPhkmj1FmHyxrPEoTtUrSzrHb6
   QBKLvFYYEqBPJkNfLch/irYkZfmiNKptOmuq2b+qaecUwgvsUOYzMPQzH
   BiTu0ETO8xLPXuR68H/o2WNpkhHDx7O+LgOPxizgHNiLrAouZvKB/5mDX
   Q41zoyFhTXUh+BBUFuaJ89bX5HkN3Ob8jc7jiDWZmvFAOE+UGLc0d5/gO
   w==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="214363094"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 10:43:04 +0800
IronPort-SDR: 6UZT5afvPICqI3IPA5i4hyC+FCtFpqoV5hUdtJ+8n+KpeubvcubWa3DVNJoQK/WhuoeTzmu6T5
 UN8LmOpQtBEV5ySLrd5QCiWwrzX3LyKYDBqTC032C19i3ERdtO9TBI9gbeS5ufRiQSyrS+UAkG
 cuixnaQbQqqSsfYnoJtz/kodtv/olnfopd2e5SGCe1GP5FGrm3pyT3g16YC/Vj4OIvy1tLD4Ca
 UPsG/2wImyGIx2LnX4fNGtEXb3/Di5JS1MRITDD2DgFqu3NSDdwhZfY5seC+7pp6O6bBTucYk4
 0mbEmm5M3LbNWN9R5AMHD53r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:02:37 -0700
IronPort-SDR: unJF8hzsV9enskWrZc8wHsQMev9Mi6IxRGXUgglkM5+6gH+uF+Ejf/JP21exf+0QL8a2StvVjE
 fV3g1oHzmcDQoWTEjlo5s6fu1T0JLmT7nxjBQbY6V8Fmsh/8tf2CBPWlbDszyUAylWHU4CKddG
 ClbiA768lmwQT5DC3XfLRVEI7wP5ckAhHosqh149EEJyNuSmcotQ8BmKr/dePxQX+YN4DPoir/
 6uDu5gaLFCYz2fdx9kG+dF0HWwcBnZqilAXb9UuIL/YxXG9TN+RGj5r8Rf3wXoqp/UJG11tlSe
 xq8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:43:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrLrl3ZzKz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 19:43:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665974583; x=1668566584; bh=7p1TMFScOznFktsWCSCUifkFaarpweirabw
        7CA2YiUQ=; b=q9s6mtITpeENVR1Es+hLT9EVSyoE8GVWa1lLojU1AY6YjZHprwo
        siaChWviaTVETRNhu3FoVJDauevBgKVhuSA5Jbedm0YsGYo9XksXPVmdkyE2zOvf
        7ErF1bDD4ubWVxzoClIhsCa+74XU3J9hM9nWL8FZoWC7pKVIojIimnJTNASj/lHS
        MyUN/Q+J+yf/KtJSWowBziP7eU27z/GoeAeqs5GXcxcTzhxUENB73Y35ek/VxQI7
        tIO4GufonIBnMwVVMdtiavMTv5bBaFNmPAA7BuaRk2CgealpXcJPGwSZMAkwG/Gl
        PDO7f4fJ28qMRnB4SIxNE6Ppnq8MPMNypjQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eN5YnzZVvZfH for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 19:43:03 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrLrk3Lh3z1RvLy;
        Sun, 16 Oct 2022 19:43:02 -0700 (PDT)
Message-ID: <0368fdce-436d-4a19-1fec-fdd2f3038eca@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 11:43:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/6/22 14:17, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/ata/pata_mpc52xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 6559b606736d..3ebd6522a1fd 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -731,7 +731,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
>  
>  	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
> -	if (ata_irq == NO_IRQ) {
> +	if (!ata_irq) {
>  		dev_err(&op->dev, "error mapping irq\n");
>  		return -EINVAL;
>  	}

Applied to for-6.2. Thanks !

-- 
Damien Le Moal
Western Digital Research

