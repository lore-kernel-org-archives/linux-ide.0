Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7388BC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 10:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiBBKq3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 05:46:29 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11672 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiBBKq2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 05:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643798788; x=1675334788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6k7tE3M6bpnJHQHnhJCh/DCDGRD7sVYF5zWLizvvIyY=;
  b=ppXqyuoELjUkwmKfyAhVBrimJjEODCrsU+p4rj7d44DU2JGJH/sd8KCM
   iNChkDRjOITpVGKnoZ7bEL62F23Rm38b9jCuZEMjgWbrd4mIu637Vdrmf
   lql/SnIIVGiTKt1TE9VEC6JIaEceszuXErAUcFrMUkh6RE3IdcU2NHDW/
   URkEge3SQBt7dQrq+cjEesRV6+SsBB84xOd1qYcoG1pwvjzltUJa7hZCD
   Mx+rVWGfLFYVF2JM5KzCQvqJAhd/Hp3gmdak1MElGqUQHnmjvnM+lhWmZ
   pViYWTaEjcpMW1jsMDeX3UQhGdREY9+qBGgfk2t5FB8MPzYBVrCB5tF2h
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="303864285"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 18:46:25 +0800
IronPort-SDR: RrYpmoer0W9CUj/lwIyyY/NDoHyOS9NDlAMDI2AEEU252gfSJByxwTJdijPnteXbuJ5MWzM5tq
 3U4hu1wsMK86mlFQWGTWm9ZnjJnWcpiGVydZny4vSzqiOwwlefMCSqSXuhhD1tpnkX6n5lPnz6
 +y31kl2VeIU+mW+oZMc5gJD32XqFPfA5c9rdMPfgbhRwuuK5WX9k7QiyndtQ0qSYozfM/f6tgA
 wzSdFQUfMRGI6UU+8ySBeZctrzz1MGrUVqFbnbl4EOWia2BMOLNkW4b/HlHMky/IzaXD3WyVpy
 7NiwadwZWUaufiEzaQE/PcNZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:19:35 -0800
IronPort-SDR: azZZw/ArjZIpIVT4ERup/cvgO7oXl1EQPwscw+MPTtW9AgcSFs6CR9EPAtZV8n8QhEdQP6DRw+
 KjBZ00fEeNqGcH10qoQ68qCr973bkoThf7KpFLrYWvjFZHx44+TgJ0MeEmCwC2K9CGYlDfK7W9
 We7mxvOgBWeJper+4L+Bu0okVzDNZ1LVof2oCXODp0xmeEG4WdHGhebzrJKXaVgIPs4Cudnyui
 0Hq994BfcLW9XDI6Ot9R9mXo4fzQumjfPKWEpoqkVlPKMBGUle3aO3wAVPJXfpZbw1sbEEf0Aj
 Rwc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:46:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jpdl52kBDz1SVny
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 02:46:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643798784; x=1646390785; bh=6k7tE3M6bpnJHQHnhJCh/DCDGRD7sVYF5zW
        LizvvIyY=; b=Xi88hxJNWip64lmBn8x6HoOeVthH818CFRxVaCnDn8mgkRPaZgb
        GFmn0hAJpD/CUOTOWiCcPI6NVcs+60OBFUkXygG3cGdlPTtDnOueL9C3lJgVhjyC
        Bx10geEuzaoLMONAjHmOt7H1ba2816Rp5KSaryC6S/zUOs1HyrV0eeuXg9gWZVM4
        hVuUhL6tqs978ud++ixMb63wir16MeuLVHgyHZ46Y0tmtBEt1z0YAjspJUDf5YlA
        fdXf7pYV6aZiES5+1jUOtj/nZ5T48vJhrsXo7DStb1sEiv7GLAV4XroURnsut5Je
        Y1hmmlDYg/ANxWhbqlD9IniYHe7jAJ/2kVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7U3FWdOmYvcC for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 02:46:24 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jpdl36PLqz1RvlN;
        Wed,  2 Feb 2022 02:46:23 -0800 (PST)
Message-ID: <c49abe7a-bc95-a692-29d3-eb37ee6f2e1b@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 19:46:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220129204004.1009571-1-clabbe@baylibre.com>
 <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
 <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
 <bc80cd49-c95e-6b9a-1210-7d3832766b02@gmail.com>
 <5a1d66d3-d3c2-ab77-f874-c3d6b10a0d2b@opensource.wdc.com>
 <d16a1be7-d856-f6b7-5a1a-9f09f42195ee@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d16a1be7-d856-f6b7-5a1a-9f09f42195ee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/2/22 18:24, Sergei Shtylyov wrote:
> On 2/2/22 1:56 AM, Damien Le Moal wrote:
> 
>>>>> Thanks for doing this Corentin!
>>>>>
>>>>> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>>>>>
>>>>>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>>>>>
>>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>>
>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>
>>>>> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
>>>>> this patch when he feels it looks good.
>>>>
>>>> What do you mean ? I am doing my best here to maintain ata !
>>>> But I definitely do not have all the hardware supported for testing :)
>>>
>>>    I can probably help reviewing the PATA drivers if you want, just like Bart Z. did.
>>> But I don't have much of the PATA hardware (what I have is in my old PCs I haven't
>>> booted in a long while)...
>>
>> More reviews are always welcome ! Thanks !
> 
>    How about me submitting an "official" PATA reviewer entry in MAINTAINERS?

Sure. That works for me.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
