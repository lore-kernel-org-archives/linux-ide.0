Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053228DF1F
	for <linux-ide@vger.kernel.org>; Tue, 13 May 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141195; cv=none; b=eWgSMiOYTDyx8/g/0O8FogrbIp4I6RIeO5Km7r2H1B5X4TkTLoRhn1nbLjK5mz70P9HBoFImJdhLjC/8d8pbVFwLMsuZWUiMtQSwM89kLre+Z0/CXs+W4ivYoK053obZrgyAxxLgng+y3RnG1iy5Y/NoWMmvIn0I8GsWhXtmVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141195; c=relaxed/simple;
	bh=n4HHDxiwyS43Uzo641LVoWesPTkSKiy9kn2zSxXbKcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPeE7jGQstOxtp8+6VyjY8IiC3jz5aYt179B9Y3XUe9z2z5rgz3fD57EwQSetDFjKW2au/lWwtwDfQHSejUFYACmyNy+I07Y7H7s/umin8ZgRvoi0+C2jaip4R84U5jR7pcliHQm5VJitJfE9pCQ/p5YCuJbUxatlUJPxmzSYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T6ldBcNB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T6ldBcNB"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b10594812so6953887e87.1
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2025 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1747141192; x=1747745992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4HHDxiwyS43Uzo641LVoWesPTkSKiy9kn2zSxXbKcc=;
        b=T6ldBcNBnf4l7urO5pmT68baJXZeA7R8P/+U6XzTMi3FuZoCUuZzL2NRk9rty+k+05
         SuFnna7BtyS54XyPwEv4cdEAexwDlDYv39hUU7p5JYgoZm68t4668jB8FyTFmz000fqC
         ShpSObw7v+nwlSURTPjYc32qrck8uFc2Wc8cY+CeRDz7QOG6Z4hNX11LfziCq2Gup9t7
         VGqX5cRsyqiTnBwvKcbeF0XLqnAudGdOo8KhsGMI4pvqxDBCcsnToEj+I17O+YT/xgqt
         ITQT3V34iIrxH/nBc9Fn/FDQr4Q52/9qsFlAbHkd1ogakdNxSRPngkUiRw1P+b9oxy+f
         RuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747141192; x=1747745992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4HHDxiwyS43Uzo641LVoWesPTkSKiy9kn2zSxXbKcc=;
        b=dRP2Vm3knXc7cx0DUBiQrtyLoRuCBlN4AtTSC7rfK9MzJ0eAr5Q3Bpajxl21xcCq+j
         A4Mu/rBCm0rE/rNc/heu37BcYw5eeQIwSs0Fo7zwswnjbMltJmhz2ALFjCVSm2IbBz6S
         ZDUfCQOvMIMVwNlGa5n1lrEn+95FhdATfGtOE0EppGfOGiGzUNSYqUTkL2jhS8CTlyJC
         /bcpRSZjGRvwZlZtUE2945gnRmspPEuMubNhSc6UdDU1Cdc/Oc3gLDY9VadVcnUoOO5A
         iptGiBUcj7wvNiy9QVyAvQyFAnPHas4kaIyAjUDJAu66eJyds/64OUXKdeRFTuuqUVVC
         6hHA==
X-Forwarded-Encrypted: i=1; AJvYcCWkNdDKv+6TUNeWt7Ojg7wP7p+1JncR7MJFr6yEpuod5yC82L1R93PNZhBlum5UJIQR9xiZipoYdl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZGMHOkBWa0k5jo5G4+pCAhmJuplxt/6jCj5UM2WU9sKBF8CH
	y88ytQ8PxnLSW3cXRma9+9cmZTgfhbdsa7qWZDXmQhaGIs0ynD+lTaztupx7znE9UoyQ+MFBOob
	YLXzdLDjYIczdSCtrBkusW2nKnNyqBZh3cfN2Kg==
X-Gm-Gg: ASbGncsOb3SJTb6ouprPcNodzNTjSrdnd9aTE1UBzJu9bSi9FO3gmsgCFiU4KxxULYp
	mx8Bgp8w7jLveGLoRgAKlUGwbqQcd8vtzoox1hoXS4nU6y37Iw4zt3Zciv1/+Wqf+kc+IiVV3HC
	8sWDIkwCTTL1hhFUiGD1qC46uK9wVkvww=
X-Google-Smtp-Source: AGHT+IGh7Gsy/cDcj36RHw2jCE38uR7GSCi2WlmyZnTG93JEw96iwF0JQ45Hv/w3Z+WZa9JBNWhtbqQqNZyXzx3SJO4=
X-Received: by 2002:a05:6512:2282:b0:54e:93cf:33b1 with SMTP id
 2adb3069b0e04-54fc67ac5dcmr6030443e87.4.1747141191989; Tue, 13 May 2025
 05:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512215706.4177925-1-robh@kernel.org>
In-Reply-To: <20250512215706.4177925-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 May 2025 14:59:40 +0200
X-Gm-Features: AX0GCFtF3DYNUj4xgT79oLU0FZ-WXziGOTo8wtyBZoLkNqk-ZheWP3yStomlLsU
Message-ID: <CAMRc=Me1Q+nujB09107-tB+ieAuMgGRfME-FLCqMfvMonyKuLQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: Convert ti,dm816-ahci to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:57=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
> Convert the TI DM816 AHCI SATA Controller to DT schema format. It's a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
