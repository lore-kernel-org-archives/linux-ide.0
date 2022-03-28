Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD4C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 20:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbiC1UJC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbiC1UHx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2022 16:07:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88875F27C
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648497972; x=1680033972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uORNMvPmP6/EGG6KNMeYZz0EehS8+XAJTLN+nowe+gk=;
  b=TVGniN8Q7jl489yRSXdv7SIhfxnMJ09dTF++9gRXn1pqAIM7pYoZEgUJ
   /6U7eHlJXPeXAVrYejU/ggnGT9wAn3dP1PbXRrDI0hClfya0AKvgy9oF7
   FSJcR3KKvbocDo8/2IyBXkfoKG1iMxfREEKMWyyKUECSCfePo7niojLkz
   bGEO9ixUJQ2bppRH1zGrqo/T4HnqVV/0ZuHy76vCjtOJouMynW6K4Z2at
   Ezbu1A6DhMEy75u65FYPhA0qh+t9cGjy/C2Matk9QwSIYlmounNonBUjs
   eMYoW6cH7vTQE5LfZCxieXmINb++1hWb/Yd/5a+vOHxNTRJH/TFFqvUlK
   A==;
X-IronPort-AV: E=Sophos;i="5.90,218,1643644800"; 
   d="scan'208";a="201320410"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 04:06:10 +0800
IronPort-SDR: zl4AmbZRt7ebx0hkGdQk6Xf1o1W6ttiaZTkC6ThElEEtAX1qf7j9T0HAj2KGlEPbBbjUWAaoW8
 +JOufwDZi6KhahoNn3wLmExXK545KxB4e+JwnWF2tiaCR5z6fO9xr3/R+Qnkkyud8WgIPeVDlq
 AhinBwP47OZtCPmLsOLJTwF5nW+sQZbgVCvDk4a+IruvJAZ2QfHXHPOE15sNejXylvm/76LErB
 6vTbuSr8Mwq3duOCivpYprNeGXP50QSzTErEuejsNXl1t9oG+MhADh5D3NT34rB0jhMiaWF2kJ
 NzciiEg1F1uZR1G+o3M1ZDZB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 12:37:02 -0700
IronPort-SDR: vM2dn+PMq6dr3d1BKqmaf75qceJCALK15Y5EeZqkPDme54Rbi092stI0rWxTEvfCERB5MK8sfj
 wey1hKMSu7v0jtuRb/9cmEEwFyMpVq0vfb3qDyyITa+LLLFOAMvRFsnZp7GRjk1yO+scFkXrTb
 rNq3YUP/4rhRISdG3BoOm1Yh/ecC7F7Xitl/nUqgHhzMRtu96AYpQ9rXpC1W+6A1A45xRtKg9G
 siYIUPXAMxU8CANMppwHEAihP/b7w/oix8cRWZrJJiO3RMvIlKVWvyCh2PnfZ0hq/1BuKIU4xt
 6E8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 13:06:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KS3c16hkkz1SVp2
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 13:06:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648497966; x=1651089967; bh=uORNMvPmP6/EGG6KNMeYZz0EehS8+XAJTLN
        +nowe+gk=; b=Hybu7y8DH6ioZErSyJ6RlBbJhAJpuXbAvqdAMfXLkWLsp5DOaX2
        /mdmXKdqgX+GB51IXQpiFQ8RJ3vAUoR0gPZr5ne5MsxHwrlUvkKoRo+EJeyytb9W
        v/nH9CPaCgA9n9D2EsPrIzKPPcwEK0k58hxoHCbdKuU5iDlY95b9b95SQS3JY1nM
        /nMjZR24EzwRjLGdJC5xn02vfb51oan3JVx/HDkKWSGKMpzV3uxAXwn1xSUAQiWO
        O9SYjSfSYOCPhrxO5d9jjxB428F1UmXK2XIQiA0ugcr9xKV33Fe7VZEhL7FOTCj4
        MivuogtqZS4DWepss7JAqJb9eYYywpCuqHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AYXrAy5LY5VP for <linux-ide@vger.kernel.org>;
        Mon, 28 Mar 2022 13:06:06 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KS3bx2qwMz1Rvlx;
        Mon, 28 Mar 2022 13:06:05 -0700 (PDT)
Message-ID: <382eecca-f225-5272-b9d7-134c7baae4ae@opensource.wdc.com>
Date:   Tue, 29 Mar 2022 05:06:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/21] ata: ahci: Add DWC/Baikal-T1 AHCI SATA support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
[...]
> After the denoted above functionality is added we can finally introduce
> the Baikal-T1 AHCI SATA controller support into the DWC AHCI SATA driver.
> The controller is based on the DWC AHCI SATA IP-core v4.10a and can work
> well with the generic DWC AHCI driver. The only peculiarity of it is
> connected with the SATA Ports reference clock source. It can be supplied
> either from the internal SoC PLL or from the chip pads. Currently we have
> to prefer selecting the signal coming from the pads if the corresponding
> clock source is specified because the link doesn't get stably established
> when the internal clock signal is activated. In addition the platform has
> trigger-based reset signals so the corresponding flag must be passed to
> the generic AHCI-resource getter.
> 

I am assuming this is "v2" of your patches. Please add this version number
to your patch titles ("[PATCH v2]") and add a changelog here in the cover
letter.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> Serge Semin (21):
>   dt-bindings: ata: sata: Extend number of SATA ports
>   dt-bindings: ata: Convert AHCI-bindings to DT schema
>   ata: libahci_platform: Explicitly set rc on devres_alloc failure
>   ata: libahci_platform: Convert to using handy devm-ioremap methods
>   ata: libahci_platform: Convert to using devm bulk clocks API
>   ata: libahci_platform: Add function returning a clock-handle by id
>   ata: libahci_platform: Sanity check the DT child nodes number
>   ata: libahci_platform: Parse ports-implemented property in resources
>     getter
>   ata: libahci_platform: Introduce reset assertion/deassertion methods
>   dt-bindings: ata: ahci: Add platform capability properties
>   ata: libahci: Extend port-cmd flags set with port capabilities
>   ata: libahci: Discard redundant force_port_map parameter
>   ata: libahci: Don't read AHCI version twice in the save-config method
>   ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
>   ata: ahci: Introduce firmware-specific caps initialization
>   dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
>   ata: ahci: Add DWC AHCI SATA controller support
>   dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA controller DT schema
>   ata: ahci-dwc: Add platform-specific quirks support
>   ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
>   MAINTAINERS: Add maintainers for DWC AHCI SATA driver
> 
>  .../devicetree/bindings/ata/ahci-common.yaml  | 176 ++++++
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 ---
>  .../bindings/ata/baikal,bt1-ahci.yaml         | 132 +++++
>  .../devicetree/bindings/ata/generic-ahci.yaml |  98 ++++
>  .../devicetree/bindings/ata/sata-common.yaml  |   7 +-
>  .../bindings/ata/snps,dwc-ahci.yaml           | 121 ++++
>  MAINTAINERS                                   |   9 +
>  drivers/ata/Kconfig                           |  11 +
>  drivers/ata/Makefile                          |   1 +
>  drivers/ata/ahci.c                            |   4 +-
>  drivers/ata/ahci.h                            |  21 +-
>  drivers/ata/ahci_dwc.c                        | 525 ++++++++++++++++++
>  drivers/ata/ahci_mtk.c                        |   2 -
>  drivers/ata/ahci_platform.c                   |   5 -
>  drivers/ata/ahci_st.c                         |   3 -
>  drivers/ata/libahci.c                         |  63 ++-
>  drivers/ata/libahci_platform.c                | 234 +++++---
>  include/linux/ahci_platform.h                 |   8 +-
>  18 files changed, 1321 insertions(+), 178 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
>  create mode 100644 Documentation/devicetree/bindings/ata/generic-ahci.yaml
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
>  create mode 100644 drivers/ata/ahci_dwc.c
> 


-- 
Damien Le Moal
Western Digital Research
