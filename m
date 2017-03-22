From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Wed, 22 Mar 2017 20:56:14 +0300
Message-ID: <65ecf56a-7e45-30d3-649c-798f8037a636@cogentembedded.com>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
 <8fc9171f-15b7-2c6a-d0b5-3af21cc88405@ti.com>
 <CGME20170322174917epcas1p1a4ba3e4da231ee3b7784cb0c669611ed@epcas1p1.samsung.com>
 <1819267.Nm9hpTOhuY@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36426 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935785AbdCVR4T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2017 13:56:19 -0400
Received: by mail-wm0-f45.google.com with SMTP id n11so43562554wma.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2017 10:56:18 -0700 (PDT)
In-Reply-To: <1819267.Nm9hpTOhuY@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sekhar Nori <nsekhar@ti.com>
Cc: Tejun Heo <tj@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello!

On 03/22/2017 08:49 PM, Bartlomiej Zolnierkiewicz wrote:

>>> Add Palmchip BK3710 PATA controller driver.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>
>> There are some checkpatch suggestions that are worth fixing, I think.
>>
>> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:277: CHECK: Alignment should match open parenthesis
>> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:320: CHECK: Alignment should match open parenthesis
>> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:489: CHECK: Comparison to NULL could be written "!mem"
>
> Will be fixed in v3, thanks.
>
> [ My scripts didn't run checkpatch with --strict so I haven't noticed them. ]

   --strict'ly speaking, this switch is only forced on in the networking 
trees. :-)

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

MBR, Sergei

