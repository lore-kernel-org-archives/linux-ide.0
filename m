Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCA1B1D5A
	for <linux-ide@vger.kernel.org>; Fri, 30 Aug 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027065; cv=none; b=NCnJq511BRoe1KOEX6fQ55xL/K6h59W5dD7y7Z5ap/CRiENy2Ga4SiiXbyrfXvVWuIslRMCXrkSROYcwTMZd7TV+cbAIzAuc9ckygA4TwtsOlPQghaDnao14BYIoVSM+Wi4OkcdlfxXkvMh7iNjyk2rdcUJ8bt1gjgItl/+MSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027065; c=relaxed/simple;
	bh=Kxo4HM8TfxhVMBqZvduTJba+uKnQyaKejzhBmWp0U+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBkuHt09uGEo8nXBKI0uxie22WvdRI7C/qL5wb1CbPWov9fcDdixizgnfftr+wSqjcElDMsOvnFfFnEUs2YgbFN/iIgBmSmsxI6mbqNl+LascGdk5Tz7WhvxWzHGxfz6P/fgTkRxKrpqdtqwyLv16TXKYmAMbFc+/IGpZL+Ll1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2eMQhH9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2eMQhH9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5353d0b7463so3423915e87.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Aug 2024 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725027062; x=1725631862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxo4HM8TfxhVMBqZvduTJba+uKnQyaKejzhBmWp0U+Q=;
        b=N2eMQhH9RLyDAfTGhaQ6A1VYOnC9U+Qnxb3P1PZYUxoFPrJMX6GEdx9zg+PAxvgkLb
         /VF8vKxjnlhAc7WVVE7c7+3GemYQZ9fr6tc3KZETBCy6LdheLzhMuXVIU0ts1Gufjii0
         S122HqHVNrt75WzEuybeWgeZQIBmLbFxFCmaDeU0mnDd1xRexOFPdrhdVVXBnmOji7CK
         o0NknaFoqJnI3qF240zpngIGu/7UbKXffhfYkIFhKLmtIGVwWlZNziXkBSd2KzZnTE3u
         /uwQxa4pQOsosi9utUrJI53GsEeTrsVnNPZp6IzF2+7Vl54hnqFLfaKu9AybD3cfECMn
         8l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027062; x=1725631862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxo4HM8TfxhVMBqZvduTJba+uKnQyaKejzhBmWp0U+Q=;
        b=GbkShgmhyZphb4fTibCXarrQb0G0d8QIMYCH2NYy/F+Iqo97Uis2IVpVE9sJxmN1tY
         BfYA9LbXJ9/gC1RjFq3yK/z2sB0vNCIHJG70MS4wnqAeAGU3D2oaAzHuVjD7CvfQZvum
         ckU0PmHvVCtLdMhIcYftHOk9qtfwAYCxpf9B4gd4ohCphfejXrlL8/YEHkbyDRINd/2f
         vqXS8SE772sjaCmmu+Jyeq99MSelnEaciiOVeuMgC1MRefBVU8eV8epfl8VY7bceO4/G
         58kAVQcUU/OqvZsoxePsQc1DmnaFrvG5+qdpdir5g4I6FOsnkhyoyd9i1U247BGEyL8G
         AAPQ==
X-Gm-Message-State: AOJu0YxwulRVwUhOefpAYXm7c7JlPbxhnnNjsm5tNV4ummHka7mi0gyx
	Iv2fOyxz+qJDY4mIxl3zSUCAD4hftSGRfE5twql13+mMN2NPYg+0lI8/R1QHVrZFF6vN+0CKHqb
	XbBHWNdjPsFlTM0g53FvJuXAqoQs+k5ZBfA167A==
X-Google-Smtp-Source: AGHT+IEgOnI27T01MkcIfr0sPFDlCvh+HVrjFg8GLB5sUtmwg7JKQJFudrMfin7GG+p5U0cHUwxzx9gE/DikJRKk24I=
X-Received: by 2002:a05:6512:33d4:b0:533:4497:9f29 with SMTP id
 2adb3069b0e04-53546b55282mr1789833e87.31.1725027061611; Fri, 30 Aug 2024
 07:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131907.541466-1-liaochen4@huawei.com> <20240829131907.541466-4-liaochen4@huawei.com>
In-Reply-To: <20240829131907.541466-4-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 16:10:50 +0200
Message-ID: <CACRpkdafzWBQ97up6hMBp_tBajfooTp4fW1E2hvc2pLuB46q6Q@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] ata: sata_gemini: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, 
	dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:27=E2=80=AFPM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
