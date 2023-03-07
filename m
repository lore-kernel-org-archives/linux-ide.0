Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7540CC678DB
	for <linux-ide@archiver.kernel.org>; Tue,  7 Mar 2023 09:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCGJsL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCGJrt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2023 04:47:49 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1512354C87
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678182451; x=1709718451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XAMMJ4e2XknIezt+JVgJt5gbEedpXSXNtv9cd7WBDBw=;
  b=reUszstGTMC5+0FbXrnVcWT3FvmR0rXeiTs3pWlMcC3bluyRorWQhAmT
   hwEUIHr85BqmABOMebd5glNZMKHagB5V/GH9qzDIl9DvNx1D/39fktT0Z
   3Vl5Sqc+VLTPkF0/dQh9TeTz7bc8U8wqvSY1Qin7pyVyuUWs094AaYq2c
   vWr3QoZVzTr3bQRHpIgknRFr5aiwtkqQAps97uS/Qfy0jZ43UlrTnp7nP
   RM9epbIxlPPKumYLYn9BcX999aQSXh+ij4kt9ls7IWlkPqG4QFU3lUiAA
   QaPz0W1VePi/JP9JR2vwU6whV5fUXkPssNawuK0IlZeOec49roEsk5+U3
   g==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="223281644"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 17:47:14 +0800
IronPort-SDR: JGolZqRK9nAd2/41M8znoSjqm7NVsJhFjKXAUyzARnCv+uejKZ7lO6639x74id+V01y2A7FQbb
 73NCswF/y1S7TNtQdThohZmyBaasgWCpOlkw+2fisxhEdi+5ga3epRM97Q+J5dt+AWVAtoOV5h
 jkGKwszPzSMwwy3vv2pJktgh1E9BG8gjJ5XwvE+zXD+azB6xwmP7S0/2JxyplkHUEBAoJozF35
 lOAO6b6ePw5WYnYrBh7zZN8JRX5NItujD6ZH6Vn3k1/wTxP0HbWE/1C+zPlK0NEkUI1JoSix4G
 Xuc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 01:03:53 -0800
IronPort-SDR: Oa9+mwSbfKgGpWfV//9kaVs/pBsq4MTH4girnjCgPR4Ct6rBO55ENdmfG6mjFd+vMKrZBmhnL7
 +QqjKZ8q93pHuPiJUr7GcCvTb5UWAfn0ooHp32Uxgr9a8WW1iS98g3mz0eAiLXJLAhZnnWoBZj
 TVasHiCURmD2//bUOMf0W7gw37wFcEWirvL8G7l8F5FUdiWDW9VvpiN9hhZUIlca1vaHYcgH+z
 Fc5t0/NrgHLj+sqfDCDsivvCG7wXWp6HviU6sLTRDH/9VZISLhvPsKh779s/LA33GqT34YE6CC
 iq0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 01:47:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PW9b55YrFz1Rwtm
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 01:47:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678182432; x=1680774433; bh=XAMMJ4e2XknIezt+JVgJt5gbEedpXSXNtv9
        cd7WBDBw=; b=Xe9/lQm/zSq85O2a6WTvXvqJTNvEAfCFQdNv1RDWR4Ny7PKt50l
        qKhUWmF00BpvOvW7QP5RM7espGYErO/tyuuFclV0quf1nuirs4Ioy0B8E/OTm+cD
        QhzW5YqWenPEfzo8GNNDltyTrXjrNTeTcNLzT59inQ0N7IF7Mwmnq5VSYphB6+4W
        67zE2imAYtxXP/Jg3NXo62wwFUFSw0jYtZmdyB1zogSPyQ7Dgp/9F26bXBW9o6OA
        JtZHbOzSu1fQnmXuywzqgmYd+HxZHdzQyUJKSDzQLMwvnuNAcg2H8aOO7ILqqvPs
        cV4tOvjWKObdWPF7tU06W9jKHuDpQOWXBPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t-y4oitnQRvc for <linux-ide@vger.kernel.org>;
        Tue,  7 Mar 2023 01:47:12 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PW9b31JKZz1RvLy;
        Tue,  7 Mar 2023 01:47:10 -0800 (PST)
Message-ID: <9e0c0ae6-0059-36dc-7cab-6b7e588c560c@opensource.wdc.com>
Date:   Tue, 7 Mar 2023 18:47:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
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
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/7/23 17:13, Krzysztof Kozlowski wrote:
> On 06/03/2023 02:22, Damien Le Moal wrote:
>> On 2/23/23 00:59, Kunihiko Hayashi wrote:
>>> Add UniPhier SATA controller compatible string to the platform binding.
>>> This controller needs three reset controls for Pro4 SoC, or two reset
>>> controls for PXs2 and PXs3 SoCs.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> Rob,
>>
>> Are you OK with this patch ? I can take it for 6.4.
>>
> 
> You got Review (which includes also "Ack"), what are you missing here?

Just checking with Rob as he is the DT maintainer. Out of courtesy.
I will queue that patch then.

-- 
Damien Le Moal
Western Digital Research

