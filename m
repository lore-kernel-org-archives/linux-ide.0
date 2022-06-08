Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F430C43334
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 23:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiFHXWJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiFHXWI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 19:22:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE06228CEA2
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654730484; x=1686266484;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=us9wHuQfe5+8aJa8g25iuZ/pfGcwOfvBHlOyfRcjeGk=;
  b=KLXVm4+1dvX+ENWazPpmnZYxSRbsjmYCSEZs71wGwXPE3n+L0szOF2nS
   i9hLb1GozTCQeed0eMiQI633W3CzvWXRaMrqTXDlMyfQE6Al4leMQ+9uJ
   zw/ni8elU3jNn065kMpZCiwhPKXAevCCCvC4+EQj3F/4dqbjILNlp1bRB
   whrL9MJupKTZ1Bx5nudjlMkcQ6s6fmTOJgHHegsqNtFQY0V+aGFGHS9lV
   DZdiUKk1AmJiO80zq5GoDHVklDg3vR6gRnwZmajR0BUcIpSkTHcjTwlS+
   /+jMGvYTWTUytScz+jhLdNU2J/9kMQcHdzcAjWDTgqXLi1d5YsIZg960/
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647273600"; 
   d="scan'208";a="202643151"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2022 07:21:23 +0800
IronPort-SDR: 78GHB6a6c2Ljd9BQuDitU5UO2bnjiEb+v6hHcRG8xlAhVRLF1wg2VJ0c+GL7+RJ9xZpQ76nAug
 AQy+1fZsJ8kd2oLP2MiKqul50hOMewSchQsR0rEjZg5ZJJjhZynl86Vy2Av3JEWk1Bm2h3iJSY
 EZhs+6LjGufv/To2KepAxtT16ozXmcuNWgKa+tdqJClPxcMKn7IUsL9UYxzk30l7HHkK3xM7Kj
 ayBjjfhR37Lk1x18G2xGqE7ewXwSGaaPj6RWvuAbwrCkKoJ1xzOCbbxwa0AzvYgPu11b3Lgks1
 zVsWNgf6VNiohqe/hjnfaF23
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 15:40:12 -0700
IronPort-SDR: MrQDbZctUylX/sMWccCsRX44z+0a6RrHqnOk0xBisxVa1e1so1o1o31SdhMS3PsgsiGwM5pgn9
 JFZ9U7oST7lJgSu+mj+axXDgK3XZMSrCmi1AOYKlzJk+s6w473ya55bDGNnZ0zGPZh9SxZ9N+x
 P0mQKwfeqU2zfqUd8B5RF5RSyQtHtUTd8/x7pT+Isz0ktOHOiJvzx70B801xLp19wS2QY0n+T2
 eg3bTxZqd1+XgfkCKXC1UM3uQbNsLuR7C+IjMSxYEYtT5fTc4JhqbZrAS10+1YJAEDJJlDpOHB
 oxc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 16:21:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LJNX32Bhvz1Rvlx
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 16:21:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654730482; x=1657322483; bh=us9wHuQfe5+8aJa8g25iuZ/pfGcwOfvBHlO
        yfRcjeGk=; b=drVtaRdfLVmGq2/07T1GQNTtRGLfqeQTDoUzkJdrvuhjF7w4pXJ
        jJPVvruCitgmNFo8QatuwMIDTRQdElbk6fmLM4kL5WvpLtKgSuO2KASmN0bAilR7
        NeINSPSR6O8yfUFPjDZ3coBRccOQrKjK5N1EAkvQhem+/P+JCjjYroA+LdRnjzhL
        ohFY+1SlIlz3nLdDE0OOF6GLFPFV0KZ1KfgAxPahHOwfGNI+2kn+Y39XLC26q88/
        /sc7wgysRXpd6/X9bbMzUvCUXa0s2QBGmWRaJ1tw8XdpbDj/leIhfARmyKPtqBjS
        l2ubKATLf0MwQi1URSsBr/5+EghcR4Y6wtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vxr6EuBhNTT8 for <linux-ide@vger.kernel.org>;
        Wed,  8 Jun 2022 16:21:22 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LJNX21M8zz1Rvlc;
        Wed,  8 Jun 2022 16:21:21 -0700 (PDT)
Message-ID: <5c6bf755-62e9-f0d0-f22e-c7c116992d05@opensource.wdc.com>
Date:   Thu, 9 Jun 2022 08:21:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <02321da6-5cd6-aad0-727b-7207d8e3fff5@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <02321da6-5cd6-aad0-727b-7207d8e3fff5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/9/22 04:51, Sergey Shtylyov wrote:
> The {dma|pio}_mode sysfs files are incorrectly documented as having a list
> of the supported DMA/PIO transfer modes, while the corresponding fields of
> the *struct* ata_device hold the transfer mode IDs, not masks.
> 
> To match these docs, the {dma|pio}_mode (and even xfer_mode!) sysfs files
> are handled by the ata_bitfield_name_match() macro which leads to reading
> such kind of nonsense from them:
> 
> $ cat /sys/class/ata_device/dev3.0/pio_mode
> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
> XFER_PIO_0
> 
> Using the correct ata_bitfield_name_search() macro fixes that:
> 
> $ cat /sys/class/ata_device/dev3.0/pio_mode
> XFER_PIO_4
> 
> While fixing the file misdocumentation, somewhat reword the {dma|pio}_mode
> file doc and add a note about being mostly useful for the PATA devices to
> the xfer_mode file doc...
> 
> Fixes: d9027470b886 ("[libata] Add ATA transport class")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org
> 
> ---
> This patch is against the 'master' branch of Damien's 'libata.git' repo.
> 
> Changes in version 2:
> - added the Documentation/ABI/testing/sysfs-ata file, updating the patch
>   description accordingly.
> 
>  Documentation/ABI/testing/sysfs-ata |   11 ++++++-----
>  drivers/ata/libata-transport.c      |    2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> Index: libata/Documentation/ABI/testing/sysfs-ata
> ===================================================================
> --- libata.orig/Documentation/ABI/testing/sysfs-ata
> +++ libata/Documentation/ABI/testing/sysfs-ata
> @@ -107,13 +107,14 @@ Description:
>  				described in ATA8 7.16 and 7.17. Only valid if
>  				the device is not a PM.
>  
> -		pio_mode:	(RO) Transfer modes supported by the device when
> -				in PIO mode. Mostly used by PATA device.
> +		pio_mode:	(RO) PIO transfer mode used by the device.
> +				Mostly used by the PATA devices.

s/by the PATA devices/by PATA devices
(since here we talk about PATA devices in general)
Same fix below. I will fix that up when applying.

>  
> -		xfer_mode:	(RO) Current transfer mode
> +		xfer_mode:	(RO) Current transfer mode. Mostly used by
> +				the PATA devices.
>  
> -		dma_mode:	(RO) Transfer modes supported by the device when
> -				in DMA mode. Mostly used by PATA device.
> +		dma_mode:	(RO) DMA transfer mode used by the device.
> +				Mostly used by the PATA devices.
>  
>  		class:		(RO) Device class. Can be "ata" for disk,
>  				"atapi" for packet device, "pmp" for PM, or
> Index: libata/drivers/ata/libata-transport.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-transport.c
> +++ libata/drivers/ata/libata-transport.c
> @@ -196,7 +196,7 @@ static struct {
>  	{ XFER_PIO_0,			"XFER_PIO_0" },
>  	{ XFER_PIO_SLOW,		"XFER_PIO_SLOW" }
>  };
> -ata_bitfield_name_match(xfer,ata_xfer_names)
> +ata_bitfield_name_search(xfer, ata_xfer_names)
>  
>  /*
>   * ATA Port attributes


-- 
Damien Le Moal
Western Digital Research
