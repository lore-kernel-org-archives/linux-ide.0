Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA63328FD
	for <linux-ide@vger.kernel.org>; Tue,  4 Aug 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823807; cv=pass; b=tooNFh/uh7SpsxRnl26lU6gKsbAcnQFiKEjyLFokXA1uBkLfBE6MrKeqCjZh1Gyz1i684cuHac6rtYST6MOzPZp80v00UR8qY3OMJTO21VTHySyq6j8Ui25EiRdmcufS833Uir68pqokBUDmPxQRBCzm5696TI8OHZlt6f2wUFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823807; c=relaxed/simple;
	bh=a5WRpkzvBDUVr7xugOiFRcaxbPS0kFBbyIpbYm1j7Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLzL03bMKg6gMjQJrMRbTaR0Zcg6MEEc0H4ti8hB/vYX1IG0gCVFfq3qDfdwJIhvzQB0B6bXYc7pkdL8I0VlcLIIVEf3/6J73VKHUoOJYkjWWcT2B9ax0Arztd3hAxrp36CLdbApEnD/AYLlLQ7V7v/TBNOqOfCGaP0mZzpWCtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=uJ3CV+IZ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="uJ3CV+IZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15bf5000so18271651cf.3
        for <linux-ide@vger.kernel.org>; Mon, 03 Aug 2026 23:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785823805; cv=none;
        d=google.com; s=arc-20260327;
        b=qW5NQej6p0Ri2gw778KDbtzGb4d6sxyzeoTSsder3bQODOQWsM/yuYuGerDKqBjOIJ
         eAj/G4bU2ThQYdyOa39Xd6LZnWVl3Nh3nXAh6jLDEiCoagr3fruQhkjdc9h5R0nwt/1i
         mCzqnsHNf4vJgXI797W0IEOwvNFrEO4Bj8slH/GRb8HOtB5k381PBsenqHVizXXVWmWH
         Qd7DBjCA3CxN+5bMVCYZB8vs0Z0GPu+SIG5gyEhLUYgWcNpOLtAtjW8h0UGKGtQxFFFC
         BcaWpFrRSOdlKqn2l3fOkdGRxDcgBgx9gpUg4K4U3ml2rQdj8/57wHKq5VOv3CLHg4wv
         hnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a5WRpkzvBDUVr7xugOiFRcaxbPS0kFBbyIpbYm1j7Mk=;
        fh=dAqdIQFEjKbIrCKwr0JwuORriIRZpOoIKDCXef44c0Y=;
        b=Q98kUGQhf5iBkC6mzSyC20+7ASIh3ZMiNiQElSWxZOrGTCQev8X6JS/Bnbk58ZIyJs
         jdGobSkH+dYxy+g1GijvckoYbfaygCfObkyqtHGP2/2KUmnJxG5HM7HnZunZiaImyRV7
         qRgo6S71P9c0LwcHMH+n/dzt2Wi9ielYCj7V8VN7qOdHmZG3q/Xe2BE/ywTSTyIxz/6V
         gojUkjF7jQk0gXsaXbzi34b4rZDNZkqUl0yBa6PsEknA1lSbjM22SUrSXg9e71nMxHCP
         r0xr+Kq5LkVCRoCmYbaJzNYlNMLqjHR09eMLerBxZKZRpVaAvI//ZSl/JUfp8Gfpse+r
         YYvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785823805; x=1786428605; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5WRpkzvBDUVr7xugOiFRcaxbPS0kFBbyIpbYm1j7Mk=;
        b=uJ3CV+IZntiT2nU7BtXZ/KShYjL0o9CxuE7dtDtoRWbt+AH+zhpHBopmZAt2OEfO3+
         jg4X7zoSZ8IyIgw6Smn9Ur0GliMjV4Q+O3BNGrUvWdRrgBf/lPQ5CDGlbPvzha+VkvOj
         gDkhwGpCKg6uNhZ/20okyiuSSSXYfQ1BjgZuxWgkB3SkBkb2DgCKB+Dl48Zjmep5cdlT
         q9RzmrI5u5r0EGZDVlu/J4KWUcHlF+LC/lHANgxK/uRAItR88rGIChr3OxaYGy2WyO1U
         VcVKK3Yf7pQ0Fne73I9znFpMT21IRTCIe2tlD1ZkOfq614KBClzk1pUjIxBGlgLBB6W8
         S1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823805; x=1786428605;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5WRpkzvBDUVr7xugOiFRcaxbPS0kFBbyIpbYm1j7Mk=;
        b=FoI03PBgMztF6OjupgbVkD71eKTSLQv95OZ5rBoMZnSYnraMqv6qKfPrk+XCKyxxl3
         c7zeJr3RkmX/fBeXJduffxJiG84wBJovm16qtnjLOhlCG7QS/IEaUhnsIiApC0IjEKm3
         VE1jZrSArASQPkpXink3jdpt3pC7c93bwCat5oy6jjY6Ooq5fVdrj2N2U9flxGpAdgVq
         Uq7M9aNnCAPImD8u2KE9JkpjukL+4rI76ukZToMlNoZPl5tMg0VZUeg6p0B2Lk7gspTa
         oFzDknLvdNbtiYypsVtTK6oRSe+7iv42q0wQyel2yJ5sjCY6JHyPkykEjchx+1t41cdY
         yBMw==
X-Forwarded-Encrypted: i=1; AHgh+RpTWi5B2dugkiX5wEM4g3oudsK/8beT58OdRsidHgB4GX80y5HF6drXuaNyUR838xmN/x/X38zjvqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvm/5Ta7vikyImLOh9b5uQVcPOE4mXxWABlfJVEv/P05NQ0Tu
	qFZR5m9LYNvy26sgk/+qaxb7MizVhjRWyUwQioPk+o0Zv7ZiL/o7EUmcjyN2L+Rm3Iv83FFmtIJ
	5cXceD73n6M2szExHb4RBo9elgoAJ/elBpqkHgw+tGA==
X-Gm-Gg: AR+sD13jbioMNJXeQT4Def2ckkN0maDg+1N4ZLORIy8imdOPndBso+04ceRkxwJ2U3p
	hDXfbIkWpwfX3zOca3COdnQj99JKZtdJU74Z+BX8jaUcZcOVIMsPhwWdB1vrufjsOKToXq8jSZ7
	NwfQOukL8iyrFTcLgi/Jm7hfL4S1YfFkdJFOuHn7szzOcowJoGF3ejji1wmfQto7Hq0o9F5RJ9G
	CEb8H2zFcjj5Vkav17veufjD/cQir635FhMNCuwK5Rwuldb9cbzq/GPEGBm1BTnVK2sB2av7z3N
	Cls07DQzrpoxPEp3QNatDQbOB/q2JCqEQ1Pv7+senjk9+gPOK1Ypjkg=
X-Received: by 2002:a05:622a:53c9:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-52b566dd26bmr285053611cf.15.1785823805225; Mon, 03 Aug 2026
 23:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
 <20260803-ata-acpi-v1-1-f606afaacad1@thegoodpenguin.co.uk>
 <20260803151417.3DB001F000E9@smtp.kernel.org> <anDy13qZ6rr1tFqO@ryzen>
In-Reply-To: <anDy13qZ6rr1tFqO@ryzen>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 4 Aug 2026 07:09:52 +0100
X-Gm-Features: AUfX_mwWoxNiEiKFO7YpB4PerbiuIoha9b8E02ql7BazlhlXy21NTJ2evt-pFQs
Message-ID: <CAA6zWZJ_TCa4CyEGFd-a-u_NS=Dv64KV-HONhomER2PC7p+EyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: use named initializers for acpi_device_id
To: Niklas Cassel <cassel@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-ide@vger.kernel.org, 
	dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"

>I do kind of agree with Sashiko that ahci_seattle.c could have been fixed
> in patch 1/2 (rather than fixing ahci_seattle.c in patch 2/2).

Happy to refactor in V2 so that patch 2 would only deal with removing
driver_data = 0
in the ahci_seattle module.

Kind regards,
Pawel
