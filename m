Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B901192D6B
	for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268200; cv=none; b=gB3fhd1qNV6hxMwMKLS4eOGipmZhtgJcRKLSV7YZXjVr7DIcDkE6Q1lA1yYxl1PH4ZwZ7+i0Bciwhxepwo+pRbq8cQOMLBhrtg6ZROO32oTNOQ65fsaWrl9UzgYXs8IEk7CL7xiKJ1v7WmX6jDAMsLLh0k4ALBazvcs64K96Xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268200; c=relaxed/simple;
	bh=4uwmKY8ceyp5QZIETjyzQVGHEV2zJROKskLaX8nRfK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbORrsx3Ott0wo/sUxPf0YeMlcZsanUK3sXhwy2Y/+Tp/wmfHtqh2Kyazv1B3uvIarI06YEESUv6YmquFyGnJft30UsOfK8nSJFguRLZBGyLTbJS0wb90uM050kbM9phwrEOu7PGkJONwbX0rv5biHufLgKwMZI+/KD/hsUPnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-400fa6b3012so1912697b6e.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 07:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268197; x=1748872997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCDcsKvq+RIBVrcv2PcCRyfsJ/lOeLLPLluC6HPp9QY=;
        b=RX85P2ovBCdYRs3/F25e+mOK7jMxQJwO+Av3H9T9nfAmsAmnyRatQwt9c3+XSSkESw
         MvNOOfLi7uZVmzA/6QCVhxZRvRm/UIORuILUeaWfSo90ct2nn1Ex16iouxFSBm5aIpC1
         B/nNeirFp5dhH+HdnpfBpW4PbaD83lXwRaVlKWPysyfkBPZZ3FolmCAQIiv4CvROaPzq
         3cFuKqzM5z5b9mNUGOVMBdtV3iw3wsbArljPOD6CPUbP+FDG3newaFQO6BwyO5B9ZJ+j
         p7P+akDbcik6xDgVDUPGMd6WYDgQT8DcQj/yZw/JfXkJ0JtsH7kpbABMmkbN8o4sPJdx
         Qeig==
X-Forwarded-Encrypted: i=1; AJvYcCWADWkwtIG9f7emEyS3asflFWDhNONHDpGY+/6SPiHKSolP6iMdk9bfTqWUwzBh5chIbwdqSq1b5Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGmt5LYxrHIJ93GAyEjNQ25J+flbefpjesfdf6nSi525hgEM5
	oc02h/UkNerEocp1m1o+T+j//pwIKM21rp0fXNVcl2mvj5KuPdBhwuyZNGO9iWjj
X-Gm-Gg: ASbGncsT8/OWD0uXldfHJ2e18sgQEDdmAmWN2m80ZrVyUZx65pIKh/8sBHPt/809tqG
	25QN9LDjdWFBaRICQOr8cNqws/K6v8bJNkCoHZewFWTD0xiwveEMEfTIZXZ9xmRuO62lYdQW9fu
	OEcDnIB5h4jVZaAHz0oYF5bIu3ElrwMafRry6ec9lFQ+VS21U3QQAm64qN4/k7l/UFXKkgS5HEl
	zb9i6YW7NEUE4BGTsOHrG711GnxREN5vUnX4R3dKgeBenCQogGML4/Q9sHjKHDkF054gad/Za1u
	7GOa91hJM8ayoTpU70RKn0oyRKS9AsmyUmu2lJ2GoU1PjzXe5oIxL+bTP+5sy4ezpNFQg2efbYq
	QaT/Hox8YC33ua3qo5Q==
X-Google-Smtp-Source: AGHT+IHQVvEWThsd1hWQ4L027sh7YyxjMAMyiiCYQzM/61WkZ9DrfdEi6T6v2KrRmCXOg3yAUjTvkg==
X-Received: by 2002:a05:6808:384d:b0:3ec:bf55:e33f with SMTP id 5614622812f47-40645fb2aefmr5804810b6e.9.1748268197418;
        Mon, 26 May 2025 07:03:17 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404d98cef5bsm4207694b6e.44.2025.05.26.07.03.16
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 07:03:17 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-400fa6b3012so1912659b6e.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 07:03:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9tr1Ke70E9i0XJ4w2cHkAEV2il9W09agqn0twH/N3BBYvzdhzLDqJyFnG/mGUQMDKUqVdVINM730=@vger.kernel.org
X-Received: by 2002:a05:6808:251a:b0:401:bb42:700c with SMTP id
 5614622812f47-4063d081bb6mr7483547b6e.19.1748268196551; Mon, 26 May 2025
 07:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325155613.352680-1-p.pisati@gmail.com> <20250325155613.352680-2-p.pisati@gmail.com>
In-Reply-To: <20250325155613.352680-2-p.pisati@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 May 2025 16:03:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXyEyPMfd4wcqY+zfaqP0HeYBaDys_Twr9CEUxoNmisJA@mail.gmail.com>
X-Gm-Features: AX0GCFs7dpfswD8kmPFapTEn6ylOYXr6DaNHDFXbjxZW0U0ngEUN35FxjwqP30U
Message-ID: <CAMuHMdXyEyPMfd4wcqY+zfaqP0HeYBaDys_Twr9CEUxoNmisJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Tue, 25 Mar 2025 at 16:56, Paolo Pisati <p.pisati@gmail.com> wrote:
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
> +       depends on M68K && AMIGA && ZORRO
> +       help
> +         This option enables support for the on-board IDE interface on
> +         CS-Lab Warp Expansion Card (NOTE that idemode=native has to be
> +         set in Warp Configuration)
> +
> +         If unsure, say N.
> +
> +

Please drop one blank line.

>  config PATA_BUDDHA
>         tristate "Buddha/Catweasel/X-Surf PATA support"
>         depends on ZORRO

> index 000000000000..e0a0db6f7cfd
> --- /dev/null
> +++ b/drivers/ata/pata_cswarp.c

> +static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
> +                                        unsigned char *buf,
> +                                        unsigned int buflen, int rw)
> +{
> +       struct ata_device *dev = qc->dev;
> +       struct ata_port *ap = dev->link->ap;
> +       volatile void __iomem *data_addr = ap->ioaddr.data_addr;
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
> +               unsigned char pad[2] = { };
> +
> +               /* Point buf to the tail of buffer */
> +               buf16 += words;
> +
> +               if (rw == READ) {
> +                       *pad = raw_inw(data_addr);
> +                       *buf16 = pad[0];

This looks wrong to me: as *pad is the same as pad[0], you could just
eliminate the pad[] intermediate...
Moreover, this writes one byte too much into the buffer.

> +               } else {
> +                       pad[0] = *buf16;
> +                       raw_outw(*pad, data_addr);
> +               }

Comparing to what v3 did, I think you want:

    if (rw == READ)
            buf[buflen-1] = raw_inw(data_addr) >> 8;
    else
            raw_outw(buf[buflen-1] << 8, data_addr);

As all Amigas are big-endian, I think there is no need to implement
this using some endian conversion function.

> +       }
> +
> +       return buflen;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
