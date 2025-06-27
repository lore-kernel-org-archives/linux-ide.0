Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCDD1C862F
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043905; cv=none; b=IiRXBDJ/zam+MuZkqAOs9pFXCD+iC+xia2VOWTzjJGaBGKWL0zSWNz9IqgxWnedDNopDkEm1bEHqcnbz+lcNEcuE2rdDz/6YKsANFAjuyLsxQFCvFbZpY8tjd8MjrOGQMfwLXRKGXbbq1C5Bo+HcOvqn4Q7a6+hBydgppWUWobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043905; c=relaxed/simple;
	bh=deL8t+Z6kPUTWBuDsLNI/OY/0ODeNaIIBBhQcRPo1EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Py80aCwnlegfALlRZbfIpVlN2HWnWCS7qzsOBrFXiM5azfvvX5cUBnxiJfuNlJ7jlK08nBaO7Me6rB0ZRZ7kBn3n0u8FuRHmwhmp9EDA38rXQMidSzfGjaqJ8YoiQU5B2Gs3Gb13mN9y+m8B1BngMtvENWyCv/bcb95H1nS0sVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f/mw0bMW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/mw0bMW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so4047787a12.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751043901; x=1751648701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wDerFK+IEUazuraRTn8N2alB6CuM9Zhjl3/pSZNoVgQ=;
        b=f/mw0bMWEBgGh8m7yxmtIHilA9uxvVN8+4r6odMnJok4MMu+0D3ai/dkHCHAnnvxCz
         qApB8OV3ZJhV8+2eeubhlR0pPtfiWkkSAxEdSc/fkpv6Hc8wZkzoURxGfuf/1UDNqpG9
         fWOZr1S+4AsI3V4wAgaysz+bHxcPe0s81R89I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043901; x=1751648701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDerFK+IEUazuraRTn8N2alB6CuM9Zhjl3/pSZNoVgQ=;
        b=hCQTkBt6mT/s982JmvtasgiDh4Lwp+8Jnzb0YBMXqlR31UBxngY0cox0aE8SfUZe0e
         sfXBAUqEmcrDyUPQmJeyIoN5Ejyg40QLCmHjfh0jPzAlJP303LycWhzW1mrwOKMU5l1r
         LgsKEWazwpfC8hO11qoIipl6n/sAUaZX+ocWNWLdXfdfA/X9eDnYhpT8f5QodZ18G7YY
         NgwyGzKkb/QXar5XG4UDrcb+FKXmBB7HF8oHZBP67cuuFVO5MasW8RAWZiyBnABQesk1
         PTyF1wONUM/UlRu1HMtbhwjC8SNs1UaXFkotbQ3n+XxdujHuRxPxr9f2iInHOmDS5fus
         4N8A==
X-Gm-Message-State: AOJu0YzkIrgdRhTdHcs+bmc9GBtK2l5B879pauKGiPYcq3foWb8qVkz7
	MUn8fhO3Edl7hzM8Hiuropcuw7VK7/FSfTBKtla9PA7YHkcJJg1/CxAzqdVTVwPyXxqBFEPs3k5
	FwC2TQGCWoQ==
X-Gm-Gg: ASbGnctbhCIgObKn0x1d97+EsbLoMg2vI39H02ulal7sqInVVxH+VBdAvK0X2ZvX2MC
	7s+7GFfDVqeD+0GPnYVJjdfEAdyOvELqmo5KNPP80RpyM6XqdaUS07TTBye7HQdeEBWdGba+zwn
	vrIJoNvNiiLqNAYOIFuuSiybXeJhfuaui+RyBvZl4473A4EdCch+vvAxq501SKo1OV9sVdu3iWq
	fQYzPEsPqzhBBRZ0h/kU36t60y++6WP3OhWUBwrJ0dx/D3OhH9lywwpAnJ7HMYO0+U5iXCYH7wx
	6E5sdle00Xgmi3ukMn8iXdhNDTzoKS/9mkR1yBZAeTlRMm6qmhBQVUpNQN/6FxD4F4DODzzl1o0
	qke6EOH8OLoinEWAgokz2Yuo6y9YSwLMSD8Kn
X-Google-Smtp-Source: AGHT+IHaK8jBCnaPgAxXlUJEHoGK6CKax+23MS9IbTkVhgpYThdZqwcWUlruZQhASugRHfBEX6TYTQ==
X-Received: by 2002:a05:6402:1ed2:b0:609:7e19:f12a with SMTP id 4fb4d7f45d1cf-60c88ddd078mr3597056a12.18.1751043901067;
        Fri, 27 Jun 2025 10:05:01 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c832165b2sm1749389a12.77.2025.06.27.10.05.00
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 10:05:00 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso4418779a12.0
        for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:05:00 -0700 (PDT)
X-Received: by 2002:a05:6402:520d:b0:608:8204:c600 with SMTP id
 4fb4d7f45d1cf-60c88b33e1emr3938085a12.3.1751043899365; Fri, 27 Jun 2025
 10:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627101431.1667919-1-cassel@kernel.org>
In-Reply-To: <20250627101431.1667919-1-cassel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Jun 2025 10:04:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJVpt79p4XG=G8nLcuvQ8=KZ1tU4+dNJsVHo0dwGyM5A@mail.gmail.com>
X-Gm-Features: Ac12FXxkVD41eGWLK_QCmwOpLnOrnowgadbCYVjtMjaXf7Vndn7ecAjMlRjUss4
Message-ID: <CAHk-=wjJVpt79p4XG=G8nLcuvQ8=KZ1tU4+dNJsVHo0dwGyM5A@mail.gmail.com>
Subject: Re: [GIT PULL] ata fixes for 6.16-rc4
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 03:14, Niklas Cassel <cassel@kernel.org> wrote:
>
>  - Use the correct DMI identifier for ASUSPRO-D840SA LPM quirk such that
>    the quirk actually gets applied (me)

I've obviously pulled this, but it made me think (once again) that our
DMI matching routines are incredibly odd and hard to use.

Maybe "hard to use" isn't the right phrase: it's just that they are
pretty inflexible and you have to write out the exact right
incantation.

Yes, we have that whole "exact vs relaxed" string comparison thing,
and default to a relaxed comparison (and almost everybody uses that).
The difference there is "strcmp" vs "strstr".

But it still requires the exact slot.

So it's still incredibly inflexible with the whole "oh, you wanted to
compare the *BOARD* name, not the BIOS vendor name or the system
vendor name".

Yes, in some situations you probably do want the specificity, but I do
suspect we could have been much more relaxed, and have some kind of
"board / bios / vendor - who cares?" model of DMI matching (and same
for the whole "name vs version").

Because I strongly suspect that if you had two strings like "ASUSTeK
COMPUTER INC." and "ASUSPRO D840MB_M840SA", and you just asked for the
sane match, it would all just work without having to specify that it's
DMI_SYS_VENDOR / DMI_PRODUCT_NAME.

So the whole "you need to specify the exact DMI slot to match" does
seem counter-productive.

That said, it's probably much too late to worry about this, and
obviously the whole baroque exact slot matching model mostly does
work.

Except when the slot gets copy-pasted from the entry above, which used
a different one because one vendor filled in "version" instead of
"product name".

            Linus
