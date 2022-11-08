Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D53C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKHG10 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHG1Z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:27:25 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719EE1901B
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667888844; x=1699424844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sJepVHkYxfFyGEgdCG67kWpecXDxx9h/xLE9ue9VXbo=;
  b=n86S9tGVe6AXV1zCS8cuCct9NomD8/8aR7ye1AgqtiTeeD/UuMuEZh1K
   hQRYHehXjUe0ycMU26CLGiQUKe9+Mplxhg6AwPkCBQ2SFvCVlK/TuG0Ha
   72cEji7La1oRH89IuLC7GFvzwr5sQjMVqw1kHX6it4pSk2MkH4FIU2rS8
   TY/IbgeY8SDDu90Ojad/wWBHDnN19e0lbVYgNLH5ETVa5jDo+CeBtmS/K
   wLnOcMspjqlHZVjjCZLJIgqw9ZCHth6sekPhL6Cb+mdG5YYLhNNLXPz+l
   eo060j9M/JTaAaW8kqL4bQp80jGm+DtpoNmGhleoUBcrbx1TOqVNBzAzc
   g==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="220891600"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:27:23 +0800
IronPort-SDR: a2X/fNCPrpS9OOZMsoRV+f3i++e8oV5QhFAvP+MnrcIaYrnKutsQbp70Su/F9iZyiJaHVBD5C+
 qCAtpzxoL45n3cRJWtsDYTQcA062BmNDJdK6SK5AY1FqV7NIl1PhRfT0/fGjKpCiGMEg6ak76h
 ySU4G1lQDOJCXQ12RlkGvfrfITiPW7vE8HgflwyVMGsph/8xwEtvME8Yu2Z2WJ+vYC9YyPuMza
 y9Hy6F9oSiiFTrq89UV7m4gqN/jZZItHK5amKBUZEKmZmLR30zWMxN/RCZZp1mbra5a9dRq75M
 lgY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:40:45 -0800
IronPort-SDR: e607j3EPNG/D8cozXdw5mMb8c+bcVJYFZA9VyJwoo5a64IrFwxwLtyLPdGe8E/7M/l8+xrmWAi
 n3x8m/spjGvRK/49R885yFDSiGlc82GHox5ExU5RtCshYtaAzDgYnRASsA3tFVSgBCnlK0fe+h
 ogHhJJIYAP6wQu5rpkrDRMc0NPCf4WKHdIETRbZCwV7FqKVyAJi6CplChS/tAq//X+HYmkGXU2
 nqJ76NNxL0plL7oz4dBLY/OObsiWx5ayKALPuVYSb+EJMlBztLMiAsZbA4PAed9FN+jDlTOjAE
 HIU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:27:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5ynR1rRGz1RvTr
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:27:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667888842; x=1670480843; bh=sJepVHkYxfFyGEgdCG67kWpecXDxx9h/xLE
        9ue9VXbo=; b=qIN/1tlofSh02KF2UnSBlNdFr+YJaFaxTyrzXey0FuUpaS6Pzj2
        I6MSWKwQBzMVqh18UaPx3SSzhYGZcww8dXShQCskQUyAKyfgyhlq8/tQUdRYvNGe
        7XtjVv7ABy2iw3JGya+YXWlHX6pvPa2p2y8axnQPAzl5j1WsOpvsZNF/9do2uI32
        86HNbhOxXcnuIxL13/lGi7Elp6XyQLcXePy+/HPZEaOG6gVZQGvhPA3XFBLWGaIr
        F/a40VhtiTs04SmGkhLXUjV3vu42ZfAonHnvh7vMmEEWFJOjJiAnzoVh0ZKx8npl
        Ci3RwrhHFN14UTqfPqKyUL0jjKMrsF8zCFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WQPw4jhMScet for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:27:22 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5ynQ1Q7hz1RvLy;
        Mon,  7 Nov 2022 22:27:21 -0800 (PST)
Message-ID: <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:27:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 18:22, marius@psihoexpert.ro wrote:
> November 6, 2022 9:05 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> Can you try current mainline 6.1-rc kernel ? Not going to debug 5.15.
>> Debugging should be done on the latest kernel and any bug fix backported.
>  
> OK. I have a bootable kernel v6.1-rc3, but no rootfs yet. I load it via tftp. I built it from github.com/torvalds/linux using OpenWrt toolchain. Bootlog is attached. At 17 seconds I connect the DAS.
> 
>>> The same router works perfectly when I connect a laptop HDD.
>>
>> You mean an external single HDD connected with an eSATA port ?
> 
> Yes, to show that the hardware is not defective.

So the adapter & driver are OK for regular ATA devices but they may not
like port-multiplier devices, or one of its flavor. See:
https://en.wikipedia.org/wiki/Port_multiplier for a nice summary. PM
comes with either command-based switching or FIS-based switching. The
adapter may not support the flavor that your PM box uses, while the
sata-mv adapter does.

> 
>> What kernel version is running on that older Linksys box ?
> 
> 5.10
> 
>>> [--- Areca connected ---]
>>> <6>[88761.966331] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
>>> <6>[88761.975472] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f
>>
>> This one seems OK with the PHY detection and it links up. Let me know the
>> kernel version and we can see what changed between the older kernel and
>> 5.15. But you should still try latest 6.1-rc if possible.
> 
> I don't think there is a change in kernel. It's just a diferent driver in use: ahci-mvebu vs. sata-mv.
> BTW, is sata-mv compatible with this hardware? It won't auto-load instead of ahci-mvebu if ahci-mvebu is missing.

Try to check the router SATA adapter specs and your PM box spec and see
what PM flavor they support. If that matches, then this is likely a
driver issue. If they do not match, then nothing we can do. You will not
be able to use that PM box with your router.

> 
> Thank you for your reply.
> Marius Dinu

-- 
Damien Le Moal
Western Digital Research

