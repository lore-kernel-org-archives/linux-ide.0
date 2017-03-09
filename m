From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Thu, 9 Mar 2017 23:45:30 +0300
Message-ID: <f82787e1-9d35-a410-f3e6-c7432e61c140@cogentembedded.com>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170309130216epcas5p276d211cfa5ed9f87b11a73ebe6fcdc7c@epcas5p2.samsung.com>
 <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
 <38ee4af3-b2cf-e9a8-1339-d7d904b7dc15@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34317 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdCIUpp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2017 15:45:45 -0500
Received: by mail-lf0-f45.google.com with SMTP id z15so11206935lfd.1
        for <linux-ide@vger.kernel.org>; Thu, 09 Mar 2017 12:45:33 -0800 (PST)
In-Reply-To: <38ee4af3-b2cf-e9a8-1339-d7d904b7dc15@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 03/09/2017 08:05 PM, Sergei Shtylyov wrote:

>> Add Palmchip BK3710 PATA controller driver.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/ata/Kconfig       |   9 ++
>>  drivers/ata/Makefile      |   1 +
>>  drivers/ata/pata_bk3710.c | 395 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 405 insertions(+)
>>  create mode 100644 drivers/ata/pata_bk3710.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 7e0fc98..c23ee65 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -509,6 +509,15 @@ config PATA_BF54X
>>
>>        If unsure, say N.
>>
>> +config PATA_BK3710
>> +    tristate "Palmchip BK3710 PATA support"
>> +    depends on ARCH_DAVINCI
>> +    help
>> +      This option enables support for the integrated IDE controller on
>> +      the TI DaVinci SoC.
>
>    Strictly speaking, Palmchip BK3710 is Mentor Graphics' IDE core, used on
> the original DaVinci's. Mentor's documentation was never publicly available
> though...

    From googling I knew that Palmchip was a company Mentor probably bought...

> [...]

    I'll try to review the whole driver on weekend.

MBR, Sergei

