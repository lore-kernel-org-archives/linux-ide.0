Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32234C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 19 Jul 2022 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiGSLpY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGSLpX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2022 07:45:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0EA469
        for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2022 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658231118; x=1689767118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ayIxYn79wG+BaJKMtTs4er3tTLYBaFMvwckWu9TW1RM=;
  b=PV32tyXgbab2VwXOPNSxHA8C/KgK+EiAqs0Zuv6eAWslv56IN5bLAdL/
   XeYaPGy6UnRNmPjnLKn5cq9yBshhfFdh9nFHMggnOinMOCu47hlmBjUoU
   SuLZBpFH3Yvq84LjOlhlPIrEQwfWgr2H1aEwLMW77sXR1WEAl0RCBI3+f
   LHBNr5IfwlWWONSL72qxdeNtW++d4nHwT2pfRwrNYBmA1As5HBOqECs/M
   A8KcY2nAgh4nnmp9dqjxQYLNjtP8y8iJbO69JWEQEQaCp4hC98TPZRzZt
   pbBae4+YWdfAC8NRlmtCYgOnOrbdprKSXK47pez9djdPUw0YNT3fzzPe0
   w==;
X-IronPort-AV: E=Sophos;i="5.92,284,1650902400"; 
   d="scan'208";a="211275066"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 19:45:18 +0800
IronPort-SDR: ALNZqcjdtRnRBOCW0YT5Tn+t4kVNwrtCYAuR1CSAySY73/Y6KxlxlQvUFpyd/iaaRlgFHCr29/
 GICpKwVr2DsPWKrFPFm9aYmRoihb6DZ/SqIi4VT4AUdV11cjoVMN2wYBkR7WEzumTrSrDmwIqg
 0kONPShhW/xm7TNxC51wcXQRgiE5KlHLzcADHaxC+BIavrhZDkb9tO/jCgGmotayzgUuWbeYK7
 60RQDqrOafFOjv/s71bSkHQOfpp3VkviJ+SqZ9koI6/nGuIpmA34OrX2NBmG7L7YPuN9ekjb+z
 +PXdhmpG9qU3Hmcy3ku4KOS6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:06:43 -0700
IronPort-SDR: 6Tk3AuFchIBh7wX5RgqqfwqlxmKcUEq1bdJaNimyxl1f5Ws6Gej3ycWQRLKqrWMxxl1Eenvpbb
 i/iQ8lavht7gJxzDZHxwHrs58j+l+zggWryIdeHyUhgf1vKbGb/kgEBYysOx6OKFfsQG97duv5
 EVzPamRPyXHnwboo4WAV66FXN52/vxRTD+RBdu4d5y7X1gKvH5/hS3Dodn6QttXEChvvjRNw3q
 fvB44gWbWxHyjXbdbexEh1VtctG6eUAQ1UbZn+GsB8MV2zK7GZ/2zrz3hslhbARlZCBEQgfe9P
 H+M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:45:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LnH7y6bZ9z1Rw4L
        for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2022 04:45:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658231118; x=1660823119; bh=ayIxYn79wG+BaJKMtTs4er3tTLYBaFMvwck
        Wu9TW1RM=; b=MT5WB/Lzoa/wrYfJcIYAOS1kNLB+NMPEj0eC9wkqcMylN7PJ6+h
        xlW0iy0dbFn+UIy/Fy6+C1fVaaTr/r+1JshXmIspfyrgr1sRxhVwr58KZ5SO14zH
        1m/k+tyNpNyetrKU6L+HpYfQ71jf2M2Ig3QWRjTdU3OtQM8FkhpOHOLEPDy2cv5a
        QpKMlKyJVF/rvGDV2334XnTTt9db5zUSALcObxyXOGYKTbSm/g77IVsaNvN67Yu2
        8+Dx2OABPJBSWgPW/5zo+aeDpR4zg+eiyDvP7tkYEiEsr6MseA0g2Co5BVfdFeUE
        OgcZAS57R8PfoMhaWEZ2h3sZpINWCfcZT6A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VtciyrNZ73Ht for <linux-ide@vger.kernel.org>;
        Tue, 19 Jul 2022 04:45:18 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LnH7y0bllz1RtVk;
        Tue, 19 Jul 2022 04:45:17 -0700 (PDT)
Message-ID: <1a659f24-b9d5-2772-920b-3dfec73d1106@opensource.wdc.com>
Date:   Tue, 19 Jul 2022 20:45:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ata:do not initialise statics to 0
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719114255.7568-1-gaoxin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220719114255.7568-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/19/22 20:42, Xin Gao wrote:
> do not initialise statics to 0
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 40e816419f48..bbb98433d160 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -119,7 +119,7 @@ static int atapi_enabled = 1;
>  module_param(atapi_enabled, int, 0444);
>  MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on [default])");
>  
> -static int atapi_dmadir = 0;
> +static int atapi_dmadir;
>  module_param(atapi_dmadir, int, 0444);
>  MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off [default], 1=on)");
>  

Is this solving any static analyzer or compiler warning ? If not, this is
not a very useful change.

-- 
Damien Le Moal
Western Digital Research
