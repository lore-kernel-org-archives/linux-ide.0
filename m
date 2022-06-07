Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B7C43334
	for <linux-ide@archiver.kernel.org>; Tue,  7 Jun 2022 00:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiFGAhr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Jun 2022 20:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiFGAhr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2022 20:37:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689F25E8A
        for <linux-ide@vger.kernel.org>; Mon,  6 Jun 2022 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654562264; x=1686098264;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Bp1gmcM9gTjwiWt/yQXIT6XXnKB7T1VOjoAsKZuquUA=;
  b=bwFVfVOnYxTdNBd69xHiCsLPlezg+V6re0pYS91cA196MdpKcaK+DPee
   5O9SWVvRMFcHRxASE50lY3VTpKzZZxwy0LJZ3ZiYM7Qfxt0yEwH07Y7JE
   AL4MTKr2DH50IZIbnhioJKrEviq5Aic6MmaL3HZ3bBuL2bH4IMk5TnyhZ
   1sYX6Uxy/3fryl4KBmUkotH7t7SDVv7AD3JB49VV4GrHD9ynRFhOxQk2Q
   ZE0jJgg1tR8ez9afxWcqXfKQ/ajvvq60hciXXecaYvm6bjttpHJXZ6y6c
   dQSQov8zuBWZzaadcYna3gppWEFOcHrJ5RhUd+96GMtyjZYjK+Q9itpsI
   g==;
X-IronPort-AV: E=Sophos;i="5.91,282,1647273600"; 
   d="scan'208";a="202422767"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 08:37:43 +0800
IronPort-SDR: qr/oKMlKZx0kusrQeI11UGecbNz1dMioSs7EKA+mUIoUGyQf0yoKt7/uq2OrtLb1K1y2cCDIA1
 sYv65Rqqtj+CiTv1Rz8MPFdzwcqUc7GpDBFLSKfhbgiq+7LK5BmqykmKWLM6gxeJQfltzp6iKu
 n/HTg+fhXkMaCIQVLv2BdyWdafXnw0t6kjYRk2VKvUq6yy4yl+DRJN4fJhpCcoaWWE34NKgPYE
 vrmGk6479z+gpb7CuJlyYMZ1XH73TaEW7/7W9nZtN76umGMqmR0T+sQIEWNWHqTzwsLyPGNF6D
 r/XNWfc6eKN1gzq4wKcKYiBV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 17:01:03 -0700
IronPort-SDR: +rC7iGuox0m/TVdNYI8s6YtqeiM8UyFoEUHQu/sGnBPlEhYUesP1yHPL2bZzelrRS459oF7+tr
 J43N/lrLIz75AuH/ZAoQDnhQJwN3ypk7rZkYOADfQu05KyFFrBve6TbTwAy2N2erqlQcY1XbLm
 8zthLp1gvj8EXrN7fmbnBbhZ3hq52atbgv72B5QdNUxCmsJQu6aZS+UUOgxVLTyEnR96XfSs/n
 m131CAPbCviCcbSGnCZcbKWO/kInBZdbSZ1iwKKffRj54KmF2p4QOZ+pOdJmvnDvADjVCusksN
 aW4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 17:37:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHBK33jS5z1Rvlx
        for <linux-ide@vger.kernel.org>; Mon,  6 Jun 2022 17:37:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654562258; x=1657154259; bh=Bp1gmcM9gTjwiWt/yQXIT6XXnKB7T1VOjoA
        sKZuquUA=; b=GCZDks7mqAy79WLQ5zwlAwTc3uUF5eju4+72QkiupUmThPzCCkq
        Ji7fM97UqQVJAz/ZbJpNx29ooPDKX0vx5CNzPnVC1Xa6A+TiE3bGNnE3IefK6w8k
        +HHC7pgSqdG/6kASRq/vg7iOGhK5zblTnY0Z0RXxLkwPOfnLAQzSaOqwiFib2mUW
        uJ3vRTFOadL+J5biMHWf5qz3Wc3jVcEk7tLdXfL1DzhAAwKZ5O4WIWPVBXSpCGFs
        e7Ys+jHeWscqeYnUNrFcrMoCWw323JGUAwOxHENeeXzzzTxcP02gIrUlW31TXWlW
        mr5zSPI1t/ahL4VP0w49CVAa1r/39Y0tk1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PYN5N9ktzTBm for <linux-ide@vger.kernel.org>;
        Mon,  6 Jun 2022 17:37:38 -0700 (PDT)
Received: from [10.89.82.246] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.246])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHBJx6fT1z1Rvlc;
        Mon,  6 Jun 2022 17:37:37 -0700 (PDT)
Message-ID: <a9a01deb-c314-3196-bd3e-947fcd8819b8@opensource.wdc.com>
Date:   Tue, 7 Jun 2022 09:37:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
 <c9695894-3bc6-e825-8239-ea6aa3e4831e@opensource.wdc.com>
 <78ae75a3-7f11-b177-c430-ad746f7d106a@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <78ae75a3-7f11-b177-c430-ad746f7d106a@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/07 5:38, Sergey Shtylyov wrote:
> Hello!
> 
> On 6/6/22 5:42 AM, Damien Le Moal wrote:
> 
>>> The {dma|pio|xfer}_mode sysfs files are incorrectly handled by the
>>> ata_bitfield_name_match() macro which leads to reading such kind of
>>> nonsense from them:
>>>
>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
>>> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
>>> XFER_PIO_0
>>>
>>> Using the correct ata_bitfield_name_search() macro fixes that:
>>>
>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>> XFER_PIO_4
>>
>> Looks good, but Documentation/ABI/testing/sysfs-ata says:
> 
>    Completely forgot that the sysfs files are documented as ABIs... :-(
>    Hm, shouldn't that file be added to the libata's entry in MAINTAINERS?
> 
>> pio_mode:       (RO) Transfer modes supported by the device when
>>                 in PIO mode. Mostly used by PATA device.
>>
>> xfer_mode:      (RO) Current transfer mode
>>
>> dma_mode:       (RO) Transfer modes supported by the device when
>>                 in DMA mode. Mostly used by PATA device.
>>
>> which seems incorrect/badly worded for pio_mode and dma_mode. Since these
>> 2 sysfs attributes do not actually device the pio mask (list of supported
> 
>    Device?

advertise :)

> 
>> pio modes) but the pio mode that will be used for that device, we should
>> reword, no ?
> 
>    Yes, of course. :-)
> 
>> What about:
>>
>> pio_mode:       (RO) Transfer mode used by the device when
>>                 in PIO mode. Mostly used by PATA device.
>>
>> xfer_mode:      (RO) Current transfer mode
>>
>> dma_mode:       (RO) Transfer mode used by the device when
>>                 in DMA mode. Mostly used by PATA device.
> 
>    Sounds quite tautological... :-)
>    What about:
> 
> {dma|pio}_mode: (RO) {DMA|PIO} transfer mode used by the device.
>                 Mostly used by PATA devices.
> 
>    I think this should be done in the same patch. Or would you prefer 2 patches?

Let's do 2 patches. Not sure if you can find a fixes tag for the doc update
though. But we should not aggregate the 2 attributes as you did. These doc files
have a defined format and may not be happy with that merged syntax.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
