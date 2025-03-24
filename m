Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA4802
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822533; cv=none; b=dtWbTJKA5gZngVYKRDUP/KwO4yeTeD7CyaQ34lLoTAih4i0ANWKrRt6LO/WkBUsIf+Z3el5IU/A6cnADbd5Utpo9jTJZcjp7lbRENZeeK2fFuvkfjvwnXAQ9wvaRFaJFevacKj8vkFxrJzJZ1uGoLGXrCuKq421Cl9L4FloEsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822533; c=relaxed/simple;
	bh=i1XKwX+9HeRav3Y+xuPOHeamNCFkO9DYG+SjERgnylM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDp/6GkS2i09Z2PiJUM/erhbmg6SYuJxpv8AHThLzd0KuRoWXnjOwDZNXQb/Ojcqm4di1EZpF4EvSqNspciaeE0r7gD/OpqHCmm+t/x1foAOyIPbXhwkYjY9NWnHmLnasV5/rnqoMrVgqDJzWy/cwJjGEr/zeV5lPpbLuvfe2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523eb86b31aso1825331e0c.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 06:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822530; x=1743427330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3vM1FQGsYOgCMm5GZoL9ZjRBchcaCoOlh/TAPpEk4Y=;
        b=IwlXCm60zAN24ANkXdR4/APhcz5cXXu8vXsdJwImMIEJSN+uVVM9UsNyxVAIJximZ5
         6DhGdZOksdgul6/4Vvf77tDsLZzrICAf7u5N0nkZpcGUWAC5jsyrIukO4zg9DCRBje7f
         iBekylHtX4LSafqegjaNF/ogW/umHIdave1hWWeSM73lXLKDSmstTn6sg1wxBpnsUERf
         NYVguSS7btt0WP5ZlVoEpLa4f7VMjRToFUdSjSdZvDSyvQcd5bJc42TN8bRCbWc5pXGY
         rhFpSbe2eR4fq7o9tnFN6/MuNnPom3s9Upgz6pO1q+by3lJaQeVxvwF5JyFcyxialLrq
         8eDg==
X-Forwarded-Encrypted: i=1; AJvYcCXhWkrjoaJQyBtmDymJ0jhHp4Lk3t3baZYLPg/u4OPYSW0sq0dYbOLlPHobHfQFvHeVrPn/auzQ7hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4Bn9PwoA/9wcB+6Z6qNyDI6a8Qr2nO/ge6/sedDlCCbkInMv
	zY1FFP2qEQE3hHlUnmu4WBFwfLU0vAPkPMNp7xAsTg55jifmPUQ6somDi97Z
X-Gm-Gg: ASbGncvMDa44dZ1fuH0A/okR5DRhPiNwQYUosaHNld5iqlsEaOAdLJrJ4fCmP14HRdT
	V+FyfH+IIEqxsnxW7iJDWbp8Za0H02ZUuGntFSOxEusIpSxTNldHCb51/0/2okv8lmF6JWVEFZQ
	3tw6Pdy0jebANdcTZ1FP1Az2Xa7h6OGKiNGqHHcLdgqkid6uVDBhlQXiPvssS4AkE6tnwVeen7a
	a3cJRKbcX+wndqZIJvqsNUJlywW25fjXRB0gTVEXyV7cgyyeqjOzpB+gwlHDaHIdtv44EGlryvc
	t+PD8jWzNCeavjUXQQZ5GCZSMKqThvhb8No6GYslMYzz6U0vdsUK2yrpTW+EFSfjcKEH+9zuKm8
	w4fwHpGY=
X-Google-Smtp-Source: AGHT+IFVdYebeiaGJ5eCHrtYftGmh/MHFLpU6Iyttf+uaxZATkWttdKA8maHsOC/8Wdv5sCiLnsvjw==
X-Received: by 2002:a05:6122:507:b0:520:5a87:6717 with SMTP id 71dfb90a1353d-525a80ccc98mr7978493e0c.0.1742822529932;
        Mon, 24 Mar 2025 06:22:09 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a76456cesm1353914e0c.34.2025.03.24.06.22.09
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 06:22:09 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8670fd79990so1728893241.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 06:22:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaykJ94QOGZuhzyX7HePuy/aiN0E+37x3bvKNpDSftx4Ebe/JcYtx2aGRS9LtAbjMMQ/Bqj7r/l9g=@vger.kernel.org
X-Received: by 2002:a05:6102:32c5:b0:4bb:e36f:6a30 with SMTP id
 ada2fe7eead31-4c50d5471femr6234904137.15.1742822529274; Mon, 24 Mar 2025
 06:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324121645.208368-1-p.pisati@gmail.com> <20250324121645.208368-2-p.pisati@gmail.com>
In-Reply-To: <20250324121645.208368-2-p.pisati@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 14:21:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8WUyUsjG4FaT4nP82pZYVFsUpYNOg2vsPPOthf-O49A@mail.gmail.com>
X-Gm-Features: AQ5f1JossREYSfwY4h6KKaFrE0JTJJQ8uMnSZiWGXPrBjpzoTjpi3VGEJ_Yivrw
Message-ID: <CAMuHMdW8WUyUsjG4FaT4nP82pZYVFsUpYNOg2vsPPOthf-O49A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Mon, 24 Mar 2025 at 13:16, Paolo Pisati <p.pisati@gmail.com> wrote:
> Driver for the on-board IDE interface on CS-Lab Warp Expansion Card
> (NOTE that idemode=native has to be set in Warp Configuration)
>
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

Thanks for your patch!

> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1025,6 +1025,17 @@ config PATA_GAYLE
>
>           If unsure, say N.
>
> +config PATA_CSWARP
> +       tristate "Amiga CS Warp PATA support"
> +       depends on M68K && AMIGA

&& ZORRO?

> +       help
> +         This option enables support for the on-board IDE interface on
> +         CS-Lab Warp Expansion Card (NOTE that idemode=native has to be
> +         set in Warp Configuration)
> +
> +         If unsure, say N.
> +
> +
>  config PATA_BUDDHA
>         tristate "Buddha/Catweasel/X-Surf PATA support"
>         depends on ZORRO

> --- /dev/null
> +++ b/drivers/ata/pata_cswarp.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Amiga CS Warp PATA controller driver
> + *
> + * Copyright (c) 2024 CS-Lab s.c.
> + *             http://www.cs-lab.eu
> + *
> + * Based on pata_gayle.c, pata_buddha.c and warpATA.device:
> + *
> + *     Created 2 Jun 2024 by Andrzej Rogozynski
> + */
> +
> +#include <linux/ata.h>
> +#include <linux/blkdev.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/libata.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/zorro.h>
> +#include <scsi/scsi_cmnd.h>
> +#include <scsi/scsi_host.h>
> +
> +#include <asm/amigahw.h>
> +#include <asm/amigaints.h>
> +#include <asm/amigayle.h>
> +#include <asm/setup.h>
> +
> +#define DRV_NAME "pata_cswarp"
> +
> +#define WARP_OFFSET_ATA         0x6000
> +
> +static const struct scsi_host_template pata_cswarp_sht = {
> +       ATA_PIO_SHT(DRV_NAME),
> +};
> +
> +static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
> +                                        unsigned char *buf,
> +                                        unsigned int buflen, int rw)

It is a pity ata_port_operations.sff_data_xfer() doesn't take a void *buf,
else the casts below can be dropped.

Until that has changed, I think it is worthwhile to do the cast only once,
by introducing a temporary variable:

    u16 *buf16 = (u16 *)buf;

> +{
> +       struct ata_device *dev = qc->dev;
> +       struct ata_port *ap = dev->link->ap;
> +       void __iomem *data_addr = ap->ioaddr.data_addr;

"volatile void __iomem *data_addr ...", so you can drop the casts below.

> +       unsigned int words = buflen >> 1;
> +
> +       /* Transfer multiple of 2 bytes */
> +       if (rw == READ)
> +               raw_insw((u16 *)data_addr, (u16 *)buf, words);
> +       else
> +               raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> +
> +       /* Transfer trailing byte, if any. */
> +       if (unlikely(buflen & 0x01)) {
> +               unsigned char pad[2] = { };
> +
> +               /* Point buf to the tail of buffer */
> +               buf += buflen - 1;

buf16 += words;

> +
> +               if (rw == READ) {
> +                       raw_insw((u16 *)data_addr, (u16 *)pad, 1);

No need to loop, just use raw_inw() for a single word.

> +                       *buf = pad[0];
> +               } else {
> +                       pad[0] = *buf;
> +                       raw_outsw((u16 *)data_addr, (u16 *)pad, 1);

likewise, raw_outw().

> +               }
> +               words++;
> +       }
> +
> +       return words << 1;

This can be one more than buflen, when the latter is odd.
Why not just return buflen instead?

> +}

> +static int pata_cswarp_probe(struct zorro_dev *z,
> +                            const struct zorro_device_id *ent)
> +{
> +       static const char board_name[] = "csWarp";
> +       struct ata_host *host;
> +       struct ata_port *ap;
> +       void __iomem *cswarp_ctrl_board, *base;
> +       unsigned long board = z->resource.start;
> +
> +       dev_info(&z->dev, "%s IDE controller (board: 0x%lx)\n", board_name,
> +                board);
> +
> +       if (!devm_request_mem_region(&z->dev, board + WARP_OFFSET_ATA, 0x1800,
> +                                    DRV_NAME))
> +               return -ENXIO;
> +
> +       host = ata_host_alloc(&z->dev, 1);
> +       if (!host)
> +               return -ENXIO;
> +
> +       cswarp_ctrl_board = (void *)board;

ioremap(board + WARP_OFFSET_ATA, ...)?

> +
> +       ap = host->ports[0];
> +       base = cswarp_ctrl_board + WARP_OFFSET_ATA;
> +
> +       ap->ops = &pata_cswarp_ops;
> +
> +       ap->pio_mask = ATA_PIO4;
> +       ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY |
> +               ATA_FLAG_PIO_POLLING;
> +
> +       ap->ioaddr.data_addr            = base;
> +       ap->ioaddr.error_addr           = base + 1 * 4;
> +       ap->ioaddr.feature_addr         = base + 1 * 4;
> +       ap->ioaddr.nsect_addr           = base + 2 * 4;
> +       ap->ioaddr.lbal_addr            = base + 3 * 4;
> +       ap->ioaddr.lbam_addr            = base + 4 * 4;
> +       ap->ioaddr.lbah_addr            = base + 5 * 4;
> +       ap->ioaddr.device_addr          = base + 6 * 4;
> +       ap->ioaddr.status_addr          = base + 7 * 4;
> +       ap->ioaddr.command_addr         = base + 7 * 4;
> +
> +       ap->ioaddr.altstatus_addr       = base + (0x1000 | (6UL << 2));
> +       ap->ioaddr.ctl_addr             = base + (0x1000 | (6UL << 2));
> +
> +       ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> +                     (unsigned long)ap->ioaddr.ctl_addr);

These two printed addresses are virtual addresses.
However, due to the use of a cast instead of ioremap(), they are identical.
Still, I think it is better to print board + WARP_OFFSET_ATA and
board + WARP_OFFSET_ATA + 0x1000 | (6UL << 2) instead.

> +
> +       return ata_host_activate(host, 0, NULL,
> +                         IRQF_SHARED, &pata_cswarp_sht);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
