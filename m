Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B733CC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKHGsV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKHGsU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:48:20 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB532655A
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667890100; x=1699426100;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uCSEMVjIKJS+P51d4jWiXsMU+4Wxl9Pvjkg4nwxU6Ys=;
  b=N9vdZjCNrtfMXKcjLR6iO+WQTvKNyfFUTxM8ssUWHT7qgd5aj7ZKShU4
   vPWUeuXM+HO8TGx8NaiTXvK4f+1WGRxo56xi1wzi28sSmDwmlzNFwDz1B
   E3NpG2YtOsq0Vxmloe2EmqIrLDiMNVC3xYRjmqUFKUtTnXI4i6ek0dqVR
   h72ZuZAdRVRlBa8w4Haao+aNgE/cveSY1T5Lm0u9T8k1cKv8D7wkqxpRd
   XqQur8YLBqvnOfVcvoc7Ub9TYQHiTCOBxowRYMsuxwyAS7oqLhjO/Y8Vq
   3BIpZjkzGvyc9+j308+XzDgzqSi2gn8zxK/wgEKxK+Wa1JFfw42zJDwbH
   w==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="327834738"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:48:20 +0800
IronPort-SDR: qdAYQ8GCSLKgYJ5jPE3fRvjtJ4vDjhvfVsXfNQ9qDhkYdfXi6DszL7rDg662hEeZKts/GiD4m4
 i40O4nqMstmUmu9/ox7GBTWVFJX8HxY+NiauY/BT3HzeBx3qeupV2YLeDpG8LSl7ADquYSNMat
 tOECrjyzF9l9RtbzSZ0+SUghWcNT11kD0FcLgrErRAhaEYaWnG3wHKPDLjVlmVHsvpaDP7/SMy
 KzJLLGslcs3UA3ymGnLd9us8mHqv8+6PYkxCro1FB3aXgwQ2hjQW3zVYpK/l9xq27Soe2qwL9Q
 WL0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:01:41 -0800
IronPort-SDR: cysRJzo56vjYjgrA5S/w15Lyckc48IW1gKUJKlhEXh10Yw4xvlaL40AKr0jI7IHNeMh2ePMr98
 /92bNuYGUISNecENF/J7LMTnMIM+lDOxVhu2HS61MadptFF0dTdWuc4JsEYCLYYUTo2ncdnVII
 PIMJLD6cwEQHyA77zRePRaUxRFBczHcHD2kJ1T/vUodfsHSifVbOjPN3H+IscOXzxEY0b/g8RO
 iflrWCs5faBpjH6fTr93rvF6GM0j/3vxDc1X2oRRgW1zzoGZdZgOFrQz8uryuWOnzEz0uP+vWJ
 3Os=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:48:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5zFb64Xpz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:48:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667890099; x=1670482100; bh=uCSEMVjIKJS+P51d4jWiXsMU+4Wxl9Pvjkg
        4nwxU6Ys=; b=uepl3AswDrTpY1RCy6no40xWemT3TGA2yuLZCbcW4n71dhTYOym
        gPfwiPqi7YaaObIyXXrg+bbgdGlxQvrs1x1suFyc7WWeep1ic6tfX+cFBq/5rXlp
        tdBkS0gZ+NbPdfl1JHvfFPVpFHgm5pFpzAlIOmdo8xjx/hWqrspfSvRFVWDe1qP+
        UxblZDXnREWt2EMMaoiD4cWyIhl49Ro+g8I5ALrNdW0qKET9x8pOcYE5l/9PewPz
        p79F9ofp5+pa+o3HEA85GOwEi35rtrErWYW2QUr9eQqwBpZjm+0444J2tRkLxC2t
        GhMTTeIpenEAuzIqLLa8p0xMEV920TbWqxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OlA77omvKHex for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:48:19 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5zFb1N2dz1RvLy;
        Mon,  7 Nov 2022 22:48:19 -0800 (PST)
Message-ID: <8b68415b-a359-8c70-f443-15a6be8296af@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:48:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] ata: libata-transport: fix error handling in
 ata_tlink_add()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221107125942.143769-1-yangyingliang@huawei.com>
 <20221107125942.143769-3-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107125942.143769-3-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 21:59, Yang Yingliang wrote:
> If transport_add_device() fails in ata_tlink_add(), it's not handled,
> it will lead kernel crash because of trying to delete not added device
> in transport_remove_device() called from ata_tlink_delete().

See my comment on patch 1 for how to make this more readable.

Other than that, the fix looks OK.

> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
> CPU: 33 PID: 13850 Comm: rmmod Kdump: loaded Tainted: G        W          6.1.0-rc3+ #12
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : device_del+0x48/0x39c
> lr : device_del+0x44/0x39c
> Call trace:
>  device_del+0x48/0x39c
>  attribute_container_class_device_del+0x28/0x40
>  transport_remove_classdev+0x60/0x7c
>  attribute_container_device_trigger+0x118/0x120
>  transport_remove_device+0x20/0x30
>  ata_tlink_delete+0x88/0xb0 [libata]
>  ata_tport_delete+0x2c/0x60 [libata]
>  ata_port_detach+0x148/0x1b0 [libata]
>  ata_pci_remove_one+0x50/0x80 [libata]
>  ahci_remove_one+0x4c/0x8c [ahci]
> 
> Fix this by checking and handling return value of transport_add_device()
> in ata_tlink_add().
> 
> Fixes: d9027470b886 ("[libata] Add ATA transport class")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ata/libata-transport.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index ef53bdfbcbb2..aac9336e8153 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -458,7 +458,9 @@ int ata_tlink_add(struct ata_link *link)
>  		goto tlink_err;
>  	}
>  
> -	transport_add_device(dev);
> +	error = transport_add_device(dev);
> +	if (error)
> +		goto tlink_transport_err;
>  	transport_configure_device(dev);
>  
>  	ata_for_each_dev(ata_dev, link, ALL) {
> @@ -473,6 +475,7 @@ int ata_tlink_add(struct ata_link *link)
>  		ata_tdev_delete(ata_dev);
>  	}
>  	transport_remove_device(dev);
> +  tlink_transport_err:
>  	device_del(dev);
>    tlink_err:
>  	transport_destroy_device(dev);

-- 
Damien Le Moal
Western Digital Research

