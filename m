Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E8BC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 22:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhLIXB0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 18:01:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5660 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLIXB0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 18:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639090671; x=1670626671;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=pRWOIhRZ7/jth57l2EGVis1/ca2m/O9kfl+rQemxeto=;
  b=HPZlQOHeyE08KoGkS9UMeCfmmvhqhIIbhlfG9SWdBXfJJ8qpqkstbNcz
   V7CHmXZYlfPqLnCMTpmDpn+FvGICmxeEApfCKCizsea2G0TaHIx/1rz+M
   CD9mFpYEUCx2Gn6TSvnIbSICmqABn3mv7fZlFvVIRBYsxKekFBRl5FdZQ
   qUr0VvGbbgGFt+CP+9MoquiogmGrKeFVlANl39368z/feVpO0ONhwGxEv
   N/uSJ4LMm3Q5m6XIXUWNoFrVWN1sFQ3gPcaix06HUcXilhx/G249bv0uZ
   Pg9NfsudGyeYBIo7N0YkGw13Sgn6/lLW+Z0zfcIc1d2djwgtDX3A+re5s
   w==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="186865431"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:57:51 +0800
IronPort-SDR: 9x1/ZBwB3MYFy7RTMYhRY/R9Nqs3/Wp6NEVyTTmhs0327OR1Goa6lugEEB8X9MXstEe31BEsiQ
 9NRWYrr9DVrnVSofIXucyXslKqZT+yIBNn7LDZGO1mzBn25Y7XdN0UQtPCS5IRZ/MM82twUE6v
 Syel2xAuIxsI31exvefxSOWSyeUPfGSnnqrbXCtccfyF0L1M3wTGjeXdUTrTp3IB3hNpbKxVIo
 TZSgvHCVDCWMR0vo9JNanQNioiOMnS4utp0Zx7cfhuM0VeYISl8QbXU9Bdqn5WenhF7FwgulP0
 casFw1lAPavk0CzXLH1wGKyf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:30:53 -0800
IronPort-SDR: 3yfOT6S6ojWQ+qj1VAmFEwJJuPz17+fE2vQhaGKvaRJ2s1d/zRZ8rBvC4+d2wXAAJ/6yiJRt7W
 Nl1n6YXgIC8r8/oOGYZYRNVa+2AqjsD5JWD9y8ZStJEO/ZugrosXtwDCCinVxJT2V+tTLs/0k+
 jEfHp/5hgvINUVt3hinfx8c8QQM28S6FMlZ0BEg8EtDvChyDGklShgVCZpBmcqdzFW+fE4iJoh
 nTLeUfj+8vVNneyjnczOdbm0y+ygduwOpG24JI6TZUj2uNnbCg3sVD4/rECbCZG4t5a+1uhyzF
 frE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:57:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J98ZR4M4sz1Rwns
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 14:57:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639090671; x=1641682672; bh=pRWOIhRZ7/jth57l2EGVis1/ca2m/O9kfl+
        rQemxeto=; b=PcPnA2bmKfH52uxLnbvFdhq7CCy63cHtLkL2Y17GfFukik95q8s
        UxKnihjc8iTAQCA/MumcATRJUxwidbeMQP/SMTsTg29CqGfuusFo0052l+tJ/KQr
        +U/rBGzbXkewhAsBiZQmKYZuMTlDKNrp2eMW4ve56NlAApeVsJGQnru/dg8eEovy
        x9NJU8mT8T+/kwVzrMSyB0iixIwGDtxWyJ16gUNzk9C+PLPLhA1t71ZGEyv5Fzf9
        p76pluRiFTlkMyV5IQ3wvVsvo7tGNQB0Zs8q2Rk5u1ubA1hN/WyAwNXhCya9Ti3Q
        3B0h3sAU2YbxwVzoLochTZ81wopZ17TAASA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3GmNKayUxz5f for <linux-ide@vger.kernel.org>;
        Thu,  9 Dec 2021 14:57:51 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J98ZQ2L4Zz1RtVG;
        Thu,  9 Dec 2021 14:57:50 -0800 (PST)
Message-ID: <cf7b4f8b-3423-0cb3-c765-c2903a5f2e4d@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:57:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/10 7:49, Damien Le Moal wrote:
> On 2021/12/09 23:59, Andy Shevchenko wrote:
>> platform_get_irq() will print a message when it fails.
>> No need to repeat this.
>>
>> While at it, drop redundant check for 0 as platform_get_irq() spills
>> out a big WARN() in such case.
> 
> The reason you should be able to remove the "if (!irq)" test is that
> platform_get_irq() never returns 0. At least, that is what the function kdoc
> says. But looking at platform_get_irq_optional(), which is called by
> platform_get_irq(), the out label is:
> 
> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> 	return ret;
> 
> So 0 will be returned as-is. That is rather weird. That should be fixed to
> return -ENXIO:
> 
> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> 		return -ENXIO;
> 	return ret;
> 
> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?

Replying to myself :)
I replied before reading Sergei replies that points this out.

> 
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/ata/libahci_platform.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 0910441321f7..1af642c84e7b 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -579,13 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>  	int i, irq, n_ports, rc;
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0) {
>> -		if (irq != -EPROBE_DEFER)
>> -			dev_err(dev, "no irq\n");
>> +	if (irq < 0)
>>  		return irq;
>> -	}
>> -	if (!irq)
>> -		return -EINVAL;
>>  
>>  	hpriv->irq = irq;
>>  
> 
> 


-- 
Damien Le Moal
Western Digital Research
