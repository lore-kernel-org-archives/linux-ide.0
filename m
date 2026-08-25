Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943523E33D
	for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644413; cv=none; b=TauxyZ7elePEsKZw/SE5ZC1dWonAhvE+ODGoebh3vJc1U/ypW2V/ZFW0/8+SacVCwS9KNdvFchElgbE3ePBJzhAn6/XAst/HZpJCi+wprwTcLunBPlQO2Osh+KmcKlqc5o0F76rVCx++BaQpO1FyasnLbSQHUytNjUOD7UjgFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644413; c=relaxed/simple;
	bh=5KhXHGIN/5OkJ5Z05vnUucjZaP7hvHBv6uFtz8zGhxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+3MRtlmYHtEUOW8DzqNgcX1bQCgVZaNYPULPRjo3qjOr4ERLql0KRR7s/4zAnH/gmZQeFDMdUYw60BVbKN1oZ/ZC18T61DLBiOt3H32RRyx0TBGryy0e0N40SRyOJGkOxBQmIKC8UkJXL8rLh8V0z+IWnzV8sCKRiy+0zosUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso1715886e0c.2
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 00:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787644411; x=1788249211;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mY3Cs/1+UNEYSIVcDUnJkc5JJKs/5ezwJVqk+SnL2Uk=;
        b=Bv9krjFcjTI6sGhFl6jPso5TXE63gN8/asgmCn2Ll2xv+wMjIVwhldIVdEsYvN4YVz
         gUviXlRd1FAY1Oo/HxXRNZlSF4DgF8M+QOt9cM22/CRAzH6+SO7FzdlZ2WOP6xU+0ela
         7PUbW666cCIjeTnt5j4YvAR38j7LrGD9Pjc566nrtUEXs1PsXkF/84BUqFWppKm6WXVS
         ikh17EDm6f+W/FQWb7+Z8flu/RYfFcUURemzbZqJKZi9c5lOql+yg8jrtOZtuxWDHszB
         jJsdbZT7fCJX0J51kN1+6hE6S9LMdPSrWUfLzt68eWQMpO170TG5ldve/yTMMnfdCZBX
         oPJA==
X-Forwarded-Encrypted: i=1; AHgh+RpgHm3QPifTVoceeu7eYt+3N3eiD4aOgwj4Sairb2j0V3LXaSRkDLsMFECHixRvJSityQdZG965io8=@vger.kernel.org
X-Gm-Message-State: AFuF++k9kN30WiSR/OV0hb0/yanhNlUOsBQ6WZQ4kVEeMhtB8jDvm1Ce
	fUt2IhlusoTzmAwIjIsn/w0CZ3iucOl5Bdzsf4r69f3gsV8G3n9IbvGg5YeBwZ0b108=
X-Gm-Gg: AR+sD11v+JSIJwgqoAwH1oQbL2jSwVJjhlT17k2INEf1xTGhwjrDdraXtCMcnpjWGFK
	3WxoA0ICv1g4dNsD8qQ95WoWp1GWy2H+CLWSHKWW0kSkzLTjR6fVw4GYGD7VX2MRaex8J52FFGR
	l1SScS2FlboF/ck5t8XAhUXlDPoRyGnCZebP5P9DJpN5K7yqHv0ez3SHXzK+fQHk320/wEvM9Qx
	t37ZVvWKrZTCF8fFDe+iT3oC8Nw0RjmdLorNPYJAAd7GKrNTemT/vrmrm2zDTTflNzLunp9yahi
	RG96cCg0gVesbKqKwXuJnNf3suN44OIonpNsHGcklRFJaIxmAQ82EZh1zVr0k3Fvfex+gqKhFB9
	rHE3SyFKmiC6czJ9F768kAlbfi1f1Dn/ISl0j6IUJ/07jqFvyIVTh0C09EWZTtjhxEtyWNC3sQ8
	TntHvDZt8VdF/IyxaOAOk5BxQAqd3AhTGkha4L7QsIGmqnaRCdRPaCxovfMvjFRco6kVKnCkjFO
	a6OHRYyN59btmWPEWRmP3JxOiO3X+qSy1uurw==
X-Received: by 2002:a05:6122:50c:b0:5bd:b27c:bade with SMTP id 71dfb90a1353d-5c5ff6f5c08mr13082991e0c.5.1787644410861;
        Tue, 25 Aug 2026 00:53:30 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623eb6ae3sm5749113e0c.9.2026.08.25.00.53.30
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 00:53:30 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1487258137.3
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 00:53:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpXdk3xZaW6UupJfRcC66VZ8JmE70oUVZ2slnrEnJzQCHlzWbqjEoHPj18C/lyK6rFjYix17Z84HMg=@vger.kernel.org
X-Received: by 2002:a05:6102:5107:b0:778:4c28:6725 with SMTP id
 ada2fe7eead31-77a6434bfc4mr9347978137.10.1787644410431; Tue, 25 Aug 2026
 00:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153339.512487-1-p.pisati@gmail.com> <20260824153339.512487-2-p.pisati@gmail.com>
In-Reply-To: <20260824153339.512487-2-p.pisati@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 09:53:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
X-Gm-Features: AcwNN1XJGQsJg3rTyiIM7ZxTIkOAoql-OOJhHfZeWEVlRKB_glDBvnY_i5ovn3w
Message-ID: <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Mon, 24 Aug 2026 at 17:33, Paolo Pisati <p.pisati@gmail.com> wrote:
> Driver for the on-board IDE interface on CS-Lab Warp Expansion Card
> (NOTE that idemode=native has to be set in Warp Configuration)
>
> Assisted-by: Claude_Code:claude-opus-5
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

Thanks for the update!

> --- /dev/null
> +++ b/drivers/ata/pata_cswarp.c

> +static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
> +                                         unsigned char *buf,
> +                                         unsigned int buflen, int rw)
> +{
> +       struct ata_device *dev = qc->dev;
> +       struct ata_port *ap = dev->link->ap;
> +       void __iomem *data_addr = ap->ioaddr.data_addr;
> +       unsigned int words = buflen >> 1;
> +       u16 *buf16 = (u16 *)buf;
> +
> +       /* Transfer multiple of 2 bytes */
> +       if (rw == READ)
> +               raw_insw(data_addr, buf16, words);
> +       else
> +               raw_outsw(data_addr, buf16, words);
> +
> +       /* Transfer trailing byte, if any. */
> +       if (unlikely(buflen & 0x01)) {
> +               if (rw == READ)
> +                       buf[buflen - 1] = raw_inw(data_addr) >> 8;
> +               else
> +                       raw_outw(buf[buflen - 1] << 8, data_addr);
> +               words++;
> +       }
> +
> +       return words << 1;

This may be one less than the actual number of bytes
Why not buflen?

> +}

> +static int pata_cswarp_probe(struct zorro_dev *z,
> +                            const struct zorro_device_id *ent)
> +{
> +       static const char board_name[] = "csWarp";
> +       struct ata_host *host;
> +       struct ata_port *ap;
> +       void __iomem *base;
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
> +       ap = host->ports[0];
> +       base = ioremap(board + WARP_OFFSET_ATA, 0x1800);
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

Both printed addresses are virtual addresses hence not really useful.
If you want to print something, please print board or z->resource
instead.

> +static const struct zorro_device_id pata_cswarp_zorro_tbl[] = {
> +       { ZORRO_PROD_CSLAB_WARP_1260, 0},
> +       { 0 }

Please use named initializers, and drop unneeded zeroes, like Uwe
just did in all existing Zorro drivers:

    { .id = ZORRO_PROD_CSLAB_WARP_1260 },
    { }

> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
