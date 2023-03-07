Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA41C678D5
	for <linux-ide@archiver.kernel.org>; Tue,  7 Mar 2023 22:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCGWCn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCGWCm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2023 17:02:42 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5A4EE4
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678226558; x=1709762558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EviAZJp9Cw5i9H3BBqXkLv53Dp0208QTzjUygOiD26U=;
  b=RVYfKG3FJnK8oWgknW3g1940DlaBuLKCFbKWbab7MKWu/iyu01WdHtbl
   46BRPtCWK15oy4KoYFcloom9K2IZd+f6A+pDX+egXhLz58gR3W8Y3RGLF
   MhcPQC+1dVvPd0+c2QpKc0usf5vzLUqJAmpa3URaXlRZpbNr6pa4+ZQML
   VDT9iCbyEkEpZw4u3o7GPA6a+x6xfvT5HYIEm+uXu9x/nizEPGcoKT2DU
   uM8DOYd5aOxV4TovEUoX72/BwTfmzuVMuf15lG9V4B8LH8w4ptrveQvyb
   qFX4Dub/vd6m50MlBQDRIsMF9LE9wF9inR70VsyiSvjqX6VUdG6PTNMBh
   w==;
X-IronPort-AV: E=Sophos;i="5.98,242,1673884800"; 
   d="scan'208";a="223334433"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 06:02:37 +0800
IronPort-SDR: oYY0XziQarKY6lcPCS3LGB/AqycNMKLJGU5KJnu9qK8DNAlrvRp6YrDPPyp+0wh9gCQxAEjnt/
 w4Hu++TbUgUQo2y/H1jECNTIoo62Ec9/qQGMwX6W5SAPhNjizlJtxRJtviaMY53MkG3renVwMJ
 FOOecsqtQDByQrfDzf0jXL47aw98AjYqwe9iqxpy+cSooT6T90lGdG0mk1+UzEPUmlO5CR54lv
 fQRfJPnq/uixSxWkmtrVN8D+h8gXlN3hqawS2JscwH/AVNZ2/c2Ozdq3DYkijcF7yDSL7scM6A
 Doc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 13:13:35 -0800
IronPort-SDR: w5FWhLiy9E6/fe1L6GqhxBK0UECR6hNnjPyz4/8beqEiCIyWmCLyihr8niSj83lORwYG66++9+
 UDb4lm8L7KZq9GrrCj8Lqdyi+mN5FAZNkswg7/lL1hi8TniTOpcJ1cnAeTlV2x8x3hlJfVEB6K
 jBUTKuh4sIJfHDnbBegauYROD2i+ncaa1wLOtGcvKP5FcUO7LPcJOgkoHtaHeNQakej1axs/F5
 ixCgwSdS4PymoLl3RGfQTXnQ7Ngbno6nQEGgDHkBqNSs3ER8Xkr+yqgqOlCjdHzMbqlb3o+S1v
 RfI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 14:02:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWTvd10Nhz1RvTp
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 14:02:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678226555; x=1680818556; bh=EviAZJp9Cw5i9H3BBqXkLv53Dp0208QTzjU
        ygOiD26U=; b=oQh5rvHGuTN+og6m4RdofnNxXfKQ6FOij7HodCau0YROd3W2vMP
        sAdB64d1gilHxx4OvumXJwN0hEtvRWbGH2tou7uVrD+qGj0myjPD5nnyNKNk9E8g
        /xJRkjJvyWytiygFploRUteaR2Fd0g29vaIutBat/ar1VbtUL/P6SvqKHsqUzH7y
        ibccEv58Hr5/VExPhL7hsEcpp4JvRIfY2caZBgJKYNj6C5K8ix6UnHeBYqstn97X
        IhLVkB67rWFF/rIJUuPsCjvc48ZWh1fc9Ojq63Y9s6EJ3rJ4iEOekWXE0YW1tYXO
        BBoaPCCaIRqVm+x9xZ85/fkP0aZHPNLxQRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qxZ7I670tB1Z for <linux-ide@vger.kernel.org>;
        Tue,  7 Mar 2023 14:02:35 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWTvZ0Zgkz1RvLy;
        Tue,  7 Mar 2023 14:02:33 -0800 (PST)
Message-ID: <f800c8f5-d6d4-8a93-f8e2-3ea46e6d7d31@opensource.wdc.com>
Date:   Wed, 8 Mar 2023 07:02:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
 <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
 <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
 <e5ed284a-77ac-df6d-1473-e4d96955f65b@opensource.wdc.com>
 <bf6d6b20-8479-80f7-1899-d58e03e6c6c8@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bf6d6b20-8479-80f7-1899-d58e03e6c6c8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/8/23 00:52, Krzysztof Kozlowski wrote:
> On 07/03/2023 11:42, Damien Le Moal wrote:
>> On 3/7/23 17:13, Krzysztof Kozlowski wrote:
>>> On 06/03/2023 02:22, Damien Le Moal wrote:
>>>> On 2/23/23 00:59, Kunihiko Hayashi wrote:
>>>>> Add UniPhier SATA controller compatible string to the platform binding.
>>>>> This controller needs three reset controls for Pro4 SoC, or two reset
>>>>> controls for PXs2 and PXs3 SoCs.
>>>>>
>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>
>>>> Rob,
>>>>
>>>> Are you OK with this patch ? I can take it for 6.4.
>>>>
>>>
>>> You got Review (which includes also "Ack"), what are you missing here?
>>
>> By the way, I am not seeing/have not received any Ack. Hence why I checked with Rob.
> 
> You were on Cc... Did I end up in spam?

I did get your review email, but I do not see any Ack with it. Was it a
different email ? I do check my spam folder from time to time but didn't see
anything in there that would not make me rich :)

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research

