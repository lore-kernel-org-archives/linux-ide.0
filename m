Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B71A8418
	for <linux-ide@vger.kernel.org>; Wed, 11 Dec 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913289; cv=none; b=fGHFGRdmrHycrO3Xe4H95Q2FioDJKjjZYllExM/LkaPK2DUfzT7MgIlWHda4QwLx3WNC4tY0bPgekUTErAKkcZuLDvRuIIUT2nu7A2QMv5BJfFkolYFajETVA5L10ptkSnHj1FXCKbofmTDsAe2Pp81bh4f0QdDOPPopgO/Yo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913289; c=relaxed/simple;
	bh=F7KIKW7J+BGVxbry91OimwuExdPUPVb2HBrGO+PaP7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQAahGlmPLnMMITRccGDQBMqGBoYFh+Wk7EeRjwMt4kKVhjBogOJM637q7XvA4QnodyhWGuDI2NPkylIAXVL5peFn9ZVxduDRQ2o5eG20mB1I6azD2Trjs9lu5NWURel2KDilUzqiBH/5x+LChd0f3UDtqvZGKzJuF3GD6x7ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sHSxBhVS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHSxBhVS"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so551142e87.1
        for <linux-ide@vger.kernel.org>; Wed, 11 Dec 2024 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733913286; x=1734518086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7KIKW7J+BGVxbry91OimwuExdPUPVb2HBrGO+PaP7A=;
        b=sHSxBhVShK6cwd6IZrPsoxKhebzHQJIfTaCKZJ/OfLkSrtkQzlltoBDDhcxx67l6VL
         0RemwlrrsdawJBqodhhKPlauH36zpUuQOVA94PREUAmhLqknfyH/dq6WlMkYAQI0emFX
         7fxhNxTLFLd+/XN7qWNMeZtqsknLu9xxrFNvh4CUWJnyAVzo2QCS+u7S8WEMV5YBUpxK
         +9UuxC4uumPtHUmF/e/54PzRGRy9CEIQTvyNtdm70FhskdH1BqXRhR6vLpJ3qYCD6xnr
         Aur13clCcctuuoSRQNXuSuDj+BK30fbwORuWSKP34WdbrOq3y0ePTmVkimD4Wrca6tp8
         Dq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913286; x=1734518086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7KIKW7J+BGVxbry91OimwuExdPUPVb2HBrGO+PaP7A=;
        b=cPMHFIUfUPhcc0KlZBIg7Gw+lw3v+9cGA1vclZOmsQNqSXmjznT3E/Apo6Z6o/LVp1
         M+WH7xye8FsZiGKjYxBd2uOtjsKBxYq76F9sKL9LFjFJuDoUmudxSzZMJC1ioskAQzl7
         Ihb7ip+2lSqJ+74jS1P3pFbC8303yTiRaqs99GQxAU7wEdLR+/o/TGxb9nsJcDGXCuE4
         Us47UgJ1BmJtpL7WO8mq7XoNsJLSL2qTKOaufpYuCH6vb+b7Ztze/FC+5w2PXjL14PqY
         mFSEdGYX65sJXCrQPTiaQc8yz0UrpM0B3edU3FWVRfFCO4XTjMVbSmm5INqBl+e9bLGT
         TVqg==
X-Forwarded-Encrypted: i=1; AJvYcCXk+OZr/0tZOtW/lHDLywGm6PkGX0RWUnTeRCOZKW0n4lELdhIrQApPid10dZT+jkn6iw0QEUkZhL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgA0MeDbfzIHeEj3aqSxIMeEz25LQRbsZn0e442fSQdkShQjl
	IUm+nCZshtNEFAkUBnJbVq2H4PfW0NrWOmgl7q8IB3GUMx8ZHpxlbzZAY/IOk7CoJU9c3k1Vg8L
	FPJxIBJ0KXIA1EV3yt1HpbmxIvR+K3/xrh3AWag==
X-Gm-Gg: ASbGncsFJTIvs/FLdloqwlE2vOOAwdIk4UdGZUw4qbjp13df3LIVEbXYO5Hcn5X9Q84
	QEJHcyEjrd6huUTPrSZ5C0edlyrNSIRep3w==
X-Google-Smtp-Source: AGHT+IEIzF7TzpGGOuEOvb5mn1FpOkiF+vDhRngOQ1SKyw/OD9NX/30zYA3n7HT3xgkbQLl1uo9Edg4dhzoo7+83kh0=
X-Received: by 2002:a05:6512:ba5:b0:540:20eb:80be with SMTP id
 2adb3069b0e04-5402a783b7dmr685573e87.25.1733913285595; Wed, 11 Dec 2024
 02:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211011201.261935-1-linux@treblig.org>
In-Reply-To: <20241211011201.261935-1-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 11:34:34 +0100
Message-ID: <CACRpkdaarPM3vx6vAVhdSv+KHDZq6MTDo0JpQYGj1gJnaE7OrQ@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: Remove unused gemini_sata_reset_bridge()
To: linux@treblig.org
Cc: dlemoal@kernel.org, cassel@kernel.org, p.zabel@pengutronix.de, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:12=E2=80=AFAM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> gemini_sata_reset_bridge() was added in 2017 by the initial
> commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> but has never been used.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Right it was never used because the corresponding reset in
the low-level PATA driver didn't work so I patched it out before
submitting.

But should you not also remove sata0_reset and
sata1_reset from struct sata_gemini and the code fetching
the two reset lines? And even #include <linux/reset.h>?

Yours,
Linus Walleij
