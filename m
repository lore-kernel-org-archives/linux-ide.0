Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598335C696
	for <linux-ide@vger.kernel.org>; Thu, 27 Aug 2026 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815769; cv=none; b=qLUGoHcbKeA2uR/DTKOiwYkfEEUMeyhMG9zh7Ep1Y5OUIKokK5yr+PXmPGnWFJ1wCVRsqJUOwMw2WroDH3NGZf9XqQhesGxO5pbRTwCXYXiVklVp+35qKCKrXz/sIOr/5tsOo16q1H7Ll3/pYfVw4Z5GwJW5dMt2z/Y+6GboIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815769; c=relaxed/simple;
	bh=mP+PND9MZnfOzg3J+drMZ/8E/kF9YudaTPVbTh6JzI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esyf6BU1tROufjNrZepQ5bHOxd/mU58/GJdCoaQJZiEL8FgGiIIbU8x3ILieyTj9lCz8caieUp9/Q31kFRqz1arDQa6Icv8IDF1EsG3xEWiZYvNvZ7JA8dV7ujrcgSxUFCWiF4Gv45BqrYgJ1nlGXtrs5YDhryGtWIEtln3P028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-77e35e008e8so643640137.1
        for <linux-ide@vger.kernel.org>; Thu, 27 Aug 2026 00:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787815766; x=1788420566;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A0FUFGzTaYR2pVts5J1GWb7YxO4YjT4Q+LUng3iGalw=;
        b=HInG4F30PHdpJOyq5Vv2kPqpCrYtYpTTwzilW3JiAA/yCSEp+v/6+SJKPtCeGkGWnZ
         ch8d3761S5B0teNQaCw2dJqikmjznIoLKXly54rl3ObQhhRJw9fZH8OMgB33inwd5szo
         jP/M2aXmw3sCiRoPKgt58Un9lIu4ymJo4RvU7gUUYMkLYN8jI15o6DgUH1sb2nH066jH
         d24Sy0TXUKeNpTO55BtVa61vY/OwA6543woEkYMtZZpDiq60+hOg7+zH/FRxeAknDMZ8
         sqlEWTbyhN6qzIJL4PPqUnhs4Zq7teaLW/L+2HmbAeut7YsXH7AP0hUNMJMXKOdN7L0k
         AIaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0GaxWVXkC3dgf6U0YtDMb1YMLwDummTBiLlPlJ63SqmefP5zr+QX0NU+o9ggm7yf1VC66fztvOvw=@vger.kernel.org
X-Gm-Message-State: AFuF++lIbGdNjQngvjLh95amzkpdxS5H+Wv3uDxp8qiFHVH9R0VcjdW9
	2nhBm4Lb8RYa0xWa9n3VzbTvmrOQb+DHneuHlYBKi36OIG50Ogh4awoGrs6rfghH
X-Gm-Gg: AR+sD13ZIPo/CgyeK4e7iyhT7vkFM9s5lZYZQhmqeJ5NwGRvhRZNvNSsN+DtoLwlXl1
	BGwrXaXAhpQk6I/UQWAG/drUhS5+UDZF3nGXVUZjuGx9yWMMvU2y2iLT1ZdC0Slv/zVCtylxPgM
	xrfxBCz64ggMjuI8Wb/ry2JmUEeZLrZfy0Vx8iORrM9CH8iWZVMCy7MoozvmytKNOmUJp8ayttG
	U3K+HYOgNdzCyMErHSVpnGS5mgK4sKuADbTyS5aumeStnekCyT7KpwTjifBQQpD0mc4wcPuIPgJ
	S93nMSOahs2xuNIZ7EKm+4IWY+mvL6y7x7zGiKqT4ROGvFExTePp/m//SJcszw2m+Y5zsruee4y
	Ys1hi1W+Kwdb6tfsN8mWVA9sUeoCKEz9g5c3R7hqprSxV6/8qhNw365aMA1sr8tvgHOJhXIOo13
	gO6Kji1EpawBV1Vu8o0eBmftSx5YudAir7oGEhRg2+a1jwKeYAXxKmGEjbAweSri6otOrjdLL5U
	RtEHEdHOnNVlNldRTfBBCnQ0Q==
X-Received: by 2002:a05:6102:2b85:b0:782:7519:ae8a with SMTP id ada2fe7eead31-7841d2495femr1188220137.3.1787815766588;
        Thu, 27 Aug 2026 00:29:26 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-783081c3988sm3877974137.11.2026.08.27.00.29.26
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:29:26 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so532417241.1
        for <linux-ide@vger.kernel.org>; Thu, 27 Aug 2026 00:29:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpqQlEQBwz+p80XzU3PNLhWMoc1xG/+ojffPXHyFTxWxcEaTfvomvPZMXSb/QY2Kc9ajRuu95ogMGk=@vger.kernel.org
X-Received: by 2002:a05:6102:2253:b0:783:c17c:e7de with SMTP id
 ada2fe7eead31-7841d55ca7bmr886817137.9.1787815766141; Thu, 27 Aug 2026
 00:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153339.512487-1-p.pisati@gmail.com> <20260824153339.512487-2-p.pisati@gmail.com>
 <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com> <b010c98c-ecd5-439c-b07d-3efad26de7f2@gmail.com>
In-Reply-To: <b010c98c-ecd5-439c-b07d-3efad26de7f2@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2026 09:29:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqu-ayQYeJTsA8LoAX-=hP1nVJRJDv0ovOM+D3eLxhnA@mail.gmail.com>
X-Gm-Features: AcwNN1WfBH6kKUpC9SplHRabqGM1MYPdaAcm9zslNQlogkHifqiVLaGwh4s0nUM
Message-ID: <CAMuHMdVqu-ayQYeJTsA8LoAX-=hP1nVJRJDv0ovOM+D3eLxhnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Wed, 26 Aug 2026 at 21:31, Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 25/08/26 19:53, Geert Uytterhoeven wrote:
> >> +static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
> >> +                                         unsigned char *buf,
> >> +                                         unsigned int buflen, int rw)
> >> +{
> >> +       struct ata_device *dev = qc->dev;
> >> +       struct ata_port *ap = dev->link->ap;
> >> +       void __iomem *data_addr = ap->ioaddr.data_addr;
> >> +       unsigned int words = buflen >> 1;
> >> +       u16 *buf16 = (u16 *)buf;
> >> +
> >> +       /* Transfer multiple of 2 bytes */
> >> +       if (rw == READ)
> >> +               raw_insw(data_addr, buf16, words);
> >> +       else
> >> +               raw_outsw(data_addr, buf16, words);
> >> +
> >> +       /* Transfer trailing byte, if any. */
> >> +       if (unlikely(buflen & 0x01)) {
> >> +               if (rw == READ)
> >> +                       buf[buflen - 1] = raw_inw(data_addr) >> 8;
> >> +               else
> >> +                       raw_outw(buf[buflen - 1] << 8, data_addr);
> >> +               words++;
> >> +       }
> >> +
> >> +       return words << 1;
> > This may be one less than the actual number of bytes
> > Why not buflen?
> >
> words = buflen >> 1;
>
> followed by
>
> if (buflen & 0x01) words++;
>
> makes 'words' the correct (i.e. rounded upwards if buflen was odd)
> number of words transferred.

Thanks, I had completely missed that increment.

> The return value is then either correct, or one larger than the actual
> number of bytes?
>
> I believe the template for these functions was
> drivers/ata/libata-sff.c:ata_sff_data_xfer() which follows the exact
> same logic.

Then Life's Good ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
