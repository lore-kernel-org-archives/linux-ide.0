From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] ata: ahci: add support for DaVinci DM816 SATA
 controller
Date: Tue, 14 Mar 2017 10:00:07 +0100
Message-ID: <7ab4b440-f9d0-22fa-f463-f4c5542e21e7@baylibre.com>
References: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
 <1489422982-3461-3-git-send-email-bgolaszewski@baylibre.com>
 <db5d21c2-b0e2-c9ec-1f15-460973fd23e3@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38369 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdCNJAR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2017 05:00:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id t189so58222383wmt.1
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2017 02:00:16 -0700 (PDT)
In-Reply-To: <db5d21c2-b0e2-c9ec-1f15-460973fd23e3@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/14/2017 09:57 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 3/13/2017 7:36 PM, Bartosz Golaszewski wrote:
> 
>> This SATA controller is quite similar to the one present on the DA850
>> SoC, but the PHY configuration is different and it supports two HBA
>> ports.
>>
>> The IP suffers from the same PMP issue the DA850 does - if we enable
>> PMP but don't use it - softreset fails. Appropriate workaround was
>> implemented in this driver as well.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  drivers/ata/Kconfig      |   9 +++
>>  drivers/ata/Makefile     |   1 +
>>  drivers/ata/ahci_dm816.c | 200 +++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 210 insertions(+)
>>  create mode 100644 drivers/ata/ahci_dm816.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 70b57d2..7f59a7a 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -118,6 +118,15 @@ config AHCI_DA850
>>
>>        If unsure, say N.
>>
>> +config AHCI_DM816
>> +    tristate "DaVinci DM816 AHCI SATA support"
> 
>    Is it really DaVinci?
> 
>> +    depends on ARCH_OMAP2PLUS
> 
>    Especially if it depends on OMAP...

Hi Sergei,

Yes it's a DaVinci family SoC, but shares a lot of IPs with the OMAP family.

Neil

> 
> [...]
> 
> MBR, Sergei
> 

