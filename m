Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C8802
	for <linux-ide@vger.kernel.org>; Fri, 13 Dec 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049006; cv=none; b=bsV4vxiDvrF1xsMnz4LXOcMkDyGXqN7JZcgl4XwJXRUfhWXz6Z6QrgxhHsEMzSZSx375n9fDjR4uFDw+NDNrOcZqKYu3/KYPMiYMGzo8Ij0y1wk4vSe/Nq38d2boJ5omBz//DbgDb7buQ+LIUSiLvUWqdp9ATu4qF8TjKwbLOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049006; c=relaxed/simple;
	bh=f/AfbZ/Lcv4MV6u2NordctibWy0sKFCNN77jSaCoPD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4f3fPIxP0HtERIRprzQmqejZP/c6kfQDGDbfsfgJJxMoVmfWnWfYh/lOKdB9j98Ouo0uD7GzgC2OgezyL0L6DdVECR0c4nsQLOZX+sFW4LzI7sf1MzGDDla01wBNh6eB4oC1kpFTySQY+0QYTrJiMlblrazKjrH+W9yYYn4d60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zvqpn9IH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zvqpn9IH"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3022c61557cso11187681fa.0
        for <linux-ide@vger.kernel.org>; Thu, 12 Dec 2024 16:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734049002; x=1734653802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/AfbZ/Lcv4MV6u2NordctibWy0sKFCNN77jSaCoPD8=;
        b=Zvqpn9IH4+yjPyG4VwYwYfb9hNgN+OEn/u9/wOFMGvsn/4c2xC8QJ3okSBf4aJr8RW
         xN0WEPL9et9KXnde18fLOuissXQKe2andnUUyZOsxwPAPEcjHhUbtRzh8zuTtLi8f09d
         yfpGYbJd+16eKtkc9SSzFWwfDRdmokIBm7zZ6eo+KOgjMamB03IX6FUFr0uQictiZfu7
         iDawbIT2gGfa4bzchSLV+uYEK4p6pUzmmB4napD6QaYsGKviHWpgy9jAk7HUBJngzj/0
         ++Mvs9xwxbsv8WNCV/D+sKzdO3dT6uDHhp3X3UmzwjgzqRHraKci4KmlZ4K4vA18QriM
         nDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049002; x=1734653802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/AfbZ/Lcv4MV6u2NordctibWy0sKFCNN77jSaCoPD8=;
        b=sKDdO/0b8nqe96dK+GNbi+CIS3xEAQPdI1vTgN/VA96b6PIMbjrZb+12V+8eWDrn37
         1nWLbyD9/+1SwcBXMcyXFe8aLebv7WLPmejIfjNOESUa8INO7He5megoDknPD86LzUjs
         YYCe+BHAlsmErHl4S8maj1OBD2TaO+5sMcwqw90CJxh+t5csq+Y+nem9FSPmNLBtgS9T
         MTx9S22qfmbsxi7zLMjHtue9dree8Edg6KSK1ODRZgtHQ9CnWtsIUjK74678o0HnLiuT
         P44s2yNEUQqVaovQaUTrVGi8OEMgZel9vZxsKz9CNx+JO831PHBnDbgzGIv8/BHCumr/
         TAig==
X-Forwarded-Encrypted: i=1; AJvYcCU8wPcYfybgKObs8bQz+ANdSwWwvva6bAJSwMWaJIvfjFkQRl1XhKf4nyMkA5sX1MQRpmcUlyYKoJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qsy1SUv+mPjkdRqDzKe0p21Ov/NPkFgTESAai2wcy08SjuTF
	ET6PQlp9BGVujBD9e/yaC8XLosCXuLLyU/TW48V+aGr96lXJQM9lAeQjEO3MGlz3zi32POOQTDP
	l0UyzxZfrYs3av+LhQF+Dm375JKkc3EDyYrwdZzxSybEbUNHx
X-Gm-Gg: ASbGncs+aUWOBfEc55t6Q8v6oQv7o6PrFKndD4Ip5Hybd8ede+PIDNJrcZ+jacSjjxl
	QSkPOmPJ2DSS3JTO1S3mJVTQAn/WKPdvrxc8E
X-Google-Smtp-Source: AGHT+IHi5gVwXNphSa9p28n7Muex507AwVByLNdIpXjj9BE+fLY6ChX+4Tt3eZWYhZJFsSxV2AGCweYvOxT65izvamI=
X-Received: by 2002:a05:6512:3b89:b0:53e:24fa:ce2 with SMTP id
 2adb3069b0e04-5409059508fmr88078e87.38.1734049002474; Thu, 12 Dec 2024
 16:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211235250.136985-1-linux@treblig.org>
In-Reply-To: <20241211235250.136985-1-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Dec 2024 01:16:31 +0100
Message-ID: <CACRpkdaAfRjF6rDB5u+-g3c53Cby0FO93z_iGuxNxXF-mMywGg@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: Remove remaining reset glue
To: linux@treblig.org
Cc: dlemoal@kernel.org, cassel@kernel.org, p.zabel@pengutronix.de, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:52=E2=80=AFAM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Now that gemini_sata_reset_bridge() is gone, we can remove
> the sata0/1_reset members and the code that creates them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
