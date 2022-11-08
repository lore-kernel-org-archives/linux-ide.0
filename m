Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66CC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKHGlX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiKHGlW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:41:22 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348461C122
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667889681; x=1699425681;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5sIgRfX6D4Vzh5JqE+FRw95KvmDkNS1Jdh40Is1WBG8=;
  b=pWj2yZFuYNnChp5k5Zzglov5ht5gvzy+K6ib9k6JUb3rDZB0R5bL9FF/
   ajTPR16kr60F937niq45LghY9GadcXJUHu8LPDiMZQ1OMeYTUm6KGfPJM
   iJyCXltO4vyTRaxe3lnmzWNV+87FKmEurr8KmrKg6ljWGaGl+0KqmWw8n
   MW8knjQmreL9jy4ht627tI6E3NOf376NNoVyNL9sTPCkYmfypHtUtWAF+
   hb+4mkFCtgMrSXOiD4dLbSR23dcPiYFu5OoDnssgnahjzbIfS07AROVWS
   +s8a+qcLb6mP9+zGh1gy/gYVtLgK4d6ae3cSfj0RNJbMSiP0vhxqxNA35
   w==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="320070454"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:41:20 +0800
IronPort-SDR: /PF0a+CyG9Co2b0Xvb86EKjeVvzGPltqIDMT2/cwnSoxX0YF3fKRvBNAXoZqkSHVTJY3RNFFUg
 PZvaSg3Czcoogy0om6M0wUJ4VOXFSKI/uMioJqq6vXoLsYjCJ2Rv1LsBCUCIy2b46FIr2d0QOR
 t6ROEik/j72W2cAxM3Xa3gZwaFZ8n2OIYfO5pkIYjg9hwnK33Fb02mCFnM66oZzWgfQQiyhuJx
 HWKqhImzurNTqfpxB01xHx/ugtpzdrYYpEcLNpea4XXw6rKqmpTkR4vubH4xChWdT9vsBOwpJH
 d78=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:00:26 -0800
IronPort-SDR: jqxXl/DJPOZIpSNvcHLxmU604XKOVgfcdzDf7SYvu69bZKPpvayWOOELDKLj94BfD4rf4diLWb
 wWCgMMOmk6VTvfeI50OaLcLUSRlF2wHOun34OJIXwGNFHZKW6n3MOP+CAVuYX5B8yhZBn4qxou
 U1AxGBZqpfmzdv7hmMKYYlFhkrUQpoCqzoql+djYP2E6BzuUCP5WxfcjuWJxR4GbI4TSsZis2N
 NCNIqGysgecUTapj5NEcnom8XoNG0bfQ7xo1NB4Hx1spTlscbY3h1g2JxowDkhJ/t552YrsTAI
 DDY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:41:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5z5X21yhz1RvTr
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:41:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667889679; x=1670481680; bh=5sIgRfX6D4Vzh5JqE+FRw95KvmDkNS1Jdh4
        0Is1WBG8=; b=udEmP90+XrJMRZKAVOs619H6JeKdEFYKOwLkuC7i3Pp2F1edLt5
        2ApgZKdh7Sia3XCVMi0lKYNyFHYbtRV8mkMAjVKi4QaundhQZ5YeJhkR6V91kfqe
        k9oSIizohu3ET6ZMdYRaHdjD1hbfNyx8ciqi3uGazk9Ty/vFFJ1XTZq4lamYqpwi
        lSkpCZLbZ/kLZx6j1yp2Bdj0M8Q4zA3gZXfnQl311wFMGWEplDp6ZHUkoveCq9Ix
        Uodi/8ux+cBLM0aRDQsDeKKRgSmfyJLl62D9hDLiwk4WyzOgo8P1NpVjL+4NdjS5
        VhQmBcA6rQ91NGTxQVflvlpmxiYDUO7axPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O3YZ6BR7_CL5 for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:41:19 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5z5W414nz1RvLy;
        Mon,  7 Nov 2022 22:41:19 -0800 (PST)
Message-ID: <65fb64a6-d230-5d51-4610-96379b048f98@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:41:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] ata: libata-transport: fix double ata_host_put() in
 ata_tport_add()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221107084928.795538-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107084928.795538-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 17:49, Yang Yingliang wrote:
> In the error path in ata_tport_add(), the refcount of ata_host is
> already be put in ata_tport_release() after calling put_device(),
> it makes the host and ports are released earlier and the ports are
> set to null, then it leads a null-ptr-deref in ata_host_stop():

The fix looks OK, but I did not thoroughly check because the commit
message does not parse well.

Please make shorter, simpler sentences that can be easily understood
(and that will be easier to write too). Describe the call chain that
leads to the problem because you are mentioning functions that are
nowhere to be seen in ata_tport_add().

> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> CPU: 7 PID: 18671 Comm: modprobe Kdump: loaded Tainted: G            E      6.1.0-rc3+ #8
> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ata_host_stop+0x3c/0x84 [libata]
> lr : release_nodes+0x64/0xd0
> Call trace:
>  ata_host_stop+0x3c/0x84 [libata]
>  release_nodes+0x64/0xd0
>  devres_release_all+0xbc/0x1b0
>  device_unbind_cleanup+0x20/0x70
>  really_probe+0x158/0x320
>  __driver_probe_device+0x84/0x120
>  driver_probe_device+0x44/0x120
>  __driver_attach+0xb4/0x220
>  bus_for_each_dev+0x78/0xdc
>  driver_attach+0x2c/0x40
>  bus_add_driver+0x184/0x240
>  driver_register+0x80/0x13c
>  __pci_register_driver+0x4c/0x60
>  ahci_pci_driver_init+0x30/0x1000 [ahci]
> 
> Fix this by remove redundant ata_host_put() in the error path.>
> Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ata/libata-transport.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index a7e9a75410a3..105da3ec5eaa 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -317,7 +317,6 @@ int ata_tport_add(struct device *parent,
>   tport_err:
>  	transport_destroy_device(dev);
>  	put_device(dev);
> -	ata_host_put(ap->host);
>  	return error;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

