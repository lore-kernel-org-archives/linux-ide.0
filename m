Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F56C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 29 Mar 2022 08:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiC2IRF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiC2IRB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2022 04:17:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28839A88B4
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2022 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648541718; x=1680077718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=etJNUyFKccNjFEH+loh7MV5WicY1MjAS8jDboHE8eiU=;
  b=dscpidZMoSzdIFOEwvrPem8ofHOPqvLRe4/f4RhsI6Y2mOUkiBBHZhYD
   uYNUCcf7F3ik5T8DUvpC2R+wiNDOz/fRsrOJTdjnURaqNxA7NOH/t3Z2I
   yuJpQfoY/CIM7WH7RMItqCjepv43eeUEhYrC8cqeu4bS4W/36IIYLVBA3
   BPaoE+KjJJBdVe/moW5TG55rAVZZGiUbSgnpfxiXvcEMGeOeW7eZSc/9l
   74xPxuQIJ4QgdAFDbPYjuLVuu1XFzYNdzK9xdWE2l8Zu+zqnLiQUuV5Pk
   sYXfdZA6qYSCu3fQDMV2AY+yg6+m0wZvmPIIjCwN9IlYmvPIQEOGw+OGM
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="201365599"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:15:16 +0800
IronPort-SDR: 7sZeCR35AMKYCARpCSh5rhKXp1moNTEU4hZchvCiJ03eEwdynrHnkmCkWkOMhT32hTuCDaZ5yS
 13O8oiA/kZoc/ZgLlQPFVnBgc3VQgxOqKkhFEzyMuUgS+56pQJAymIfQVK8JDsNT1JvC/gqw9D
 Wr6DDZkHymtZ8vDMeitABwuepm/J2HjhhhUa1AkRwQTO2i5FoId1pLbLZeC+DNcaAvLFL2KFuh
 G2CqzJOvQOeEyU7MbgdtkZnTEhfgVUbOYMr7SgHvJ1nJG/93cx6SE409r8CNlROOmoVd5mAWlr
 jxGn1qXfB/xFL8ZkK9K4vQYo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 00:46:08 -0700
IronPort-SDR: rbtlzaUTOYJci80vwdGlzrX3zNwSdNO7yYyxDyTD/DEAqdzTGZji8DZfieq+QL2gSqSdkSRkS3
 RN9vgLxG5aYVb3DXKjXZzWPaADkuFEuy9tCwdCkjqRedz/YtZ08i2FRhrD4gCyEKzJXhjgqyL5
 /Bn5SGT+73h1IQbQTo2TFcK2Nq+8OVNoulvA9HvukX7nRwZ98MZc1Ckk+VD/cUc8KthdNBuG/0
 +/yTethTMGvAQqDt0aDX+ukNf483oqhGpxXv7a16Pq3pIMcyFs6pg4fUiYXtXlS0F3QwB5GRu+
 0tU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:15:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KSMnJ0Sdwz1SVp3
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2022 01:15:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648541715; x=1651133716; bh=etJNUyFKccNjFEH+loh7MV5WicY1MjAS8jD
        boHE8eiU=; b=rbTF4xovKjZmjm0Q9kD377CcxZE6a5+bc4Ph0ByS4mv5rAhDmN5
        IHEmLItD2CD+1CijzpQQVhNlazvLope4j9BC2MAuYntsKzMinyTtjk7jCeYIlO0z
        TPtwNCWNrTY0YrJ2vI5abkSiUPYUz+JfTS69G3ZAEwDBv29Xmxpbfg41TrAVjy+q
        ANfyxbz2dAIpnC2DjpqsYLal/ogpkUvrrx4mx6XfiGWFe80w6uHOqFYUumVWPFiD
        qod4EIjsMk4V456o9VdM3nQWyVYnZSrEsXG+6qNJlcxVq9XgIOWIKt6tTwtPt/YK
        9WKA7oxaGB426i3X7edoJ0iw/s2WNqnKyUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ae8CogbLWbEu for <linux-ide@vger.kernel.org>;
        Tue, 29 Mar 2022 01:15:15 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KSMnF2ytmz1Rvlx;
        Tue, 29 Mar 2022 01:15:13 -0700 (PDT)
Message-ID: <92699f07-0efc-e471-d886-c7d6c83f352e@opensource.wdc.com>
Date:   Tue, 29 Mar 2022 17:15:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/21] dt-bindings: ata: sata: Extend number of SATA ports
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-2-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> The denoted in the description upper limit only concerns the Port
> Multipliers, but not the actual SATA ports. It's an external device
> attached to a SATA port in order to access more than one SATA-drive. So
> when it's attached to a SATA port it just extends the port capability
> while the number of actual SATA ports stays the same. For instance on AHCI
> controllers the number of actual ports is determined by the CAP.NP field
> and the PI (Ports Implemented) register. AFAICS in general the maximum
> number of SATA ports depends on the particular controller implementation.
> Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
> 5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
> controller can't be configured with more than 8 ports activated. So let's
> discard the SATA ports reg-property restrictions and just make sure that
> it consists of a single reg-item.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
> index 7ac77b1c5850..c619f0ae72fb 100644
> --- a/Documentation/devicetree/bindings/ata/sata-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
> @@ -41,11 +41,10 @@ patternProperties:
>      properties:
>        reg:
>          minimum: 0
> -        maximum: 14

Why remove this ? Since AHCI can have up to 32 ports, then change the
value to 31. As the comment at the top of the file says, this is not
intended to be a device tree binding spec, but defines properties common
to most adapters.

>          description:
> -          The ID number of the drive port SATA can potentially use a port
> -          multiplier making it possible to connect up to 15 disks to a single
> -          SATA port.
> +          The ID number of the SATA port. Aside with being directly used
> +          each port can have a Port Multiplier attached thus allowing to
> +          access more than one drive by means of a single channel.

Please add a comma after "Aside with being directly used", otherwise the
sentence is hard to understand. And replace "channel" with "SATA port" to
stick with the terms defined here.

>  
>  additionalProperties: true
>  


-- 
Damien Le Moal
Western Digital Research
