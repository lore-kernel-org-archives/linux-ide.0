Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57870A944
	for <linux-ide@vger.kernel.org>; Sun,  2 Mar 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740911661; cv=none; b=CStOnv/G6XzxPVyKKqFaG4KQI2GxyFHAd/Pp6ntJ/6odmndxxlXdLe1c8lOhgF/p5gXCsKrqIvSkWjHjznqWi0aZrAimvearUEOELFjuFXswWWzdnSMPtQrIYJhtpbCqxJiWWD+SZrr1sJ2De1sLw/poBsqidU38fLvggpzvHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740911661; c=relaxed/simple;
	bh=g7cB+tTOATBtoVGm8uNuGlMZmLo04nRflBDpvxhBTac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTjPsjlGm3USeQ86Y7UoHN85rDBEjvBs9uyaruD6AHBWsj+IXRatdpQ56xHjsdv6N/sDoZXBOe2UrL1njzUjVu+g1POx0QcCZKTrqubWsOH4vkqjE6pqbGMqdghaMyGnaoiONdyg8XvRwTcmXo4H2iRroBAwEWL0o80uWKORcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVYqKzGD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVYqKzGD"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30918c29da2so34929291fa.0
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2025 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740911657; x=1741516457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7cB+tTOATBtoVGm8uNuGlMZmLo04nRflBDpvxhBTac=;
        b=IVYqKzGD6ZU/aYY3E/F3booHW+UlmQsMkvH8nSUcEBgpodIg5fkDZN5nqNIhD8WDOl
         6vMwgQh78GPo3gGnju//oa1dx+y8/LJ5kaxvHuw28I1XUiEXYd3W/ocZGCwulwvdx7B5
         MOgxeRu8KEshXocGqnMxCwvskw5kGl2YfF921IEiRpxwzqYOUYusPBCMiRxljVWX8T3U
         ldAE7gg133tIQnfpG6u1TRgUpfbJNUNy3s4nkdv7HDbSYIZrBEXVKQTXN9vwvSxqwJmj
         0HYnvkhZBOMCVgqhcZlKiE5cANdV4L7i51b6FQhOCF0ouErm9rO6eDlkyAH3h6b/Qzg/
         50Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740911657; x=1741516457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7cB+tTOATBtoVGm8uNuGlMZmLo04nRflBDpvxhBTac=;
        b=mddyvxphBg+MONVSgU9OYvfvH3cF2Zh3LmMSq7KhmNgCvWUGLuozu8PUQNDwHY7xSH
         6mZ+n4bgD/Fc0V6GSIPbqxm0Jl1j94Z2Tugb5/g7BPNtBoGHpcJ7IBJowMo4BZY1yiVp
         kwKrXpFwiMAv439HrjZUuFZ0ecVpCQzZHWOzLcP4NTSDNuBcwkFH2n9ZSP1Wz4DHKn86
         sq+t9ARbvU9o2AuPdXRngYg4kcIHrQvWRfmIfnrlDsUL9UbG3yXtfAH4JRzIvPOsgZaz
         XeXVgmhRS9+GyvWnh8Dyx89V9afInWUy7wlDOuwr0wxn9r4aL9Revw8cT8FMzAr7w7w7
         u0QA==
X-Forwarded-Encrypted: i=1; AJvYcCU4PqN42dTJJMEEWqJTZmAF4mur6sFep5rvxe7uqG9lOp6jSuBpk0XGrvPdvB8TXa/YCLmm31pnM30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARFpmE0OujDlE+enN1IA3jTNrneRME2dEiP0Unz23FAnFODrX
	RGwdZYQvHOjdBx//lf8t2AWd2vkcYtJQGe/R+7r3Y45sePdhXU8m7iYgRFSAUT10Q0z9ZfODTTP
	xBZrBpESjIAMJ/zdhBxUk/loRHDfhYBDBJdc=
X-Gm-Gg: ASbGnct2d3FJoxAsWhAdJBoLaJtCvf0FkE5ZB02/DIgVFtTlfMILmRGhEDOdUcIwnrk
	kgZ6tHADuCG7NgbR5WWmbwX6mnxmQDhR2FsGoG/jJ8RggoEKFwj/v/iIyJc7HMijK8fM754WomX
	L4Mon/MaYP8wACP2Pbn+2pXmRgO0Q=
X-Google-Smtp-Source: AGHT+IEUFFmbVREWgPvMKymOeen6kI6Dios/rQilTs+lATRSKIsgxzct3MigNkpPYrRO5s4s7hnZTxHoJEUN0IZhcGs=
X-Received: by 2002:a2e:9652:0:b0:308:f580:729e with SMTP id
 38308e7fff4ca-30b932f0817mr35230271fa.27.1740911657157; Sun, 02 Mar 2025
 02:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALc40c8rRV-mYyXj=a_+j92WKKmdib6Dbw+11i_Y9OYXWBCmwg@mail.gmail.com>
 <Zdz3f4KgAaPKp7m_@fedora> <CALc40c9+ZFnimQ_KP7YpCGgP=iQBeDSS-xPAwwiraeX42yK30g@mail.gmail.com>
 <ZgxT3QqHJ6rq9nqq@ryzen>
In-Reply-To: <ZgxT3QqHJ6rq9nqq@ryzen>
From: Ruben Van Boxem <vanboxem.ruben@gmail.com>
Date: Sun, 2 Mar 2025 11:34:05 +0100
X-Gm-Features: AQ5f1JoOA8nhhWeXDW626hEp9pQF_H9YhjQ4iIvrLygtTfvcRk9VmUkTr7X_mrw
Message-ID: <CALc40c9wC25P9nOTu6ZbVjMwC6RhG5+N4R+7wr5UxWhcU4rBUA@mail.gmail.com>
Subject: Re: ahci module throws "Internal error: synchronous external abort:
 0000000096000210 [#1] SMP"
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas and others,

Op di 2 apr 2024 om 20:52 schreef Niklas Cassel <cassel@kernel.org>:
>
> If you still have issues with a recent kernel, I guess you could try the
> patch that you linked to, but you could also try:
> https://lore.kernel.org/linux-pci/20240330035043.1546087-1-dlemoal@kernel.org/
>
>
> Kind regards,
> Niklas

I have recently upgraded my kernel to version 6.6.73 and everything
seems to work as it should again (booting as well as my NanoPi M4 PCIe
SATA hat).
I'm unsure if any directly relevant patches were merged, or if I'm
just lucky and my specific case now works by chance.

Thanks for the help, it seems to have sorted itself out eventually (or
someone really sorted it out this time, who knows)

Ruben
