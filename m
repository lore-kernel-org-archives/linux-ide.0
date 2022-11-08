Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F1C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 08:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiKHIDu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiKHIDt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 03:03:49 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621ACC8
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 00:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667894628; x=1699430628;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=63EHEt23+0CRrmdzdCYbegWy67VSqiz4xkcwOW5N8HY=;
  b=VLl9pcXqRCNHra6dNUX25Jtoi6HiaTyP18Rl5qvOpw3fS8QfJOm+2IrK
   opvyBiVhdWKqI+UFuCzuXlkNpUV/MVXaesCcaHI1KpVyjPqcOR3Ole/HN
   Cs1Ok6VwGKwYUSfABz04xvNx6tMAHNHemdVzTo8+Tu1G8o6UquHA5ed70
   tLXLZ65ieutKaHPJcbl+4xxG8IZ2UCSYwIdpJIjJ3NIVDLUUdvNB274aH
   3R/rYztHHFJcgRulNFBwjaTnr/nY4BQc4YaANf99TFA9++B+KMl9JKMBn
   itS8bBT5rkTCxBC90t4JSsVLbdvpjoXOz52OQ/cAD0tGlKrKSkznDmGbI
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="320076237"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 16:03:47 +0800
IronPort-SDR: DupFeiNECC9UNs3/vFUANXCMqjOrgKTFHMQzMqL8UI7uqykzElaGjYVwXpG3lcTU12ORHFcSSM
 LRSWMfzB+akFgQJqJOU29ILgGw4T2wStbXlJgt1Aolc7z6dWu7HLqJCs8Klkv77rYrIcBwkKM8
 kTh3Qj/gAEcGlTFhX/I5PoaHZFBGGEBco2VovYDNH5+fuu2WmtMc8+OVyhLTr66CEwNgFft2TR
 PhdYzgUbWhkAdsxngztMfNqwWwosV1bcc3pAN/rEV7/5IcXAU/YbnYMgUXsr+OMtxv2kTJtgMI
 lzY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 23:22:53 -0800
IronPort-SDR: YTfYRUIt3tnoOGT9Otgf9M0Vg/vp1gtcKQce9r1GQ5vEi+4ILpQCt9tGsDsOWX57U2M+K1YYg9
 88DOecLSLlWvRNUH9D9fxHEeWP0ExVUXGtaCaUxklseMvyErOQrH6fx8iKqa1Hjl0OKncHaTT0
 fyloQLx5I7WUmiSt8B24HInrE6I341iC6dJkit1uJ0olegarEij1UG2htruwj1zJScrZNrNsWL
 oD9gCeqDLUyCO36zsk8pve+khd1Ekt5eh1VcUyqf1zGau42q6Yd6TffyXd8jm1XniEEoXSl0Px
 adw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 00:03:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N60wg2v0lz1RvTp
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 00:03:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667894627; x=1670486628; bh=63EHEt23+0CRrmdzdCYbegWy67VSqiz4xkc
        wOW5N8HY=; b=bP51CY4/eydlOZGiI5Jx+dHwIS6YAT77OUQ8UcPCVw8pZk/tlnj
        rXZ8uY8Nx37KW5Wf8MLTYIlmwyBKqa7sJm/SW5Aqw/26vFIUbZmRzYd6lrqHH049
        0HbcJE8sMEuUSixGwU2Uc34ZySCRG6pAePhMrQ8xHvBFhgdd1pJnUewhQeE3i/vj
        9d8QZY5y4J2tUiqPHfOVLUBheTYDNZQf7iYVhxi1FRQf1Ac2cq0MHdsR8jKOETHw
        7gSDBXYksZjpl/xl9OBimdcQMvwJ0xKT0PwNPFPcN6Hj9STaLXFrbXz2OLc+cSA+
        KeJ8k6M969RJDwhphTARef74xihBCaRvn2A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CZM_7DI2F_gO for <linux-ide@vger.kernel.org>;
        Tue,  8 Nov 2022 00:03:47 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N60wf53kFz1RvLy;
        Tue,  8 Nov 2022 00:03:46 -0800 (PST)
Message-ID: <ad7f4ad1-cded-8a09-6a7e-da6b91ee04b2@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 17:03:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 4/4] ata: libata-transport: fix error handling in
 ata_tdev_add()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221108075209.2434888-1-yangyingliang@huawei.com>
 <20221108075209.2434888-5-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221108075209.2434888-5-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/8/22 16:52, Yang Yingliang wrote:
> In ata_tdev_add(), the return value of transport_add_device() is not
> checked. As a result, another error after that function call leads to
> a kernel crash (null-ptr-deref) because transport_remove_device() is
> called to remove a device that was not added.

This was the error pattern for the previous 2 cases, but not for this
one. For this case, transport_configure_device() would be called for a
device that was not added, no ? so where does the backtrace below come
from ? It does not correspond to the code this patch is changing.

> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
> CPU: 61 PID: 13969 Comm: rmmod Kdump: loaded Tainted: G        W          6.1.0-rc3+ #13
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : device_del+0x48/0x39c
> lr : device_del+0x44/0x39c
> Call trace:
>  device_del+0x48/0x39c
>  attribute_container_class_device_del+0x28/0x40
>  transport_remove_classdev+0x60/0x7c
>  attribute_container_device_trigger+0x118/0x120
>  transport_remove_device+0x20/0x30
>  ata_tlink_delete+0x4c/0xb0 [libata]
>  ata_tport_delete+0x2c/0x60 [libata]
>  ata_port_detach+0x148/0x1b0 [libata]
>  ata_pci_remove_one+0x50/0x80 [libata]
>  ahci_remove_one+0x4c/0x8c [ahci]
> 
> Fix this by checking and handling return value of transport_add_device()
> in ata_tdev_add().
> 
> Fixes: d9027470b886 ("[libata] Add ATA transport class")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ata/libata-transport.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index aac9336e8153..e4fb9d1b9b39 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -713,7 +713,13 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>  		return error;
>  	}
>  
> -	transport_add_device(dev);
> +	error = transport_add_device(dev);
> +	if (error) {
> +		device_del(dev);
> +		ata_tdev_free(ata_dev);
> +		return error;
> +	}
> +
>  	transport_configure_device(dev);
>  	return 0;
>  }

-- 
Damien Le Moal
Western Digital Research

