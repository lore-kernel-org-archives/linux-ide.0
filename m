Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCCAC433EF
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiBGBo3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Feb 2022 20:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiBGBo2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2022 20:44:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D9C061348
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 17:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644198267; x=1675734267;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oMTM/fuwuhJDHz9RCbwz6EUHyVPWapravQoLqgxVKW4=;
  b=iPxz3tIBs6LLxpYiZ+tX2gWcoeg15VzXqjK3UdfUux9xvI3UNSdFxqHt
   OleX4wZ5vK/n9FEkhxH0TIR1aZru4HlzxuXxtMl2qswd+/MYNKYdx45bN
   sljOwFq4ysutZUk5V8dbuzH/nSLPkwSRC1eX++ljg5+87F1s7tBqcaYOr
   woEB6BFNcGkQNGQQFiQNhU1ZZ5G6JzB68S5rJIXoKldl89n4kSF6FDfdz
   qRqe1473A0qTo4YIQMqFmQsq8JT/7Ny1hHGJFbu52YO2rK87l3sn4u7YR
   C2a0tjwxKj2W5Bi4Zo9EjjHdIzekb/5ieepmQIqkA01jbUpOFr1VhF4cm
   A==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="193269684"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 09:44:17 +0800
IronPort-SDR: hh+G6RASVtObUSQKEvWoT1/Qs1L5C5vOI/ovPoACk0yN4t015z8/47oiR0DMdm/5QRjvAU6AMn
 xA9BUa0kwgJWRVVDQawiK/bYOoO2YdFtggTQSx8SX2hCVF1yLavVmWhh2gtzCq9Qj/D5HTPrl6
 4x10IZve2pcqDUnauetovTS/US/7MGMViQwaHCz27DQYrN4EEoXrmNO6nSPVjUm1QsiKaVEll4
 vW7CXdgbfV5KFolKMVC8sFRPN5ey+OuQrWKaZI8kW/kqyXGNZQUXrD5cRAbWx0QX/6qW0cwVPW
 SgOoO+GiyqwyFJn+//ZJnhH7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 17:17:19 -0800
IronPort-SDR: WNWsX2Og4K9hJqoz/mvOmPpRSjKxutuPgypk+l6BV7rvFMFUbuf5lB5Q5u9ion9e1MtX45HBCI
 BTqh+0nX9PoiJilv49gJnQoRYTZHd5Ju2PuY/4Bzr1/hlNfpPnkyiWHW/GqoiwU9NHIyHtFQ01
 O4fIopvppjRr4kzJpUU/zxkXplG7gTf7HL/LiwiuklerkFnnUIWRPX3yjOVxFsgop3DU2TmNCB
 VUeL1EyzxW61QQ1oL/A0m99nywuhaPTQ/p49abfXXQQznu1+zMEuqHXrj42TwKeDmMlBJlpy6U
 OUQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 17:44:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JsTTF1Knpz1SHwl
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 17:44:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644198256; x=1646790257; bh=oMTM/fuwuhJDHz9RCbwz6EUHyVPWapravQo
        LqgxVKW4=; b=ObWS66BDXRZMLmIfcNaYQNqLcFzH60qcuDN2DmVtvfFO7kRNWKJ
        i8CtdrvKzOuOvEI0Q6G0pD7dVUrLiH+ZiQC07WPUWD09mE/3zDfjNqua1L76zLAX
        lTX/8uTVcwRNWAlZ/XXKrBRZxf7TGiibc+WhManftXO2DOkO6Y5TW0dLbm+HbiNi
        TOwGhm7u/8ggXLnksqaHl8hgS76LXAvpoQewPPZinCbnFcgDupC6KCCYkvG/lUCW
        PaJGU2BhYcNwIoB4hzKYANLmFXV953AFrlnpHF6M1sRgMjptDrSXUpOL6y6vMqw1
        NHDXKkGn/TJlo2U1pSO2CWQ4HpstrJfkF6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P6jCjhlJeFbD for <linux-ide@vger.kernel.org>;
        Sun,  6 Feb 2022 17:44:16 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JsTTD1XVQz1Rwrw;
        Sun,  6 Feb 2022 17:44:15 -0800 (PST)
Message-ID: <d2b387c4-7929-487f-c91b-fad979d0c93f@opensource.wdc.com>
Date:   Mon, 7 Feb 2022 10:44:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] pata_artop: use *switch* in artop_init_one()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
 <20220205203434.15339-3-s.shtylyov@omp.ru>
 <d1432a8d-ac25-d37e-8de3-d60be1670d3b@opensource.wdc.com>
 <3f7a8f86-5a66-99ef-e165-60c41e33429e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3f7a8f86-5a66-99ef-e165-60c41e33429e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/6/22 19:24, Sergey Shtylyov wrote:
> On 2/6/22 4:55 AM, Damien Le Moal wrote:
> 
>>> This driver uses a string of the *if* statements in artop_init_one() where
>>> the *switch* statement would fit better...
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> ---
>>> Changes in version 4:
>>> - fixed up #define DRV_VERSION;
>>> - expanded the patch description.
>>>
>>> Changes in version 3:
>>> - fixed up the patch subject.
>>>
>>> Changes in version 2:
>>> - updated #define DRV_VERSION.
>>>
>>>  drivers/ata/pata_artop.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
>>> index b734cafb8783..d8c388da0c70 100644
>>> --- a/drivers/ata/pata_artop.c
>>> +++ b/drivers/ata/pata_artop.c
> [...]
>>> @@ -394,14 +394,18 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>>>  	if (rc)
>>>  		return rc;
>>>  
>>> -	if (id->driver_data == 0)	/* 6210 variant */
>>> +	switch (id->driver_data) {
>>> +	case 0:		/* 6210 variant */
>>>  		ppi[0] = &info_6210;
>>> -	else if (id->driver_data == 1)	/* 6260 */
>>> +		break;
>>> +	case 1:		/* 6260 */
>>>  		ppi[0] = &info_626x;
>>> -	else if (id->driver_data == 2) { /* 6280 or 6280 + fast */
>>> +		break;
>>> +	case 2:		/* 6280 or 6280 + fast */
>>>  		ppi[0] = &info_628x;
>>>  		if (inb(pci_resource_start(pdev, 4)) & 0x10)
>>>  			ppi[0] = &info_628x_fast;
>>
>> Why not use "if () else" here ?
> 
>     Because I'm following the basic rule: one thing per patch. :-)
> 
>> And I do not see the point of patch 1.
> 
>    Again, one thing per patch. It was a preparatory patch.
> 
>> Since this patch is rewriting this hunk anyway, let's squash patch 1
>> into this one.
> 
>    I'd really prefer not doing thos...

I agree in general. But in this case, you are touching that code hunk to
clean it up using a switch/case. You may as well rewrite the case code
too in one go. There are no functional changes, so all good to me. The
patch is for that code hunk, one thing :)

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
