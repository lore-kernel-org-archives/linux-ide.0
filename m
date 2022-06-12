Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D78C43334
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jun 2022 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiFLWsG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jun 2022 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiFLWrc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2022 18:47:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3EB8B
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655074051; x=1686610051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OGdjRnD87NtDO7S8ZxUcWZql4ZpvafHb7LyaVdmkKNQ=;
  b=hUYOHp1v0PBixEJ5iNqHUmDQSyC0oVtgfm07XG8wfD0nuHGXdDf8staC
   owhM+BS6aPQY1FPnt347XoLCZQFRwvYYsbnw1wOSeXHYKYwCLhB8YZbVr
   5cvN90N+ZqgtHVPZnZ/D1hqZLzPZ+2KbIb9ezgi1yc/7jVVs7+bbiAEpT
   RmIchBrMgxnRx7pW/ZiUJ/KApOP20AxBhIbVkl5ozmq+9oOFl8YEl6K0W
   mRGyql9w1eckM2SOe3SRJC3vy4vuBgUBCeX2mGd78VABD9jwMoAcE3X4p
   f45QkmROy3pAzb8QGo67zVg17t5sR3J2rvc4wsH2GizvdYirU4NcYJvSY
   w==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="307226861"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 06:47:31 +0800
IronPort-SDR: I1eP99q8/0cQU3Qj99krt25Rrjncv8T9D2KkkPkYRGEJHjO7sWsQApUZ0PA8alv9A1nDrH/M9c
 bL3Cd4L9LLS1lYTDUjIn1MH1AbymIGBhZJmhQSoADeNkS7aNJqIxcW/wVXJJoUa3hnDY8AUges
 FMqcuHNkJ328WyEK3wJZEg0OkVl549zGbEDpxx5YnHM6UdWwOXypeVkUAQqIwB+2kSrU8WIUsK
 37pLByO2FIcpPQAEtSwou6UDGp8hIFtIs1Qix0WB4pAE0diWk9rY78g+0tY9tWZeL2+EqTqYua
 TSXpLbV0xc3vGpMDYfSqXd28
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 15:10:35 -0700
IronPort-SDR: hEIUm1K4hYQliT2uN7ZfSqya8kuH3iD719VNq8/Xbw7+4FC7OPV+qPAIYISTJ0LX1iQfAp6zYh
 CkNaDm9X7ELLWWxPZd7PzhU+uVL7ZX/K9ChjrxU2uyxE6nBlxCt6ICs+ZeMTb/V5kpI6QaWrTg
 nP2RgdDIQD6X43kT3Auep0dJVxdb+HB6gjXHelipjAnRjgyhZZjkwadk6c7eQQz2nERGnvrAIW
 +CqNrL+3RJ6DajRIOJ+AoB6Oop9NlyReLGCzsLcy0vzGl1UQxe9zSJ0NwMI0QROzmK5v7rXSJA
 VHk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 15:47:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LLqb63QsSz1SVp1
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 15:47:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655074049; x=1657666050; bh=OGdjRnD87NtDO7S8ZxUcWZql4ZpvafHb7Ly
        aVdmkKNQ=; b=NFVRnf2N5IQtvvA3IU21p2UzWGLnCZueWen3OWLQWYvuvohZgHn
        dvisPzf1HSqjGPAWdc/TccsP/4+owRs0Ek86pc11BG07q0ksrSEsAz6hguq5Vn/Q
        pPvzelW8EY+apjq/TR9/LkHgVaHUUeBdCudoBA42Zzzx6F2r0+ZHrD7Fj8us8pm3
        n3weV2IaBxMi1oFlNZVEA70x9GIghgeMoP8NDwpULGjpJ+Oqv72LUu6HU9n3b0GM
        5hfrqI5Omm2lL07wnJoweAHml/JAiC3RfepTgKsO20TutROYsbh5tCwkd4iDcEZD
        LnBP9QWY5dKsDyEh7hdKpL5ZChBq8vBRJFw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RuoRDZvGvPew for <linux-ide@vger.kernel.org>;
        Sun, 12 Jun 2022 15:47:29 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LLqb431ZYz1Rvlc;
        Sun, 12 Jun 2022 15:47:28 -0700 (PDT)
Message-ID: <097b7e93-4a85-1b6a-1772-67976f834108@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 07:47:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ata: pata_pxa: handle failure of devm_ioremap()
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Li Qiong <liqiong@nfschina.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, yuzhe@nfschina.com, renyu@nfschina.com
References: <20220612073222.18974-1-liqiong@nfschina.com>
 <20220612125700.11740-1-liqiong@nfschina.com>
 <fbbed055-fa60-cdee-589b-5d8c12672e94@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fbbed055-fa60-cdee-589b-5d8c12672e94@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/13/22 03:37, Sergei Shtylyov wrote:
> On 6/12/22 3:57 PM, Li Qiong wrote:
> 
>> As the possible failure of the devm_ioremap(), the return value
>> could be NULL. Therefore it should be better to check it and
>> print error message, return '-ENOMEM' error code.

This error is very unlikely. So unless you are seeing actual problems in
the field, I do not think it is worth fixing.

>>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> ---
>> v2:
>> - add driver's name (pata_pxa) to subject.
>> ---
>>  drivers/ata/pata_pxa.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>> index 985f42c4fd70..cd1a8f37f920 100644
>> --- a/drivers/ata/pata_pxa.c
>> +++ b/drivers/ata/pata_pxa.c
>> @@ -228,6 +228,11 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>  	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
>>  						resource_size(dma_res));
> 
>    Looking again into this driver, this statement doesn't make sense: dma_res
> points to a DMA resource, calling devm_ioremap() on it is just wrong... and

Yes, having to do an ioremap of an IORESOURCE_DMA resource is rather
unusual. dmaengine_slave_config() should be doing anything that is
required for that resource.

> 'ap->ioaddr.bmdma_addr' doesn;t seem to be used anyways...

It is used in lbata-sff.c.

A much cleaner fix would be to use
devm_platform_get_and_ioremap_resource() or
devm_platform_ioremap_resource() which will also remove the call to
platform_get_resource((). But as mentioned above, unless this is fixing an
actual bug in production, I do not think this is worth it.

> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
