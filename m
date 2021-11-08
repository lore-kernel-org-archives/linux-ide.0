Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF3C433EF
	for <linux-ide@archiver.kernel.org>; Mon,  8 Nov 2021 09:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0463461177
	for <linux-ide@archiver.kernel.org>; Mon,  8 Nov 2021 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhKHJuw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:50:52 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:33353 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhKHJuv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Nov 2021 04:50:51 -0500
Received: by mail-ua1-f54.google.com with SMTP id b17so30352729uas.0
        for <linux-ide@vger.kernel.org>; Mon, 08 Nov 2021 01:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+G1BoFH/K0IEpWBda0X2B6oMyXJ/QnFcYIm1ebjWCNs=;
        b=fc2arcdFtrHOprLPB334nLNjyoH4B4lqEzrOYUbYuUq/bjQV+6wtwXHS7CcubHl5U4
         ZsdqHe6/wPFRsdHFup0wgK74pbsbZ6/hCpSEQD5PaMd0IIXE878gV73xUzWMXEYJuASN
         03haBB1rWREKYfM3gX6DKpKm7n8wELvpcCTba5gTNh0qjp9TdYQiGM+CQLiIQwHwPjBS
         XIoGTZ2mXub0ddH3N1c7Lg2IMvaJbGWVww64/yjqlcxfrrFNpXL5/x279f2KlF7w0cVk
         kwZD770X6MigNjuy0d45jTcGxyQi0hKDMy9fBznI/8+zvx3+LAZYA1y4h7hDWWz5NoIj
         spSA==
X-Gm-Message-State: AOAM533L8BfGvk3bdhP0lzBqLOCOcTS+a++Xa+UlalR9alwCyNHnWdcR
        MYw2esRE8AQDj1pppUxufs6dBagnNPlsHg==
X-Google-Smtp-Source: ABdhPJx9hJw4nTDzK+YgkbBmXuX9vvkXOOnhw4bZZzCsUZlAmL+6S9a80ADJd1V3hMKqyl/lhMWFFw==
X-Received: by 2002:a67:e40d:: with SMTP id d13mr48166156vsf.11.1636364887140;
        Mon, 08 Nov 2021 01:48:07 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id u145sm1994634vsu.25.2021.11.08.01.48.06
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 01:48:06 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id u130so7862385vku.2
        for <linux-ide@vger.kernel.org>; Mon, 08 Nov 2021 01:48:06 -0800 (PST)
X-Received: by 2002:a05:6122:50e:: with SMTP id x14mr19801148vko.7.1636364886638;
 Mon, 08 Nov 2021 01:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20211105073106.422623-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20211105073106.422623-1-damien.lemoal@opensource.wdc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Nov 2021 10:47:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWj0tpaHz0uu9Lvc5ErHsZCt3vWB0rN_3n-sgaqpCwdzA@mail.gmail.com>
Message-ID: <CAMuHMdWj0tpaHz0uu9Lvc5ErHsZCt3vWB0rN_3n-sgaqpCwdzA@mail.gmail.com>
Subject: Re: [PATCH] libata: fix read log timeout value
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Damien,

On Fri, Nov 5, 2021 at 8:31 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> Some ATA drives are very slow to respond to READ_LOG_EXT and
> READ_LOG_DMA_EXT commands issued from ata_dev_configure() when the
> device is revalidated right after resuming a system or inserting the
> ATA adapter driver (e.g. ahci). The default 5s timeout
> (ATA_EH_CMD_DFL_TIMEOUT) used for these commands is too short, causing
> errors during the device configuration. Ex:
>
> ...
> ata9: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200400 irq 209
> ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata9.00: ATA-9: XXX  XXXXXXXXXXXXXXX, XXXXXXXX, max UDMA/133
> ata9.00: qc timeout (cmd 0x2f)
> ata9.00: Read log page 0x00 failed, Emask 0x4
> ata9.00: Read log page 0x00 failed, Emask 0x40
> ata9.00: NCQ Send/Recv Log not supported
> ata9.00: Read log page 0x08 failed, Emask 0x40
> ata9.00: 27344764928 sectors, multi 16: LBA48 NCQ (depth 32), AA
> ata9.00: Read log page 0x00 failed, Emask 0x40
> ata9.00: ATA Identify Device Log not supported
> ata9.00: failed to set xfermode (err_mask=0x40)
> ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata9.00: configured for UDMA/133
> ...
>
> The timeoutout error causes a soft reset of the drive link, followed in

timeout

> most cases by a successful revalidation as that give enough time to the
> drive to become fully ready to quickly process the read log commands.
> However, in some cases, this also fails resulting in the device being
> dropped.
>
> Fix this by using adding the ata_eh_revalidate_timeouts entries for the
> READ_LOG_EXT and READ_LOG_DMA_EXT commands. This defines a timeout
> increased to 15s, retriable one time.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Thanks for your patch! Impact on system resume on Salvator-XS:

s2idle:

     ata1: link resume succeeded after 1 retries
     ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
    -ata1.00: qc timeout (cmd 0x2f)
    -ata1.00: Read log page 0x00 failed, Emask 0x4
    -ata1.00: ATA Identify Device Log not supported
    -ata1.00: failed to set xfermode (err_mask=0x40)
    -ata1: link resume succeeded after 1 retries
    -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
     ata1.00: ATA Identify Device Log not supported
     ata1.00: ATA Identify Device Log not supported
     ata1.00: configured for UDMA/133

s2ram:

     ata1: link resume succeeded after 1 retries
     ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
    -ata1.00: qc timeout (cmd 0x2f)
    -ata1.00: Read log page 0x00 failed, Emask 0x4
    -ata1.00: ATA Identify Device Log not supported
    -ata1.00: failed to set xfermode (err_mask=0x40)
    -ata1: link resume succeeded after 1 retries
    -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
    -ata1.00: NODEV after polling detection
    -ata1.00: revalidation failed (errno=-2)
    -ata1: link resume succeeded after 1 retries
    -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
     ata1.00: ATA Identify Device Log not supported
     ata1.00: ATA Identify Device Log not supported
     ata1.00: configured for UDMA/133

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
