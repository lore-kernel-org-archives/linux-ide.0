Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC5C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 29 Mar 2022 08:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiC2IWG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiC2IWF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2022 04:22:05 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5326326EA
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2022 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648542021; x=1680078021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AYrQtlhqVh2hDSgzcQ5+Kpv4dRRHUmkrluQwNnS8EkQ=;
  b=Tdsq5u3QZ/K3W3G1tl3D7b/IMtHXFV7+YKGz10xgbenPHBYovA72AQKR
   4aYP8UPbDENUHuSvzmkGBMyW6NbYeYTaVWP0UoMA7L2LcUH+eeQPRNPck
   gLZDKB0by5HF63W3EjHZsb+u3/YEGQsfCO4373pNBcWgLQqNyZIGsMUW8
   LEVUK9e6ikseWMCpsmHkMHOWp6u6vQFoMOCVVP5l1cg/Uj1a/3OzjquOX
   pR8YmQkh25RaP8q6xXNSwXVDBK8rMdYtM4p0nSHcEoeE4a01tubHJ3TfA
   gtI2l42sjzPQ2qN/PeUcl/QYxeR2n0ZqYWSYDSobj/3F4uPmb0m/kiZZ3
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="201365918"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:20:21 +0800
IronPort-SDR: 4dKbpytwZKbgGnaKfvaI0H4Z4+A8/WOwtj8J/C1h3fYvfRB/7l+dfpqp6lh/3tCW9npjNhT5on
 gYSBPZMJROmzucCn7+nm3BxhtUf5g2cvN3mtVrtM14W5/6pHrzqEmRc5vxH6IExASguPOoEAT0
 PJ+vKxlqMS+XhNTH+QKOf5ddh+095LDxY0CwNlTfG2mVO8vELZuh22LrKryL1y8Gn8wBmsltzv
 KbNsh7xDRH4Z+d6ReHILw3/96PPrhG8O+na5jNw3IbjTsvIgpW85uu4lmCDKPgw3lR2ZewokuI
 zq3CB9W1CTz/jZ0he2S27w0Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 00:52:06 -0700
IronPort-SDR: NgGp8lo4Nyum6fGk0jIJj5i7A3dJneFLnLLYLgWkcceqFSTaAPl2yKANQwr3xbVOpb0o1S09rD
 NrmFMTc6UFYgvWPPp66WCoG/0ggNjKUeqJeDrPiQ7ecCO3h4wjQbF/tYTzjTsBSgU78FsJDW/Y
 aRKHPcwUuJF/+jYVg8F1xq//xOo7DiiPk6lceiQR6WCUHEgV3gEU/bH505kREjBaNvftYu1bel
 aFtlMoV2+t5Ygz/SzJTQpNla8oOWEZ4TUGqFImqKpw++bpwuv3oboQGUSwb44wLVOei5O4GJDd
 Bp0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:20:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KSMvB01Yxz1SVp2
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2022 01:20:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648542021; x=1651134022; bh=AYrQtlhqVh2hDSgzcQ5+Kpv4dRRHUmkrluQ
        wNnS8EkQ=; b=TEjUpXy5ecajpkRWD6i90A6dtLRMsnlF9jXHbzuHQ7Tx/gmzCAp
        4TFjIMVlXTgJzfifINZOS7fB80oYaeMmFURWcIf1QLdMde/JwNpJcrkHGT05ieUW
        SxPUB1OLqZCS9JdkcWkVRWJ+rWpyi2vDByvZBnrLKm3Pxk1dfPsDuIfNG2rSaUuM
        1E2Y79T9PMN6PgoYG3GoWfPdmi+8hnqfgxz9oOfCY8ptbDaSRiSYRyRJvK6f3Re4
        5YNe/RRGTM/8focEhVO6s6814qUqJX3lgPdEz0ooz+HMTKnc0BB1Mp3QLSsHZvGa
        7LuWtffk0yzfcwcYQt8EvGK9DDNSEcrgong==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NCAZoidF9Jtz for <linux-ide@vger.kernel.org>;
        Tue, 29 Mar 2022 01:20:21 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KSMv75G6Nz1Rvlx;
        Tue, 29 Mar 2022 01:20:19 -0700 (PDT)
Message-ID: <19912886-4032-633e-e4a7-ef47ae389ffd@opensource.wdc.com>
Date:   Tue, 29 Mar 2022 17:20:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/21] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> It's better for readability and maintainability to explicitly assign an
> error number to the variable used then as a return value from the method
> on the cleanup-on-error path. So adding new code in the method we won't
> have to think whether the overridden rc-variable is set afterward in case
> of an error. Saving one line of code doesn't worth it especially seeing
> the rest of the ahci_platform_get_resources() function errors handling
> blocks do explicitly write errno to rc.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 18296443ccba..1bd2f1686239 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	struct ahci_host_priv *hpriv;
>  	struct clk *clk;
>  	struct device_node *child;
> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> +	int i, enabled_ports = 0, rc = 0, child_nodes;

You I did say that I do not like this. Especially considering that this
function uses rc only in the case of an error return. Having it uselessly
initialized to 0 does not make sense and goes against your goal of
avoiding problems in case it is not set in an error path. returning
"ERR_PTR(0)" is the same as returning NULL, which defeats the purpose of
using ERR_PTR/PTR_ERR.

Please drop this patch.

>  	u32 mask_port_map = 0;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  
>  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
>  			     GFP_KERNEL);
> -	if (!hpriv)
> +	if (!hpriv) {
> +		rc = -ENOMEM;
>  		goto err_out;
> +	}
>  
>  	devres_add(dev, hpriv);
>  


-- 
Damien Le Moal
Western Digital Research
