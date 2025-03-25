Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057C18A6AB
	for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918138; cv=none; b=HTIfYfYHhLv4XUm6t3ump3pY3PfRFiJ5WRSuOnFKMxjmskMvjxh0GbzKV+ZAWCkGUT69z2OrxHYDtbgTIj2OnlJ5Ah3vMBn/ulHaw8ZYq0f0DNFw3sCCTG0rgzD3uqlMsb8ZD7oBmb+wNItVt7RupNI9UTZ3ZIhNgfnFMbE6MMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918138; c=relaxed/simple;
	bh=CMWVz33lT6p1f+17izyO+br6W04HIXsYhjFMmrBViqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWhgixnsV8oLFrCHbuRPk32wYBfChdVyP8wmL3ZWDiFsCUHraoIihoXtMPnCYp/rKrGuiDrMhjb23LynwWqM+wfgPHhfEX8Lee4Slw14ZqRF31DxkWCtMzJ6OyLsGf152vpbC0zGOtDIixMAl8GICJPrHDAqgyxe8VefyUXU+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpl5vPje; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpl5vPje"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0782d787so41266565e9.0
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918134; x=1743522934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JssoJbGxAXlBbUyT3ON3KKR9aBT8d77H2v38bI0fixI=;
        b=dpl5vPje5rtXufx3lehJVcux7kuUPjyhizKIIZj1C9GP0wT36kCzAOP1izyAt832wf
         otnSazZmS3ps2DeXr64jGZk2Dk3Eafl8SfTqN8rFgMULAP+dEAsq5NlAI7cHOeMcGBVC
         tAsAzIgqDtuZx/rybet/H3mYIt3hydJbS9bI2UrE7gpcIxGrZUYhiH4cyXtcRw8rgnLN
         wJjNmBNWGtPj/YA/RCgZhg91c4np9Y7zw6zZlgjA8aofWB+uZgUMhM43BptANfVKGZnY
         Mfe8XxCYUAun0pMq/1qPYCzeVO7aQ1JFzW4osGKCFDRjk6UOjswuYsd3f4+RTdWCeDi/
         Ywzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918134; x=1743522934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JssoJbGxAXlBbUyT3ON3KKR9aBT8d77H2v38bI0fixI=;
        b=IStMbqiQ1GKfrKCSzR/Z8eGWiEkSFu56P4fQeNVjuohE2qgtWX2xiVvsbABuFCkSYp
         UQrJkhgCg4kanqktrQ0qCPcJQbNa0gVAuOmpn0Z0N97+KPsV8iXXSRt/7ISMpmbtMIn4
         oTke9wonsWtz00yXmWCdtIiOnwqmbz9MdtakVHaKGAMhOzYXblnMU269dRNKtSeE3wrH
         WHml9pszzRzMSIdshdBJPCHrZ7mIjCD7u1MwTYD0LY3eyLUuXW80eRRMPB5OuYZ9p5iW
         rCb/7UT0Wy3sTvlbn6tPqsTyzFY8czQfZuzPG+tnPpFqYkMBKIoekD3ILKbkXNDi/g8h
         Gaaw==
X-Forwarded-Encrypted: i=1; AJvYcCVp7Q0TJ+i5AwKJvD6bXkg+BnH9Avk+aLse+KnlCdSQ1OOENtG7Xc1fC2SReYDX4+hrO8JzoM20HyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9rNm8ppsPRsxO5BdnMWRwf8+Gg8QadbFTYolHNppvOgfzpTF
	uOAmb5dQorZGmktnETppYMimPfgmWCnrWhEvOcPPyR6/QpepV/Yp
X-Gm-Gg: ASbGnctqTvBHfRmwZM8RkqsfdxO4T4SySWJqmR79Vi4la4RBIGjB+8ejyoiQN7pi11v
	ocMBZhF/LX2OVcT5c9Ft8+lnhqzbnLqg1zK5GXnNdtKLgOqkhmJfJvIg+tUFfWXxbg6MxOzpyZC
	haIzOCRyOGzwTA5O2CkZ6pS2F0HmDN3SBPWsL6DPAxJoPuzc6zfkXC3EnQYwk8Aa/5ZYIUCFAIH
	D5AD/dQ934MOy4dMOAXsLVuAskxWx9nSgw/c2ymecBB9sx8GKTKOGz7xcLdR+YwvyT9gMkSmkQ3
	m0DDvrsGIBofqbS5u34WcBetJ3rzJvpA9tlpB9gte7g=
X-Google-Smtp-Source: AGHT+IHRAGJsg97H8EY2q5KgKnz9QjXZ8OYPFvCYzPH9NT6jqf2GHi/kUEYr1z8cYh42PzDyvNoS8w==
X-Received: by 2002:a5d:6c6b:0:b0:390:e535:8758 with SMTP id ffacd0b85a97d-3997f8f78b5mr17067536f8f.9.1742918133500;
        Tue, 25 Mar 2025 08:55:33 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:eead:4845:67bf:e110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a31a7sm13861603f8f.23.2025.03.25.08.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:55:32 -0700 (PDT)
Date: Tue, 25 Mar 2025 16:55:32 +0100
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v3 1/2] ata: pata_cswarp: Add Amiga cslab ata support
Message-ID: <Z+LR9Glz5iV4Sjll@amaterasu.local>
References: <20250324121645.208368-1-p.pisati@gmail.com>
 <20250324121645.208368-2-p.pisati@gmail.com>
 <CAMuHMdW8WUyUsjG4FaT4nP82pZYVFsUpYNOg2vsPPOthf-O49A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8WUyUsjG4FaT4nP82pZYVFsUpYNOg2vsPPOthf-O49A@mail.gmail.com>

On Mon, Mar 24, 2025 at 02:21:57PM +0100, Geert Uytterhoeven wrote:
> >
> > +               }
> > +               words++;
> > +       }
> > +
> > +       return words << 1;
> 
> This can be one more than buflen, when the latter is odd.
> Why not just return buflen instead?

I think "every" m68k pata driver is buggy in this regard, e.g. pata_buddha,
pata_gayle, pata_falcon, etc
And words++ can go too.

> > +
> > +       ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> > +                     (unsigned long)ap->ioaddr.ctl_addr);
> 
> These two printed addresses are virtual addresses.
> However, due to the use of a cast instead of ioremap(), they are identical.
> Still, I think it is better to print board + WARP_OFFSET_ATA and
> board + WARP_OFFSET_ATA + 0x1000 | (6UL << 2) instead.

Honestly i don't follow you here, but i'll ioremap() and send a v4.
-- 
bye,
p.
