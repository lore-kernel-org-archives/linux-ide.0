Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2112BC636CC
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 23:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAaXq3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaXq2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 18:46:28 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C5E599BE
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675208756; x=1706744756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/2/tPt2lOPGt+BK5mB0mLm3FeAsziHvCuFj9uXyq6js=;
  b=foLi19CUbRN9aON7ZN1QZxZmt4kGe6CqfrsK3pn+XS1vUxgYuC41z++1
   KCHhFCOtDbr69LvF7K1jMN2D5XUT6zSscQabdYKFsybqZghyV/6A44oNv
   ONXvQ21/dKy0JVoG3uzbi5op8WGRLlcoiHYvFX3NnZ79NNnJTMQpZjWKK
   JMFrEY4ZKE6NvXVRtDbgOZ+DNnEc1WAIRmQgV+Emjm7HpGTZtM4rY+F4U
   ypTL4bvWW/8EZfd2KPoi3JNpYytOyfs+zamGECatKrdvYP1Py8ty28TXP
   qY8ZzwRSC8wLr9xSv6HTZFG595A7kF2vMtqV8KrwIMR0kt7F7eCVQW2Dg
   w==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669046400"; 
   d="scan'208";a="222011966"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2023 07:45:47 +0800
IronPort-SDR: b7NNIx6XaytpzN22KG1vJ21V9sTXWgcYwzvKm6WicNkDp/lYrePMFejtA6MGGEvut12ILxHsBo
 vaqzXP5wvY68PBsKJ2EwWSpIuoaoHVMum8C2ltqT5NiOUuwGJiejmu9tcdBXSp882TYCwGw99W
 AM0vscCyKkixDOwD/7/EGV6h5NrMyLmpGAyrVbyQKVubgFP2WMZ+xEyRHgYvibhhzzfmSGCgNX
 3Fq2RjLIFNsS82AtJ0IXohD4rj1kvYtuAhCNwZOtiY3F66AjMPyP8/XsUiODRVsDqUW/uZqqTv
 ILg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 15:03:11 -0800
IronPort-SDR: MFNYRUddv9BQQrsvT3ajv0sFWSDQf5MGHd1fYqlqce7RorplqTBlFeSMJ+Zs6mZfVvtK8Er9+9
 cYYy7suRphKAzXe1gPYFYKz+1aNe2fD7BUYzrFvq+LehrVIji1lV3euKjf4x9TWWGOnnKgwIZY
 E7lflrvJQQj2nJd/hXcLbgv48Kqk8u5MLW3FzmfGFfZFOo1alBSWHCmiOas+ZFMEAjQlHIs7ut
 eQYVGNhilpjSTB0pzQ19jdngq32y66cxbVomWLzshO8rKzmEodlEIGVDzFcnN9eIfcprFExc9H
 2Fc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 15:45:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P61rq48BGz1RvTp
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 15:45:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675208746; x=1677800747; bh=/2/tPt2lOPGt+BK5mB0mLm3FeAsziHvCuFj
        9uXyq6js=; b=SjFPtlBDUTKaavmkZsHhXDgF2saakxFPzPOfEvKPZhIwiGYkY4d
        tAxvGT744W3GRyosiUpyWOrNiDvegl+iVr6In4cIc3ukb5KiM+ZfLEb1sRX5sHk8
        UfW6vbYh7lN8YqbMQwRviZ30b51E4Fa8sSZm+XfLrG3TkgQCzLn8fspPITRL1Tjt
        703GixhO8GNDUaLqLhQaPngPSyr7o/V3c5wZ2V0SXZJjoFj/h8NpVUXl8s5m3y3V
        3me1sBujNgv+UFjG40Um85SD04RTPnEFbsudJjXdi9039Zt69ogGpyYLgCGoHN6x
        MEdWEfngSyKf8VfUczz4wpncbRGToUtPenA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s4x1B1NeONWl for <linux-ide@vger.kernel.org>;
        Tue, 31 Jan 2023 15:45:46 -0800 (PST)
Received: from [10.89.81.171] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.171])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P61rn6BcPz1RvLy;
        Tue, 31 Jan 2023 15:45:45 -0800 (PST)
Message-ID: <ec536f74-00d7-1f25-e903-278809e33ed9@opensource.wdc.com>
Date:   Wed, 1 Feb 2023 08:45:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] libata: clean up some inconsistent indenting
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
 <d8d117bf-4ab1-3473-85e2-00f1b1a85cba@opensource.wdc.com>
 <d5a59ca8-1b17-9cf2-80d0-3e267e558fd5@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d5a59ca8-1b17-9cf2-80d0-3e267e558fd5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/01/31 21:33, Sergey Shtylyov wrote:
> On 1/31/23 2:26 PM, Damien Le Moal wrote:
> [...]
>>> No functional modification involved.
>>>
>>> drivers/ata/pata_serverworks.c:443 serverworks_init_one() warn: inconsistent indenting.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3905
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>> ---
>>>  drivers/ata/pata_serverworks.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
>>> index c0bc4af0d196..c6bd9e95d4e8 100644
>>> --- a/drivers/ata/pata_serverworks.c
>>> +++ b/drivers/ata/pata_serverworks.c
>>> @@ -434,10 +434,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
>>>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
>>>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
>>>  
>>> -		 /* If the returned btr is the newer revision then
>>> -		    select the right info block */
>>> -		 if (rc == 3)
>>> -		 	ppi[0] = &info[3];
>>> +		/* If the returned btr is the newer revision then select the right info block */
>>
>> Very long line. Please make that a proper multi-line comment.
> 
>    Perhaps the material of a separate patch?

Since this patch touches this comment, the fix should be correct from the start.
I do not see the point of having a different patch fixing a patch that was ideal
to start with...

> 
>> And the patch title should be:
>>
>> ata: pata_serverworks: clean up indentation
> 
>    Yes!
> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

