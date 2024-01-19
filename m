Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347274C3D0
	for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665222; cv=none; b=OaNicPJB/T+NxApAIejaWdx6ytokoTvjNKfQrMZrtdVQboUu0o/93T1tVyQKyjI9xisPp/LSB6loNqQLk6l9BTZ5TORzQp6EFSU6T9avBGGZb/aegtktnAx05UVF3HQ28t5DUa6pLI0X+a8bCzn4OnnBmT/QwNMjm+S/4cgEViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665222; c=relaxed/simple;
	bh=l/9ghh5sZNG50d5xIaj7ON6EVW6p2iNzyQioT697ezs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfN7W2ZTObtfgMoHU7pOBaoVf+SiBjzmbxywd/5S3euhWlC67/4uWZV1jzWZ0UVGEw9e2oEI/czVk3GF9t45mfWCdAwEj030tgp6GwJN9foVe7wuxgRy73Kl6AEgAS+2HLJVtWCB1BUYbU5mzacNgcEz2O2yQXDMpkrv4eIH7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kmhQ8tcb; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kmhQ8tcb"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso68592241.0
        for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2024 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705665220; x=1706270020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdyfVh6//9O93MHLA2iBuWLwQbIIxJp93yFjTXEDrOA=;
        b=kmhQ8tcbokOmRRB+HNfrE/jb4dfO4DiWfjv9i0QuQqT/8nq6QF1yI2TN8YhLLl3ykD
         y/jqObSlstXmLvsZcgOnUCxhGz/8MWGJm5QYnSCIAhcV1wdSuSgjl2lUcoDawPEbyEbD
         rEB16Y06JQiXfOC2PlgI3MYSBOQPiztJYLXgHdpf+m0HnUmQs9ql8ilTEbg/D29/KbMm
         Hr72pmolyhQ61/5Cqc3wGAk4vZwrIhya0iWOdnw5+d/L51aNdgaIYIOctdwoWNYLeF/O
         SkXn3TCstVWHlj/+NcEmRkLHRhyw8tqF204VZO0/eF0dmxD6r2gWhM0c7lescTsX0TLH
         y3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705665220; x=1706270020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdyfVh6//9O93MHLA2iBuWLwQbIIxJp93yFjTXEDrOA=;
        b=g53meKUi/MLb3izpQbbCq3i0Aznjm4ci5x03sf8DURMYHcwec4B3bicNUxW7S3Bc0l
         lnlnuLZMgv9za69mlmRsA6G9UNUd0t5QK2fcTxInQxa1T/ZiHeoa6uZyxknSVSht7A1q
         H2dDdVdaiP6F5zJ6WfaK3V5R5h0axRGSjkYaJ1bhT2oSDw7F6RAXG3kI0UfRJE4U47BS
         oAcvgrqZbqcvq7VjwZryv44UTrZfYwtKJvBgT07iZjGc/RHzZ9fqDW4ORMKzExkLWy0b
         FXrrdzdNqQrJJNrh3FU2WH9EuT0Q74HwsijWIiN/A9KTJEKNWJEZsnnh5NSyE7ZbVZ5i
         i7kw==
X-Gm-Message-State: AOJu0YyrANkgiaL/DnTyDfCFfE2jkp/OwFgN2UjCBSu8ch4g1eWOpPRZ
	ROYuLIT7GFQw1vXnmqIEs9A1nrcJP1xk2PmfVWXDKQcBKRXOFk1Ng9WQwMbPqUdNX/QMvLsHD5I
	qfH+hQc7OlCt4jeCevmTrhnLkfaf6bRZT0o96Qw==
X-Google-Smtp-Source: AGHT+IHQ3U9Hg9WEo4Q/SGuPbw2OLuTsK6SdCFn3dBtBA7yPPGLxrDq5Ybq2Sbb9Q+mVkFk1I0t3rMA8IdEw0Rv+tzI=
X-Received: by 2002:a05:6102:ac5:b0:467:c4cf:cac7 with SMTP id
 m5-20020a0561020ac500b00467c4cfcac7mr1929825vsh.14.1705665219501; Fri, 19 Jan
 2024 03:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 19 Jan 2024 12:53:28 +0100
Message-ID: <CAMRc=MeatMgQqase263xfsLRcSwMjx3Xwprt78igooYT-+8NaQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, michal.simek@amd.com, p.zabel@pengutronix.de, 
	gregkh@linuxfoundation.org, piyush.mehta@amd.com, mubin.sayyed@amd.com, 
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:36=E2=80=AFPM Radhey Shyam Pandey
<radhey.shyam.pandey@amd.com> wrote:
>
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-mode=
pin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.=
yaml
> index b1fd632718d4..bb93baa88879 100644
> --- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yam=
l
> +++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yam=
l
> @@ -12,7 +12,8 @@ description:
>    PS_MODE). Every pin can be configured as input/output.
>
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>
>  properties:
>    compatible:

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[snip]
