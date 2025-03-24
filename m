Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAD25DCE3
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807455; cv=none; b=bto0BzzcjqRuJ9gSqZNhI1TKtopXmd0ueiY8/2eMuj4TxdnD42D/ttCSY4HwC4RLvYdfYyXG6T3UWxhZ6pweyFSf0iG3S0jmQvklD4uVsV6RhNUKjfjQ1jaBFxNaxrsb6X5hD2QppDWHMz9RnrlIxGSmSo3QM2JYetHohgBepGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807455; c=relaxed/simple;
	bh=UgBPHe1XQGl5FtIyYB4FXJdalGDGR5q7sWHl2kmxQMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB60F7wbZuFhD/AeMor+PqNCC32CEq4+hDmi96z0YpCjjZov8d1tIaqpDDshEMhFFaWvfMIGHrXU5bjqfn3hSRx22Y0TzUMIPbA85HH8htTMbvbPQizhV1JpjX78Z8fX/NIKOIrvQyMQAAH0EKJSxDA4vLX8ETQNcByy7WU21Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfeRMPtZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfeRMPtZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so26702375e9.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742807452; x=1743412252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpWQimo+8FOwWH1KlD57/iYLoAt1JCWWGhkn5vZgVMI=;
        b=LfeRMPtZi45LwRd5itICQpeiLcuTEY6HlXoVde17HvnsLEL0D9drw05yXIAL7p0CqV
         30XgqB+XsA5OZfpCLPw3+gUAxn7v2EdNVG/WAbBSFz298FRoswGp5ePqffp854oo+l31
         owTh8Jqixg1lnTPklncfDSvPSdtkwosb1B8OUsQ9OPblDdJLKfRYMj8NZqvDHVsFCE2E
         f4euaYmQcp16yRH9DLfERweoat3O6npAQINKJYPxjgIxb+MKo6dtBlUJmffuey/Z+QzA
         tHy/v5gXVl6+4dMm9/5qFY+zAFfgo9ae+kRaZS+4DfQnYz2Fmqen2qyv7QY5LI11AEUf
         6OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742807452; x=1743412252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpWQimo+8FOwWH1KlD57/iYLoAt1JCWWGhkn5vZgVMI=;
        b=ppkv/HIq7Zp7ZWFovbIwIctCy3Fa4Yilu/oETqtWNQU+M2d1LNFIMbHRdyxTcPF+Dg
         AHHsuQ0xrlNRmgWEN5R8NPcEkkjMCtKIjJqks5gfYhXTypEDBr23zy10ge3ZAHWJoLjp
         EEuaW3gQryh3wwoCzFVCNfbSUwWR0Q9r2SRTcYi0d9U//BC5oJqNjVxVibBGqg/m+Wje
         Oqq0+azKxBXjXizxKe9CxFbjcAJn0cZrW0ShYmskv9jtWrhIFNwWCdh7xQecnNVoFPFy
         j3dfnN1d8alNHEIgcv2gFAKzNHSiDSzRNFAH/c054fVItejJHKfeMbFSBeZlVD5ramoL
         3TEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/DzyMfHA6X+v5M8jCS/3DWoZcmh0Z0BjVR8opOjQe5tcwj7ggKlhTJ6iQF5vxPOo17SoeBNlt4BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCQ7PSIOFu0MoYcYrE/WFT3iOdBeoeG7d7R+jnI3nw1s7J7M5
	JzfC0Bv/PUlmYTHtq7praDP/efykTi1jD1dIDUne+UnTdvOeOXDP
X-Gm-Gg: ASbGnctHOw6/i/ZJItlxg/417FMufEh3zvYkA+AkPIdsTRHkR4tKgqzPtU6qzEcXA2R
	tOKTMI1l4kjgvCEsbT1iXVnp/cIkE7jJg6kOiloz5CTs6fKacxOwZsTw8bGpRFCMyVecLSX/rxQ
	+QubuUR6V+Ymp+qAbyGByp1S1ro7JC7c08shq8j05iTgJD0F88RYe6xazpHKyD5JzY0ID/4r4F5
	yTX0zp3yFlSznXn8JW83d1j0qyhrgNo404yCMytQ3jtHUb5O6pt3MlIQ/C0scqJgw6IsELOxhak
	TCWdKkG3LF3sDEOol0YpG/dMZ6o/R0U0WDp6PIZN9rA=
X-Google-Smtp-Source: AGHT+IHTzWEhQr9+0PhtSYCzvYjG0/qEljNMdLesBkRG0POOjNjgw6tTXj8rYMPQHE/SAVtvUdpLrA==
X-Received: by 2002:a05:600c:1913:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-43d509f633dmr105837185e9.13.1742807451837;
        Mon, 24 Mar 2025 02:10:51 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceafb7sm116682435e9.1.2025.03.24.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 02:10:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:10:50 +0100
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 2/3] amiga: cslab ata support
Message-ID: <Z+EhmiMWIMGqlXXP@amaterasu.local>
References: <20250321151416.338756-1-p.pisati@gmail.com>
 <20250321151416.338756-3-p.pisati@gmail.com>
 <CAMuHMdU0yDSXoeDoK0yUrJ-cD_4BChEXcvteJW5Ra6afKzciMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0yDSXoeDoK0yUrJ-cD_4BChEXcvteJW5Ra6afKzciMQ@mail.gmail.com>

On Mon, Mar 24, 2025 at 09:17:57AM +0100, Geert Uytterhoeven wrote:

> I started working on Zorro MFD a long time ago, but never finished...
> https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd

Uhm, that could be useful for this multi-device board, thanks!

> > +       /* Manually bind to all boards */
> > +       while ((z = zorro_find_device(ZORRO_PROD_CSLAB_WARP_CTRL, z))) {
> > +               static struct zorro_device_id cswarp_ent = {
> > +                       ZORRO_PROD_CSLAB_WARP_CTRL, 0
> > +               };
> > +
> > +               pata_cswarp_probe(z, &cswarp_ent);
> 
> This looks very hackish to me...
> I guess it blows up when trying to unbind either the zorro8390 or
> cswarp driver?

Yes, this was clearly wrong.
 
> >  157c  Information
> >         6400  ISDN Engine I [ISDN Interface]
> >  2017  Vortex
> > diff --git a/include/uapi/linux/zorro_ids.h b/include/uapi/linux/zorro_ids.h
> > index 0be1fb0c3915..5736d2bf0295 100644
> > --- a/include/uapi/linux/zorro_ids.h
> > +++ b/include/uapi/linux/zorro_ids.h
> > @@ -455,6 +455,12 @@
> >  #define ZORRO_PROD_CSLAB_WARP_CTRL                             ZORRO_ID(CSLAB, 0x65, 0)
> >  #define ZORRO_PROD_CSLAB_WARP_XROM                             ZORRO_ID(CSLAB, 0x66, 1)
> >
> > +#define ZORRO_MANUF_CSLAB                   0x1400
> > +#define ZORRO_PROD_CSLAB_WARP_DDR3          ZORRO_ID(CSLAB, 0x3c, 0)
> > +#define ZORRO_PROD_CSLAB_WARP_VRAM          ZORRO_ID(CSLAB, 0x64, 0)
> > +#define ZORRO_PROD_CSLAB_WARP_CTRL          ZORRO_ID(CSLAB, 0x65, 0)
> > +#define ZORRO_PROD_CSLAB_WARP_XROM          ZORRO_ID(CSLAB, 0x66, 1)
> > +
> 
> This does not belong in this patch, and adds duplicates?

After submitting i noticed the duplication... anyhow, these ids changes are not
necessary for this submission and i'll remove them in v2.
-- 
bye,
p.
