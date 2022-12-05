Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F8C4321E
	for <linux-ide@archiver.kernel.org>; Mon,  5 Dec 2022 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiLENYb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLENY3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2022 08:24:29 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF91AF03
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670246668; x=1701782668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eIuVPi2oKlmfmwkWcq2jyJdIlCtdykKp0CE/vjbqIHc=;
  b=X8nKKuJI7ncK4InSxHEcSo9WZJXczFdYHlspQFQZCrMWDxq33qSi/Yc6
   IN7vfbsF4Z7QsSIR3+piWeYL0H/m1ZU3mtFf8syTRMdR8komF8j4/4hwb
   WDvO6gIDt9rabQwZQK1VtlpmS0f8Zg2Lb7a+m7WJAgq9H8Dge3djb5GYM
   px6qU+X5Xld7nu1ZVdHEiZCoiNUymc2VwYxB2vY09OXisMi2cIDeM18xI
   +sydfip2rKvNrATYbXrEQIzoXXhaDpvXu8PQWcMzs6p/zCqBLWjYRybMX
   ELXSrmSqzp2PHkORHnNUWQd8CZuxdg0malirfmq+Na/SrOfvNC8/qby5y
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665417600"; 
   d="scan'208";a="322277616"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 21:24:27 +0800
IronPort-SDR: 3Oy6tRxM9WaO7Gm2hv1fL45eoBfivLqnCj7mS+w06dB29c3AX7TfBrTQXmJnALLJPUiDlR41sG
 c5xAw8nbVzzYGzpwMrSTeaQBM0I/x/zgiMM0xnQlW0hULiPS6Dmx8vX3l2St5SU+UW/QTsaD3V
 yxoaWdwyS3BUxtykHlpPZQKJE1ANF72HWfUK/g2pL5DZd0Xv1prgpt6KENl6XxSDrOI8ZsLAo1
 qAw8BClmyWo14vvAM2YLPKzrgcVI7rmCLE9aZ15UiAQjjX9nhD22GXcW3r+2gzSm4BxRmGoOo9
 Di4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 04:43:00 -0800
IronPort-SDR: eFGP/3oS6WCsmVIRy7RjflQH+3voEkxgMt+aI0ReipIri5N+01u/7AnYpspNVEfz4me/sP8mvz
 zCVF1WXyprX88piPFGBrMsYVQrPdxPR+6lrLOeEuLx2xTF8OvsmsJQUaferfEmhw95fwKdyM55
 6XaIIpX5HcoQVE8JSmOzdhpgCp31Ib9fgzIjg1khKZ3Xm//hQJb7qDlE70wvABXGWUgfk9gebB
 yE5/uf6vnPe2b4VBDSoSHyWuYRuvbGNKH7BZapu9KJLUt2F6LTso5vc6o0echLNBKIWPAjbZ7y
 ttc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 05:24:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQkmB5Xlhz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 05:24:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670246666; x=1672838667; bh=eIuVPi2oKlmfmwkWcq2jyJdIlCtdykKp0CE
        /vjbqIHc=; b=Ecs0n0q1JF4Cx8NoxRMgMJtMXrKuW5Q0cv0SaH2nQVL9z4d2Ksw
        oXbrqsUEPpNvntcx7VwaNyBirMaNJS7u6cxvS+6r6SdY0IDZvFdaEnJskr7PVtWr
        gHK5ubpd82Muow3h6emPVVyTAINaxclwgIQalI/+3b57j4xK9Q0+jsckqpd4Ii1H
        +BDqqFFoSkq6T41xsJpOp2mBPDUGNPTws4LYze04nhIRaWGPAIswyb8xC0qSMLq7
        rnpIGvaYv4IYho1sv5tWhQyD6SEuRMgvGW1FKEtCwC+pID4Zkc0A6gfv0I+pxHvK
        Nn8gTg7NPDm23gcFTGFUnNHWvjrxAbt/esA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3nsXMjqHbqvV for <linux-ide@vger.kernel.org>;
        Mon,  5 Dec 2022 05:24:26 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQkm75kCwz1RvLy;
        Mon,  5 Dec 2022 05:24:23 -0800 (PST)
Message-ID: <f440a8ff-7657-c1be-e733-4ad69b6b7b0b@opensource.wdc.com>
Date:   Mon, 5 Dec 2022 22:24:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Carlos Hernandez <ceh@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
 <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
 <20221205011105.4do4trbytq4bfw5b@mobilestation>
 <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/5/22 19:08, Arnd Bergmann wrote:
> On Mon, Dec 5, 2022, at 02:11, Serge Semin wrote:
>> On Thu, Dec 01, 2022 at 12:48:32PM +0100, Anders Roxell wrote:
> 
>>>
>>>   for (i = 0; i < hpriv->n_clks; i++) {
>>> - if (!strcmp(hpriv->clks[i].id, con_id))
>>> + if (hpriv->clks && hpriv->clks[i].id &&
>>> +    !strcmp(hpriv->clks[i].id, con_id))
>>>   return hpriv->clks[i].clk;
>>>   }
>>
>> Indeed I should have taken into account that devm_clk_bulk_get_all()
>> can get unnamed clocks too. But checking the hpriv->clks pointer for
>> being not null is redundant, since the ahci_platform_get_resources()
>> procedure makes sure that the array is always allocated. At the very
>> least you shouldn't check the pointer in the loop, but can make sure
>> that the clks array is available before it.
> 
> Do you think this is otherwise the correct fix then? Any chance we
> can still get a version of it into 6.1?

If someone sends me a proper patch to apply, I can send a last PR for 6.1
to Linus before week end.


> 
>      Arnd

-- 
Damien Le Moal
Western Digital Research

