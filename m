Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B5C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  1 Feb 2022 22:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbiBAW4j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Feb 2022 17:56:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38560 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBAW4j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2022 17:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643756199; x=1675292199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JEXkrnQvPN5XB3Pk+Ih5O9VSg3x9zd2WVW69XYIHQXo=;
  b=pe4zeJ3DU2e2urRIpXNQZrXNjO4InCrtsTtkIbUqBQSrGtobhw8WSzjb
   TA6AOT9TjX9hmXAmJ7yeeHszXcvvad5K24OepmdMzAsZrI2KhqPpVHdty
   igZTs0EkXDcU10JAyR43Nxt54miMCpUrgec/D9/SF8OJg5X6mlpIC8/uZ
   fpxIHHItOxe4gw0kH/e7KdKLcP5sGRzZOZ5G1UWMMYQejqvTqSHViISu4
   J1Qhb4fYj/XWHt1AzM0GCLdh5TkW+mXwki5SjQWb5YerrxWFebRZ8Mwyb
   Ib6hz65Gde5nkQ6c+M7EQgnJ/d2iejvLt/vT8+MJmw3twBqe9Ukcqepre
   A==;
X-IronPort-AV: E=Sophos;i="5.88,335,1635177600"; 
   d="scan'208";a="296012928"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 06:56:38 +0800
IronPort-SDR: TLmEpseVM6RBl5piiaX8mWOTctWnso5oU9KJnaNMzB5lFBfxUZQeSsxya0ixj94iLcIc/BBPDS
 C8M6ITlHs0fL9ag9YtWgnHbQOZgUQk41cs1cHQxu7wybtU4GQ24hbq7J9DOBck9vKFYQLKYQAp
 WfxcWx4Wo2Y+yaSe+g61ACGWnyqrlgvJNEtnFrIfRarKRlLZLpAeWCzt0/wz8AvlsZMscZqpEk
 8sM7F6J7hjwD25PmJLg60bJ68qt2m/+3TIkrivVhWu9TIBDIw6WfEyFUPMegAvxjSq3M6cYGof
 Pw7mnSvip9v8C84Rk1j/FHFU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:28:36 -0800
IronPort-SDR: aQ25H599OqfX1iz3YEK1vjtkADIDywfmyoNxAdUrlwIBsvjryskvUsWKtorMIt52bmwhhuxmR5
 XqO3BAGNl0mQOG0KAZyEmvoMt8d1s9MPNG3+jm9ZZ8pv+OyGg21jfgAM7DWqCt2ZGaBVJQrseh
 +M5QDc1TUkpMGkrS+8LXCxMGDkzZ7oB8nJvQySyMtrKrZ2fPiYTDe9krmohB78lmaMYaR1GVjw
 QA2YXELTCq6B01AYAgeLf27osIeiygTwb0pL0yAwIW2mfT4cx2NwwDZxb5hvdnnC/UJoKJf5yn
 1Jw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:56:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpL064SrGz1SHwl
        for <linux-ide@vger.kernel.org>; Tue,  1 Feb 2022 14:56:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643756198; x=1646348199; bh=JEXkrnQvPN5XB3Pk+Ih5O9VSg3x9zd2WVW6
        9XYIHQXo=; b=JAcVQ7YyIMFXVN6X56CITpdVT2t9cAumbhzIvWWg2laLykayK8x
        Yi1c9BDGwQqB7V+sE0mGtwPayADdz1T82ksV7zeJQndSd/dPUPYySCvIaknko/ua
        azM02t1ugCpfOhZkns2a0VOAqQRvJ28yfJkhUGc9Z34n9YacqqreRSZ1/b1zSSiS
        5gZsj51kTUIqlHULtEClRjWUOUYVZ0FxjsFuSN16cKaEq0rq7muEegYsihKjHqr4
        qI/QggMkNH+dqfnlE9KNTa2ElEegR9KK0vVSajj+8JORE/wfdf5r4vYm9nhY2U7i
        C+b9lk30g3clJl9ioafig1yTdOtFzUN7dfQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TDC-IWHqtHcd for <linux-ide@vger.kernel.org>;
        Tue,  1 Feb 2022 14:56:38 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpL0515WZz1RvlN;
        Tue,  1 Feb 2022 14:56:36 -0800 (PST)
Message-ID: <5a1d66d3-d3c2-ab77-f874-c3d6b10a0d2b@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 07:56:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bc80cd49-c95e-6b9a-1210-7d3832766b02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/02 2:36, Sergei Shtylyov wrote:
> On 1/31/22 2:56 AM, Damien Le Moal wrote:
> 
>>> Thanks for doing this Corentin!
>>>
>>> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>>>
>>>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>>>
>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
>>> this patch when he feels it looks good.
>>
>> What do you mean ? I am doing my best here to maintain ata !
>> But I definitely do not have all the hardware supported for testing :)
> 
>    I can probably help reviewing the PATA drivers if you want, just like Bart Z. did.
> But I don't have much of the PATA hardware (what I have is in my old PCs I haven't
> booted in a long while)...

More reviews are always welcome ! Thanks !

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
