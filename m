Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2128E00
	for <linux-ide@vger.kernel.org>; Tue, 25 Nov 2025 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028846; cv=none; b=JqiMzdFe9hAb03VlUQttnJnTAuMju9tfhW/IR2Qx7DhIaBwlAzcRNbhW2xBqvQRhDVBhuMKfnJZ8FrK/IOo0hrPnN1Jc9o+UaJfPeDvcWmaEHycGbZbPNFLwvd93yrix2x5zg0JxKcebeOOyQuf8eMEiHh/CRLTCjgWGU1M/N1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028846; c=relaxed/simple;
	bh=7AlPnQKci4zxItjc4n6oVZCxEHtNoKjdwVhAM/58eRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBhIsaoIenvuoMd9HodHRAV7HL/i0cUOx7brihtLYwVn4I9zFASttTW3pAP4D+9+m6pufaMFZVnXiBGEE7877aVmGAZi/7O05NU1Z72l8y8Nw9gAucd2K5GK4r+TUp6aOG4LN+pTqPgbLWneXKn8UtOfNqcy9h9OyNthfTT6do4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvkQoc5F; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvkQoc5F"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so59317566b.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 16:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028843; x=1764633643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZKolD1QM1RGLjgSNf0ENMzP0WrzpdlYVNa/MekuytY=;
        b=fvkQoc5FMjZug80QiUS8QP0lFJE4Wd1fZF1roIkmdCkzio15Szk8FcabyWfRHZbdEq
         aQx1dTWQb8zHc54mLV8t0HUJZlzBbpfWy8mY10TBopIOZqLHt2SzEWnxMnwcHdXxucJF
         gxbMlJCbHM3YmUHe1iJqixEN643tdmHvWDz9D9Xobnvt5RoE2Xml5o2jtznxwV/+P4VV
         Fg+yzW1QP7CGn5ooHAKdlW6QNlGKtF4b6YEvS8iDhZ8wSQJ9YHixpLvpF4OOpAAyDaDP
         KvEF497oPDBEBqq8zC1Kb7uPC80jY5Xv1lZjxnHBit2cIRUPYktjA4KH389KWLI+QENq
         lBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028843; x=1764633643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZKolD1QM1RGLjgSNf0ENMzP0WrzpdlYVNa/MekuytY=;
        b=wok54fi5VzxtGZOKQuYZg3iypR3m4Ns/5ptDxJqmiGkd2HkUgCV9QN+0UFLH8qACst
         u0jwe/lwSBAOAArriL1ogO+Ryd0itsYRXbXHSbPZiYjeQwok484TL7QDqYRsqDOAKtao
         UL6833Q1rUEQXI3Rm+qhzI9X30bL+x+ZINzbcbf3CVYhqvv7aUKoAlX5wxQE6AnlVZMo
         JTnzqbhZEEjCZeF42oNqpsWgL4YLitPmnWzjfexbwArmo5fnQIObqz4EuitjEyPgyWQK
         v5e5AFx+eSTjrmVaw2R6moyl9f629YXolezuqnitAOvDnfill90T9gouIW5E4oRwL26B
         4kFw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/QIqyr9NeUYqK18+dRPvp8m2opX6k+wegA4N5TxAJDSBBfp9/sX2NyHos6Q5oPmhqNyjJtZygss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaSAJ8ZcJHkTClMztik+UPLPE1bZfY0ipQWER+LW2KjYb2xkY
	Hn5W9eNWFyw0m251emLRql/Iat4UYHJNkqU7x2B+/KwyjsOhVnQaPW4zrK/K50FTXXfu0YNDjw5
	7SV0I3nKBmA35CZUyNfnwGKc+yL2v28s=
X-Gm-Gg: ASbGncvBMsIZ3DzFbq74ge+YSMgWh7Lg9QWdcRgicV7FpCIWl1jmVZbJR96NWA98MX9
	aTEDPfX7DzmM/s5hr0gQgHIBV3rarkhX+QCY4wDGk6YdOtzDFrDWGKHt09huK0p0dH0mKy86s6+
	OZddzSla8Jjm14M4bEKiIU9fl0OdQgllj9c+QP8HcedHKiwog+zR1SuZmfGlJgYE/7P0ithwWoD
	l8bqeXVR60Vz/bPq+pq0usbW9BDNUOvXpB8WYlkoQpqWIOBycGgv/oOOw2jgTeHHtCv7gwn
X-Google-Smtp-Source: AGHT+IFDsyikEK7TsfaqwoG+30xdLLt6P78g2zQ+rejGfQp48KMulgdB2/6jQm1T7yqI7xkBwBDuX+ClOCwXIjdDkXA=
X-Received: by 2002:a17:907:2da6:b0:b73:792c:6326 with SMTP id
 a640c23a62f3a-b76c53564f6mr70261466b.11.1764028843153; Mon, 24 Nov 2025
 16:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124134414.3057512-5-cassel@kernel.org> <20251124134414.3057512-7-cassel@kernel.org>
 <aSRnLyyopCslI4jT@ryzen>
In-Reply-To: <aSRnLyyopCslI4jT@ryzen>
From: "Jack L." <xxjack12xx@gmail.com>
Date: Mon, 24 Nov 2025 16:00:06 -0800
X-Gm-Features: AWmQ_blFYQXlSqdN0_4yWzwhmJv3TVF3W-1hyj1YVZMHWMpwcJ34lKgNih8Wigk
Message-ID: <CALeGphxDLn+=8sZyqih6zf5NUF_4V=Ob0RhWuq-36JGH5ddfOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ata: libata-core: Quirk DELLBOSS VD MV.R00-0 max_sectors
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applying the patch did not match the correct disk but after modifying
the line to
{ "DELLBOSS VD",        "MV.R00-0",     ATA_QUIRK_MAX_SEC_8191 },
booting up the system results in
kernel: ata15.00: Model 'DELLBOSS VD', rev 'MV.R00-0', applying
quirks: maxsec8191
and the disks isn't erroring with initial testing.

On Mon, Nov 24, 2025 at 6:09=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Mon, Nov 24, 2025 at 02:44:17PM +0100, Niklas Cassel wrote:
> > DELLBOSS VD MV.R00-0 with FW rev MV.R00-0 times out when sending
> > I/Os of size 4096 KiB.
> >
> > Add a quirk so that the SATA controller is usable again.
> >
> > Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
>
> Jack, it would be helpful if you could test this series.
>
> We know that your hardware chokes on 8192 sectors
> (one sector is always 512 bytes in Linux kernel code)
> 8192 * 512 =3D 4194304 bytes =3D 4096 KiB =3D=3D 4 MiB.
>
>
> When you write 4095 to max_sectors, we will set the limit to
> 8190 sectors.
>
> My guess is that your hardware chokes when receiving an I/O
> of anything larger than 8191 sectors.
>
> If your hardware still chokes with this patch applied, then
> we need to change the quirk to limit the I/Os to 8190 sectors
> (which, thanks to your testing, we already know works).
>
>
> Kind regards,
> Niklas
