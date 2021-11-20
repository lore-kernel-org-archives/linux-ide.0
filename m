Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C040C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 20 Nov 2021 06:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhKTGL1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Nov 2021 01:11:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14061 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhKTGL0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Nov 2021 01:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637388505; x=1668924505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HEd3/uHrcFEOQzwerh2/2EB6Y+yQu9KO9X0qYOqqaew=;
  b=qoMmezU/gczS0qBos0HbSL9DUbb1g1KGO8Mbn+Y9ic7ONzMQY2xyF3JH
   xKTWzrlo0FNGAFTYBGLPegKPE6+YI0giYjBS01WISWGAqfxCuy3RGPYBf
   tGlhf9ShZwWnoPCxrdM4oolIAjlrtCqmEjJp8agYJHb658JdVWQzD6SKb
   EqKp3uAj7Jjsg6Qtyc6Ir5BOJ/vOoa/t+b9fF51B5tBLgBIxoJnKYOUSh
   vY4kjZXUVpwjLy3km9UkrOoXZFChiVR7Wu3An+yGzzCNLS8wpnr4mG2Se
   JdV8FQ4M8ik+5Egqmd4UpBztFuUkyMurplMNExmNsWgvFQfILoK8SjARr
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,250,1631548800"; 
   d="scan'208";a="187173863"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2021 14:08:12 +0800
IronPort-SDR: kjkG2RcjZHptkbkT1mZuhcIqcCHc9jqBdWuDHtF/SmcBC7kgi0xejyfpnp9oRFsUbeCfSRa92h
 6/HvglhfNFiBtIYpKh+kUAz4Dvre0CtQ+flBd1JryVCEqFmKJRr6ePJWObWVOFm74fB+VfpEGL
 hlcf7QCPqjK3tyStFrca91G4ZU5pslSk4rb4/JHOzN0NgkIBvK7dQbh23pwDqRCvPimKA7dare
 pp8G7pV9iOoUUWkZEqtGIBLuvqpND+5GK6H3Dv23Lc9illIZck3fF3Jhlzz4x0qkPTcNlRUJrZ
 xULnDrrbQOjamX4/vcG9vzZC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 21:41:36 -0800
IronPort-SDR: ACi9oRRrV+8Rt+ZBGNjG+gHEArq4Fst+s1z2wRwZziV3lBH+sm53nT9jrOQBWRKRSntoslfVJr
 /OC7fhdF2nigFZh1uNvjTjoxJtQObam791OESfW5pgV9BWQBMHGWgeL/a6HgM3q3V7Ww8O6YtA
 uQztDbK+HiTMdiVCOKFvedo2askRnrqGcn5W8mnx5FXcprOLYPefCtG83GBopu7mtuGZKHwKV3
 kKM8Fs3rmuOdc7mCcmwdZUNX31QycOqc8Nrke6AaOwPIE+40xmuJO1g1h6a0RSrYu2T29On7yI
 LBE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 22:08:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hx34B6c9Wz1RtVy
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 22:08:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637388489; x=1639980490; bh=HEd3/uHrcFEOQzwerh2/2EB6Y+yQu9KO9X0
        qYOqqaew=; b=C4fCGAjKgSv+98wZhegtNQYFGIpXvA8qJvetsEKZbX9XhHlxtrG
        G/Y91GId3w/CJ3a9x5anyDLmpGzSk+hgDGfytpRhqhpMuWQHJ042Y/zKYJkfKeXF
        KqOxqE44ehwtH4k3gIufJU2BrFgTxSBsSjlbfv1L3guE6gsgmJ3n/4Qjd1Ca3oRC
        RtXmLFhSNARDQvzSZBwjwkqbOmc5dvjY+vn6fyZtCvHOf5TztAtrgbNFjvhxsvGl
        /SYmiZ/VvCCn3UvmCr5o1d/48jdsq7vHlRfNPuOUomgBQbHdS4OW25HKU8pghmE9
        Mq9zlh/jKhFMY9yLc34uDyVTxXfzqivr2Vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yH7rF7BTP9D8 for <linux-ide@vger.kernel.org>;
        Fri, 19 Nov 2021 22:08:09 -0800 (PST)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hx3476X3kz1RtVl;
        Fri, 19 Nov 2021 22:08:07 -0800 (PST)
Message-ID: <fcf2d384-ee03-298c-c1ac-5a39c0d85784@opensource.wdc.com>
Date:   Sat, 20 Nov 2021 15:08:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when
 rmmod sata_fsl
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
 <20211119041128.2436889-3-libaokun1@huawei.com>
 <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/20/21 00:43, Sergei Shtylyov wrote:
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index 30759fd1c3a2..011daac4a14e 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>>   	host_priv->ssr_base = ssr_base;
>>   	host_priv->csr_base = csr_base;
>>   
>> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
>> +	irq = platform_get_irq(ofdev, 0);
>>   	if (!irq) {
> 
> 	if (irq < 0) {
> 
>     platform_get_irq() returns negative error codes, not 0 on failure.

Sergei,

By the way, the kdoc comment for platform_get_irq() says:

"Return: non-zero IRQ number on success, negative error number on failure."

But irq	0 is valid, isn't it ? So shouldn't this be changed to something
like:

"Return: IRQ number on success, negative error number on failure."

-- 
Damien Le Moal
Western Digital Research
