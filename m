Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D1C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiKHGta (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiKHGt3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:49:29 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388011A21F
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667890169; x=1699426169;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uH0tcjooA46M1dYXuhsU3iAJe8ZbdbEcpebVm2tbe7I=;
  b=KCWoXBQ4KCAcTrlHuEG/ziuONtyZISM2QriqAdaCLErg5+mMm1fGJdSg
   k9Rmf1V3z/zbymGtJHkd/2ua20e4f7AJyn9VnxOzyru8amVgy3utGj3As
   wz84faUP7V3XLWbrBuxEVTyKLiQHcptSQk2/4j/naWZlPVLY2VEe99jbG
   GbZSoVUd4hspotzHumML4MPXmr27iVTsZdShbyXfobUhIMuy3QDchgYvN
   vrBMriX5HfhgRJI0GObdmuXDROkzZ/FSm3CfJF7VU8OFfSc4jsTD2e1oc
   ksqT3d3mXZ+LS2IpnHrghsZhwyBNcyxZh0VTLmf/J1LU79V84FHbEVleG
   g==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="327834849"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:49:28 +0800
IronPort-SDR: O5k49qi2vvJKbYvRhEdKRZ36p6d1STg5OefMU/OTK4BXjNd0sbyJF0hr4QekdNRsfCSuwLwxRg
 pbAGFYlfqYNLeJaZc63EvzF3h7tpL4Wuqd/NInHmLiqmKgEKQc47f1IpUxvId1C1WViAhDEgQe
 ijo6wvEjOA5Q6oaMo6QqCLaqjxR7PqENU7NlXHZxoC9dP6bolgbJk9MOeNyKrtGn4cu4MvGiZ2
 /KSHLwT4LjtEGWIJLE638o4K0m1xjxS56o5fHLoyJYFHqQ/a1NffdDhqFe0lG2y6dTqMMnYfgL
 j6g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:02:50 -0800
IronPort-SDR: yuIiyppELtuC3tg9wttSo1xXvCxLcD6XFR7olR3aq/LzqOpXFI7tfdlm9axo5uT20mxvdNO18D
 xfw1HyEssPaPB5Pd90QfmBBOjfg44pQY4TY1bLt5ID54Co0RigmdJDQqk1gWrbI/569CMzvfJV
 Ax4NsDuFr7c/Xlnz0xEgj+kFHzYmMYxNUyNcCuM11oJgKL7ZMjtf1JcD7Vm4vIlUOA16Fm51wt
 ZtWP3uNyfY0ciivbwML8I25OVqfTf24AqUnBvEeYj/Ma+IzkQg27oJF50hrIItR1PVKzIaTNLZ
 yJ8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:49:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5zGw4NN7z1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:49:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667890168; x=1670482169; bh=uH0tcjooA46M1dYXuhsU3iAJe8ZbdbEcpeb
        Vm2tbe7I=; b=fEWbRaNZiU/PNujjzllLPTF70/zqvtwz8RehvpSijD7Mh+V41rZ
        emDZIzvOvMi5xkdQKPxGi1TF7zxqk+5UCSMQtF+mJdPpjS98gPIubS+NJi8MSsil
        955vgny/VH6RB4Yiso43KtRCkuzZIoDIiHbBjizt+D+PfD3gaPg2GU6HucCpVHVL
        icraByvn3HrmIhA/n8u1HcY/nOB+KZP0Ie6rd8tVUxOpGg3FmtVc+rjKLtU7PC2W
        4FuhmL3EHFyZdNFL9P9jn8UbnOps4j2EVYD+H14IAH0jsxzBkU+jIbGx6aCfcM24
        LtCiO75xjQwPlA3yLHO1JlXHaHOWTKidskQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZLIDV-mM4EUo for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:49:28 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5zGv6nkfz1RvLy;
        Mon,  7 Nov 2022 22:49:27 -0800 (PST)
Message-ID: <30c09854-3203-3bbe-c4c0-e6fa88c7d873@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:49:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] ata: libata-transport: fix error handling in
 ata_tdev_add()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221107125942.143769-1-yangyingliang@huawei.com>
 <20221107125942.143769-4-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107125942.143769-4-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 21:59, Yang Yingliang wrote:
> If transport_add_device() fails in ata_tdev_add(), it's not handled,
> it will lead kernel crash because of trying to delete not added device
> in transport_remove_device() called from ata_tdev_delete().

Same comment as the first 2 patches.

The fix is OK otherwise.

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

