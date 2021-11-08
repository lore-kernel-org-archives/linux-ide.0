Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD7C433EF
	for <linux-ide@archiver.kernel.org>; Mon,  8 Nov 2021 21:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F1A613B3
	for <linux-ide@archiver.kernel.org>; Mon,  8 Nov 2021 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhKHVlJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:41:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52975 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhKHVlI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Nov 2021 16:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636407503; x=1667943503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=58lOn81ArFc2Bpnw/mc37V+k/UjvFnqV7H40W/MYwOA=;
  b=oDS3339qZXpa1EnlwZHX+Nobnp9NErE4xTzb9vwSHoLMF2cXy1X/c8X8
   c6uZBYe1Ae8L41KJ8JZ3eDbDP+XLkRR0VLmImrMoBUgeRfvCn8gTMitlO
   l0Xa4Q3sZtrNaMixdTzvC47xTxQ9zPy5o6/0QoTCImpJZeLE7vDID2wOA
   Fbw/TqtQNPcK4yIqrelg+Xb50pbHzOIpwH5xJ72gA8MvqsxDG5w9RActR
   57ZtskesrqAhFhyEJXN2nnINq5otVCLadHwRFEjBWD1E2Wy99GTaXBcVc
   mkc/Z1q7Sxl5wwBDjDwHPC0mZd693o9MtVMONaA8uu2wyJw4XyOFmhXW3
   A==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631548800"; 
   d="scan'208";a="184048501"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 05:38:22 +0800
IronPort-SDR: Y58TovDXETcvekAI/1DWDl3YrYsp792x0ZH6UFdpDb7j551Zda3IWrELNE75LinR+BtoKikLEk
 luTQWFdIZww12md9UHuku4s3N/49fdz7v7+ldrPnsDYHY0wwJ4z+tFIMvhrjFiEhLcgN4e2Iod
 GRmsevtAl6WnE0eJGANY+CzsRRQsLslwpkfzHPaAciZ+hD4NDIkHxSFui2CGQfVBnj25sKI7SA
 f/9EWhilSa72qGZUs30xCrtcF0HowZHiuQTErsC8YNE0iVk+HBVmQeqH29y6gIDIVUzQrUReEU
 O4REGUiUCUbHHS/CffIqQSSa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 13:13:35 -0800
IronPort-SDR: Mfk86/0VLzPXrhfLAalN6jWJw0vV5y/x55IPwWaktObWMBU+yNBx2T1QWoROZVDcmYdDDEXu5F
 rSVJqS/u1kEiTiOj7VVK5cEwLiCNFYdsnElZCmEo4VEam09MzbCzHQFwPatcYGOXmmHvpRUw0R
 fk3k4eIDJbxd8WYyNLanrBixOXS3mK62T1hfRRjDtKwDpuLCZLZFzHgnkisdOceR4hyueMqV+g
 YTLbxj3wjqQycfpzizF3oQwoeIbfhV6ueHyi+IudnP6C23u6G+4vBdzEm7q1bBfysqYvnaqtfU
 WhM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 13:38:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hp4H254YJz1RtVn
        for <linux-ide@vger.kernel.org>; Mon,  8 Nov 2021 13:38:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636407502; x=1638999503; bh=58lOn81ArFc2Bpnw/mc37V+k/UjvFnqV7H4
        0W/MYwOA=; b=b7Y6B4hrmUqMmKuyap+8z4MewGrAhDlJmgMlTSfHZhNA2ADTvMG
        khIlEMboYGszi7O03dCfoQZ3/RyXJfNVfgc1aRS4hsHp+g4nI+BAx21STKtVMXKL
        jDw7FSzQ9fIZOPBNFEX8VpFHAibo1Zaz7Up4uoNVl9e0gpD37UPqs+6h+1Qq9otP
        Cc0TarDSt+aW2bKAGO03SGx7fxyzVLqu82RxBSURgdXNA0WazvH1yFSAMe/XELlZ
        f2Cqt+qjLkjhZolNNxw6YLWml/IGSqEmWwmDYvWyG7JosoEhYkSTTYv0/m90/lyn
        +AXWK/onDh3Im5t8aTQ6lVsgW8u4CuWWsww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yNx5gML-OPFd for <linux-ide@vger.kernel.org>;
        Mon,  8 Nov 2021 13:38:22 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hp4H152Cxz1RtVl;
        Mon,  8 Nov 2021 13:38:21 -0800 (PST)
Message-ID: <73287bbd-1ff9-8b4f-5ced-1eecd56e9731@opensource.wdc.com>
Date:   Tue, 9 Nov 2021 06:38:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] libata: fix read log timeout value
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20211105073106.422623-1-damien.lemoal@opensource.wdc.com>
 <CAMuHMdWj0tpaHz0uu9Lvc5ErHsZCt3vWB0rN_3n-sgaqpCwdzA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAMuHMdWj0tpaHz0uu9Lvc5ErHsZCt3vWB0rN_3n-sgaqpCwdzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/08 18:47, Geert Uytterhoeven wrote:
> Hi Damien,
> 
> On Fri, Nov 5, 2021 at 8:31 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>> Some ATA drives are very slow to respond to READ_LOG_EXT and
>> READ_LOG_DMA_EXT commands issued from ata_dev_configure() when the
>> device is revalidated right after resuming a system or inserting the
>> ATA adapter driver (e.g. ahci). The default 5s timeout
>> (ATA_EH_CMD_DFL_TIMEOUT) used for these commands is too short, causing
>> errors during the device configuration. Ex:
>>
>> ...
>> ata9: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200400 irq 209
>> ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> ata9.00: ATA-9: XXX  XXXXXXXXXXXXXXX, XXXXXXXX, max UDMA/133
>> ata9.00: qc timeout (cmd 0x2f)
>> ata9.00: Read log page 0x00 failed, Emask 0x4
>> ata9.00: Read log page 0x00 failed, Emask 0x40
>> ata9.00: NCQ Send/Recv Log not supported
>> ata9.00: Read log page 0x08 failed, Emask 0x40
>> ata9.00: 27344764928 sectors, multi 16: LBA48 NCQ (depth 32), AA
>> ata9.00: Read log page 0x00 failed, Emask 0x40
>> ata9.00: ATA Identify Device Log not supported
>> ata9.00: failed to set xfermode (err_mask=0x40)
>> ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> ata9.00: configured for UDMA/133
>> ...
>>
>> The timeoutout error causes a soft reset of the drive link, followed in
> 
> timeout
> 
>> most cases by a successful revalidation as that give enough time to the
>> drive to become fully ready to quickly process the read log commands.
>> However, in some cases, this also fails resulting in the device being
>> dropped.
>>
>> Fix this by using adding the ata_eh_revalidate_timeouts entries for the
>> READ_LOG_EXT and READ_LOG_DMA_EXT commands. This defines a timeout
>> increased to 15s, retriable one time.
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Thanks for your patch! Impact on system resume on Salvator-XS:
> 
> s2idle:
> 
>      ata1: link resume succeeded after 1 retries
>      ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>     -ata1.00: qc timeout (cmd 0x2f)
>     -ata1.00: Read log page 0x00 failed, Emask 0x4
>     -ata1.00: ATA Identify Device Log not supported
>     -ata1.00: failed to set xfermode (err_mask=0x40)
>     -ata1: link resume succeeded after 1 retries
>     -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>      ata1.00: ATA Identify Device Log not supported
>      ata1.00: ATA Identify Device Log not supported
>      ata1.00: configured for UDMA/133
> 
> s2ram:
> 
>      ata1: link resume succeeded after 1 retries
>      ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>     -ata1.00: qc timeout (cmd 0x2f)
>     -ata1.00: Read log page 0x00 failed, Emask 0x4
>     -ata1.00: ATA Identify Device Log not supported
>     -ata1.00: failed to set xfermode (err_mask=0x40)
>     -ata1: link resume succeeded after 1 retries
>     -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>     -ata1.00: NODEV after polling detection
>     -ata1.00: revalidation failed (errno=-2)
>     -ata1: link resume succeeded after 1 retries
>     -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>      ata1.00: ATA Identify Device Log not supported
>      ata1.00: ATA Identify Device Log not supported
>      ata1.00: configured for UDMA/133
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Great ! Thanks for testing.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Damien Le Moal
Western Digital Research
