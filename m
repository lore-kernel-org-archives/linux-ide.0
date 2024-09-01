Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1DB5B05E
	for <linux-ide@vger.kernel.org>; Sun,  1 Sep 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725229011; cv=none; b=uUnfpCu0o5v/Heb1E2hokm3ObIU4ClzrbdnJpx0RWUUJEU14uy5ojIQHh/BSV1OGD81S0SqY8tArQ0LEdEed3N8map8zrMf8R0BNyGQKIQ7Vg9HZ0a0g2aV8enS7dE92PmVygCzUGxFqiFCzIrIS4DDF4Af8eWx7MrJ97APPNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725229011; c=relaxed/simple;
	bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8IPHykZ8YvO4YDHAVhIcEpoS4zprDT5cUFU0bDzlUJcPKWGeC1EbsvR6rRZ7xyoDaOfv/SKKWvc5vpr+XFgb+7UEKidefXyIr6JNqPYiXU7aK0lLZuRFfh3ru9aFGrZjNBz4BCJUAORo5z/PIfkQJvZFSUMMkvS4YNBLKafmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dol4w57w; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dol4w57w"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-534366c194fso3292937e87.0
        for <linux-ide@vger.kernel.org>; Sun, 01 Sep 2024 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725229008; x=1725833808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=Dol4w57wANsqQVNqVFgtVj2afSBRE1fBp85A6HxNqVRhMhBw/qmERsMvPoM6UJxQPm
         5evJ0OgwmiHCj3rj6GY4ssItY83gfT1QrGsap62lsLp9qihawu84RVx2g2WJ8oWN8Xrg
         JzTfT8rZZNiP1kqXZ6xy15nlbE3zmSCZjvgWzOqcrSIZjJgD1QWnZIWWmuf+JCMpIzLL
         ZUvdhxUCmh5/WKjoT+m0P/Qce1c3JyGFdFX/rdIzNJg/u/+2TKoaLOAFgB9GS9rwiEtk
         0x59kVcBR6M8sWIJ2MGOuLp+m79NvU+xOnRK12cyWI69KBgvXapy940Fas74Uf+VTVLX
         mCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725229008; x=1725833808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=W8tXQMv8Exky4X3SfB3f4G6tCFnpRTd2k6DI9M3G4Zix6ARFZWTkFNbm7t1ZCjdsmL
         drLvEP22ojwmkJooyOiAt9pLY17yAuEacZJV+RREa7j+LX+eiicCi+u6mTR1ro5Q4fNg
         Z0md3StEfYhU7AEAfKT6MLgATSktn0vu9UB8Hiwp6A9xq6XlyZ8GgXVVFUnPVbYzZJdw
         lHMNMKlPiMw/4pbIIByxomkPfYB7xs76ZzCrvLcoaJI3XtNtGHnBrdPos/BxiS8hcboA
         sxYqMeJTZ1+49OiwVyrK2LVK+aevMs+0RqGzDWKv4J8u6qz2DtBH0VGdRR4mOPGmewns
         13cQ==
X-Gm-Message-State: AOJu0YxIr2/IEiZO1kKSvzrmlOocF8xxYvfWWcwdwGlQNYvNOS7enJsf
	Cn4Q5USznbsrAGOZb7UiBDmk69yeZHw0z9vp6/Lo5ZP/mGFi8fRZDNA5Vv+OPj4Mjnjk/R+gLq4
	MePhvHnOY38/xJkvROCxmET7Vc4JAiRGL3za93A==
X-Google-Smtp-Source: AGHT+IHdmYET5UJJ7O0DFATqy27z4hgwKG+ELczqFeDgPnXSKCKTHjSkjivQNVE9IMRO9eMHmDXIIjSZEDNoK7exNfA=
X-Received: by 2002:a05:6512:3b99:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-53546b167famr5663798e87.7.1725229007133; Sun, 01 Sep 2024
 15:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831072158.789419-1-liaochen4@huawei.com> <20240831072158.789419-2-liaochen4@huawei.com>
In-Reply-To: <20240831072158.789419-2-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 00:16:36 +0200
Message-ID: <CACRpkdaDcPgMQhBf9cU+oqgCa7Z-CX43hf+NZ42c5o+ZHaR+Sg@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/3] ata: pata_ftide010: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, 
	dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:30=E2=80=AFAM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
