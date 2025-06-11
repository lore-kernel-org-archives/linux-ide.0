Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DA2874F4
	for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647722; cv=none; b=GuFKdAxEw+zsENFufbWiyKpPvC+yJ79GbjW0oEgzXywDfpoLIU0l1kW7O2/23FksV/9hMvNgJJWm6dTSGdBge0WMnFMKp9bb3oMWmPZDWevm4kmScfsvXKW3uKYdy5knOX/7zXqLbQi0pyOrQhN4ZGEiLdAtHTqwQFFkva9Eja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647722; c=relaxed/simple;
	bh=eMg3H0fFIz/rvrGsm4hUXKFN89Qxpr6dY7oWGEJjPfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUo9OHTEP6JcnJXqNDN+XpJqziG9huBu6KPaDEseqCzxMY/zpjnso8H8WKLWZ5irqKn7r7jtPBUycMfC4OdoRU1h01Pf29nJV17UxjAa7wVz/Yd/MkGRI62H7vENy3ysN2T46PR1dGRVXw/8HuZpXi7I2k/1Y6NasO2WkpaF9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBjkmnim; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBjkmnim"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e731a56e111so5961024276.1
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749647720; x=1750252520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eMg3H0fFIz/rvrGsm4hUXKFN89Qxpr6dY7oWGEJjPfM=;
        b=eBjkmnimosdPjKZmf8Bx3rtR6slV+sHv9IsMi5HEgQB0LQtLhtakW6dmiJMS26JD9X
         YsnoPNWk0feWv9vveSAOiTvOkDiPZGoslfqjFsFYAbPzuDcEFacg7nzlH5fUiKb0sAbF
         n6aPCLf6jLzLXCTZ0iABkApQgUUELr4X9LLzhgbmwCF+ZrCGVxs8css7T17WY96Gj3FB
         h7GE2WeLNlFjTOFXyc9hDPqkNHEqrciAUgoQHw587y2PG3T9kLRinl5oVPfNty7uAT7/
         7xfYR/kSDm+F2C+VWqJsxfBzgTzPECzRinPLQ0N03yv5t3TPNVbJrHBr+CaL4k7qCZCx
         v9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647720; x=1750252520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMg3H0fFIz/rvrGsm4hUXKFN89Qxpr6dY7oWGEJjPfM=;
        b=pZZ4UuNM7K3fBxeeT7UcyFeJnrhkooy6Fh78kztNfHgtyj95n6W0SnaPHjF4eSxdi9
         c8EFGKup+M93Hr23pMA3978dsU62LD+xmCul06Hf9BTpScglLnO0t30sriDs1rb3zJbh
         k81oGA/OVkIVeAAdWwKyJiwWkzJmJNMlw5+StINmJexKSNwHNAN693VVZIuzIA96pOoM
         Tvb844Xw43RnIPPlhIRpwBUuI/IG1YPw3CBreQH42DGGZD8+Yu3vaFuaMjxJLpyiJwGm
         GEN/BmilgWatFWcz5pYsgMxjTW3AZhPb6xmRqwFylV/5sxeXrimXBELDsp8u40+ZxnWU
         B9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwEq60KFE7ZCPTPfDYOFmWucCwyAvL/gCIzQzwehPKAF90kTcDnon8Wz4dvwJOe9sCL4E78//Afkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQhOq+i/hFsr8fbK1q2qN8Bho9BK+r/AT+YmeSldfvH1Hs+eD
	mpqozzXC5c/vozIMQ76QtmpC/tUVDHMpAEm5zo59YNEjLU5SBWgJSHI+JvZTzzWm4evaEpMcr/b
	H16Bns5U2iL+0YaRyFDakEVkvPTMk2P0=
X-Gm-Gg: ASbGncuBPvOwUR93ycW7daQ0ePNPHLG6OVQAhjFmhSJlgHJ3VfDncBW31whaLcjiDJA
	rmqMiGR+HABMWFbURBFRC3HHxAx0I6wdSvxLzbIdyIp4RqwzF0n/MiWtnpfJvNJYRmejwD5xbj1
	cvLz+weJFewaDdbCc9B1uV0JifYzuDc6ecr3bFzwaS7K/xraf+pcVvGNg=
X-Google-Smtp-Source: AGHT+IE4Nyqcb4JMu4jt29JKjxmK77yeiV7cpJYBIdJZU9yl8frKZDduBGVkH92tiSX7y+XzKVFVo9HzobNBExtbuNc=
X-Received: by 2002:a05:6902:2511:b0:e81:8390:ed02 with SMTP id
 3f1490d57ef6-e81fd948284mr4538254276.11.1749647719955; Wed, 11 Jun 2025
 06:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org> <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen> <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen> <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen> <CAAZ0mTcge55H4Ow0JG8PE5Wpgtz6TG60uvGxRUXrq-aVH4k9aQ@mail.gmail.com>
 <aEGLCBnh_PSON3Sx@ryzen> <aEbmg4wqqMaetxzd@ryzen>
In-Reply-To: <aEbmg4wqqMaetxzd@ryzen>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Wed, 11 Jun 2025 16:14:44 +0300
X-Gm-Features: AX0GCFv1MVWt1JeUz8X8IwzWdBOMpz3BqAmSEq6lGWiJBMP2fxPmAbWJTCmk8jU
Message-ID: <CAAZ0mTdBgeedcF3gE6bKm=+qFj8Sfuc0xVc-kDb2=nhMS3F_3Q@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ma 9.6.2025 klo 16.49 Niklas Cassel (cassel@kernel.org) kirjoitti:
> > It is unfortunate that the BIOS manufacturer has managed to mess this up,
> > but since this is the first motherboard where I've heard about the problem
> > of LPM only working on certain ports, even though it is a per controller
> > thing, just not having good power saving for this motherboard seems fine.
> >
> > I suggest that we simply add the DMI name of your motherboard to
> > ahci_broken_lpm().
>
> (As without that series, it is not possible to add an entry
> where there is no good BIOS version that has been released.)

Hello Niklas,

thanks - ok we are assuming that this is something that happens only
on this motherboard for this AMD 0x43EB controller at least for now.
Was your thought also that we restrict disabling lpm only up to the
current BIOS version, and if there are BIOS updates which don't fix
the issue we just bump version number here?
And I guess there are not going to be any firmware updates to the WDC
WD20EFAX-68FB5N0 drive, I understood that you or Damien might know
something about this? This would of course not help if the problem is
in the motherboard.

Best regards, have a great day,
Mikko
