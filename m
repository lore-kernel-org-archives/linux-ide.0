Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E61C245C
	for <linux-ide@vger.kernel.org>; Thu,  3 Apr 2025 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662107; cv=none; b=FEKmhYVrPAz1fNKcOjRHBMNOc6jxd/n+dp4cUP89qwM0y509+O6zFvLrg56I3B/HHN7sDSm9ihN5X1LonZ00WRh68MzllSOjdDQeBa4MZ6Rf+OAOPB8lXjNDPZBfwoj5DpfmSJj0qHheYVgLfkCsYk/BfH9QSSA3NMZtK29Voiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662107; c=relaxed/simple;
	bh=1JsCMyMtHNZEI+5vuESB4ZV9tP0Yf/T5eFYH1f3W3iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrzAvXZZ2lhDUhBZ+Lz7qfbuMAKE5vixX6+OB6t1CdUWR3454C1YrpIHqN0S1IP80zqvZ6TnI8sLBYZxEXonYQ73KKlkOIXO57jaj4ocy0jF0ihPGLEZbJlPhPEQzmo1EPaWUjX+7mc+8Fi4aiWyJluz/X5a6aTvIS7X6dNeM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=n2xxLicc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="n2xxLicc"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a04so5258031fa.2
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2025 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743662103; x=1744266903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwVbis7FD5WGTE3kHS18ntG8BxtaZlcsMBrF4lyJnN0=;
        b=n2xxLiccuG8vsJ5RIDzmY5zehOua4Gobkrpe/P4f6ij0V7hQglsX1Eucwu+2udMBtK
         ewVERc5J1qlJOevE6gGfmdEcvFNR5KThK1dVZJcV/yR6vu9FVrvlnDWWKjcnTqmWxot0
         B/nMo56A5UiOeY00bjKachIgRw0UZuhqzhOV6TbqVLEygbcZrSsrziGPfw46tNdtSLZ1
         J9a965UZS7mpTARf3+9zCuc/XsAF1xyYsgpcxE5dRG4lOl/EFA0/98ODiaUQGDFIG3dJ
         9cjAdTnb+xaG3O9P3aHLZLt88JXO8sbW7yUTuyBaAgeisL3nOtDmb0dUpPbbX2tb7HBP
         VNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743662103; x=1744266903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwVbis7FD5WGTE3kHS18ntG8BxtaZlcsMBrF4lyJnN0=;
        b=Qu835KBWqG2QgnmHAzrKnExcMbBJKIWJX0hOkW/twcglqj/3fhRgKh4Xg9eugRlcJt
         4dlE4J1DsjCVayR0FlOHwU7A5WwdSm9hyPBS5BxmOncrw5OUzG4RjUSBSe58BRHGcE2s
         NAo41kMn75nGX8xLRZbOgOh4E7EkbmNrAkkHq97bmQBmqBWK0IjSGJbIzKlRzHs2IeBo
         HgCK3/L4UIJR9ZMMmKXn2VemmRqOwLGlMYxD9/fAdbFCn+3xwetndR3dbXuzn8FRb9mh
         Cw2P43ae7KKzujaqXHTE8ZqJ9OEHm4U2QVcib8f6Xb5CDp9wlpKAKma0awXAbT+8VHsc
         XCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIGZHj2z9pFf87XeDNTtXv746kbA9+GHoWML2+15BwfiMeSM5VSuzT2gxH0iteuYPBrtjUWbbQW2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBVRWS5+TtGU8NiPbOtKzXOaWPmUzTQKoyEVUSZxh2z3y6QBi
	8+zN465ZMULKpWTrQjbf0b6oWUXkkl/tOL3ZdfGh8VEmAo90yvcHURz2PO2FLVDE2sAtNCi1iSc
	ohUeLxG0K3n9LyqQDTGHRvC2Wo4HOwnJorGl/9g==
X-Gm-Gg: ASbGncvnL6ntZ7thF2G31Ayf7MXwu1LpXy+DpbJ+YPU/JuNYFMEpXTSMgK9/bs5NDqU
	PcmjNCqHDZtMo8+ji6dp1esJBs9f5QWG+NyTyI+MyGVhv5ca7n/494fo/eh9ejLOO4fnSOQxNIp
	tOCKpfyaJazmGyjU16Vm8D2xu2xcj7dNn1SwUB3zsaVzr7QsNS6Pf15kI8VPxwCP1OaMw=
X-Google-Smtp-Source: AGHT+IEPn2huBHKsqDAGWpve5sAjpBNBnpMsrd2sYo/j2hYHK0dJ1WibZs+8/GvHbHlhvGsJDnxEjzhVpbqKnYaGX7E=
X-Received: by 2002:a05:651c:144b:b0:30b:b987:b676 with SMTP id
 38308e7fff4ca-30ef90cd023mr19356701fa.2.1743662103234; Wed, 02 Apr 2025
 23:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403060836.2602361-1-mubin.sayyed@amd.com>
In-Reply-To: <20250403060836.2602361-1-mubin.sayyed@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 08:34:52 +0200
X-Gm-Features: AQ5f1Jo8XE_rqZUxS52BXanujb5HYu0Iq_OMLm_FELFmKt0f3v36UDRWRst9x2c
Message-ID: <CAMRc=Mc2DKnc1AM2WSApZtwOKCFGNZ9WF6LzzkECaV91R5w-iQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: xilinx: Remove myself from maintainership
To: Mubin Sayyed <mubin.sayyed@amd.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, michal.simek@amd.com, 
	p.zabel@pengutronix.de, gregkh@linuxfoundation.org, 
	radhey.shyam.pandey@amd.com, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-usb@vger.kernel.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:09=E2=80=AFAM Mubin Sayyed <mubin.sayyed@amd.com> =
wrote:
>
> As I am leaving AMD and will no longer be maintaining
> these platform drivers, so removing myself from maintainership.
>
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml        | 1 -
>  .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml       | 1 -

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

>  Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml   | 1 -
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml           | 1 -
>  Documentation/devicetree/bindings/usb/microchip,usb5744.yaml     | 1 -
>  Documentation/devicetree/bindings/usb/xlnx,usb2.yaml             | 1 -
>  6 files changed, 6 deletions(-)
>
