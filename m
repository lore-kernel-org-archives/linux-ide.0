Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3BBC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiKHGrX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiKHGrW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:47:22 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1A2C104
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667890036; x=1699426036;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KW7Hlvzfqw6YanEJ88WzZJr8Fyb+DRaRy/QtQivyBgo=;
  b=Bz3LKlENrYadZwZdbsehF5B27g8HPkIhS6eBhEQWOQHUOTwyy5RIchgC
   5lL2sP+XI3HFW3BP/ffdTCH/k62YApzqW+t7V93P2Yww5Atz5t1nWEA70
   /SkWwJ3ZSUDPG+sa6sidd8qV2sIiblocEp3MGUWNYyADFquIxYweWShNP
   tp5fdDQfRuBqK+ryjg/57ZBYbXNop+DDgxp6Q1VR8lFs+CMFmCZnN3nG1
   kZ6a9RJnodtF5PptD5vPtb7WGj4bxc2hxT7SG/E3wT4Lbob0VtucwGYBF
   XajNkpRTzGfdwqGd70tkxvlX5oKip46B6drP4qXgN1o+TjhVVrbjgM7oK
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="214017332"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:47:15 +0800
IronPort-SDR: NeqFAida6oK1bRcVTDbCf3GsKw0Lf2jpzMLIYirBRJwm7mZLKuzUIqGnBn61DIFxEOESbRrYvh
 YaWEkAZs8eraiFvK9mJt6yaXieENUzmtBcoUyVTOK2E99Kzl2djPPSN0P//gZkGoivhsyPYgwx
 vl1Q1IIRpYI3adsFgGKbNAp9VjB88LuPQ8iLSbBKi94/r3zrmSqMUazM7hLmVwyRDsPHvMP2F7
 rCzOExoCeK/TN9TahHgT/qIPPU6BC7PYpFFxaV/CrlPsttU8Oda0j4DWM5Ag4qPJHx8Ckqvlsv
 DNw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:00:37 -0800
IronPort-SDR: PvJvoL6s4fY3antWD0bzBEkizFfnz+g0QcCQSWMIM3WTZBSm2gY+vIgyZhRYzi8RlVhDQ4nC9V
 o5OZqq1k8g9/MZzh5B+BAnNxlYcjlVBIVoFav/cwSfgpJlmIdwxT+UDI5szwHj5uUZ8RwEEbsb
 5Pi2pvH7Ys3rMToJ8dA/vSr7peX2hSVl8m8i6T33mOw/VHu4sewjgDnj4a/Zf4zCX0UnTghYj5
 QQyi3pPgwFCu3Ibpf/90y5V/FLy6r1oTxSF/SDk7DbH9uZPOsjR+YzCfiDscqw8Luf6tQVrOHA
 efM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:47:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5zDM3tmpz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:47:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667890035; x=1670482036; bh=KW7Hlvzfqw6YanEJ88WzZJr8Fyb+DRaRy/Q
        tQivyBgo=; b=uoMthjfMWeN1ScP8kObtiwXOcJgsPWuIEu6KI7RwW1LwOkylGad
        IrfIBZumnOmeQB+IWMYpF3oENoBXFcz6KppUwfYk1bqLz4drye/lM/9VxqQZXZnG
        Q+RkFL4ngPUqY6GOoqenbzPUcakQ6Hr78vyUJf+8uvjHd0ZtPn9Ta0XAnS/3MtEa
        ///JDi5FC1CydaUhF0nokvjdRV0a3easgrB7uPei+p0okP2C5YCOfEMzvTPWSJK/
        /pmQSkW3DJMvRubyfdJobi8JhhWjGcAnr+xy7XiQ1rbexDaxPP151niGH3PE4UZK
        k4OU737n4EvXUzADIdAuLcZyPXeLxyuvUWw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pnxm6K453zia for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:47:15 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5zDL5zZxz1RvLy;
        Mon,  7 Nov 2022 22:47:14 -0800 (PST)
Message-ID: <9cb5dc95-0d45-58ec-0d35-237f22ec3c1f@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:47:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] ata: libata-transport: fix error handling in
 ata_tport_add()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221107125942.143769-1-yangyingliang@huawei.com>
 <20221107125942.143769-2-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107125942.143769-2-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 21:59, Yang Yingliang wrote:
> If transport_add_device() fails in ata_tport_add(), it's not handled,
> it will lead kernel crash because of trying to delete not added device
> in transport_remove_device() called from ata_tport_delete().

Simplify your sentences to make them easier to understand:

In ata_tport_add(), the return value of transport_add_device() is not
checked. As a result, another error after that function call leads to a
kernel crash (null pointer dereference) because
transport_remove_device() is called to remove a device that was not added.

Please fix this. The patch itself is OK.

> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
> CPU: 12 PID: 13605 Comm: rmmod Kdump: loaded Tainted: G        W          6.1.0-rc3+ #8
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : device_del+0x48/0x39c
> lr : device_del+0x44/0x39c
> Call trace:
>  device_del+0x48/0x39c
>  attribute_container_class_device_del+0x28/0x40
>  transport_remove_classdev+0x60/0x7c
>  attribute_container_device_trigger+0x118/0x120
>  transport_remove_device+0x20/0x30
>  ata_tport_delete+0x34/0x60 [libata]
>  ata_port_detach+0x148/0x1b0 [libata]
>  ata_pci_remove_one+0x50/0x80 [libata]
>  ahci_remove_one+0x4c/0x8c [ahci]
> 
> Fix this by checking and handling return value of transport_add_device()
> in ata_tport_add().
> 
> Fixes: d9027470b886 ("[libata] Add ATA transport class")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ata/libata-transport.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 105da3ec5eaa..ef53bdfbcbb2 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -301,7 +301,9 @@ int ata_tport_add(struct device *parent,
>  	pm_runtime_enable(dev);
>  	pm_runtime_forbid(dev);
>  
> -	transport_add_device(dev);
> +	error = transport_add_device(dev);
> +	if (error)
> +		goto tport_transport_add_err;
>  	transport_configure_device(dev);
>  
>  	error = ata_tlink_add(&ap->link);
> @@ -312,6 +314,7 @@ int ata_tport_add(struct device *parent,
>  
>   tport_link_err:
>  	transport_remove_device(dev);
> + tport_transport_add_err:
>  	device_del(dev);
>  
>   tport_err:

-- 
Damien Le Moal
Western Digital Research

