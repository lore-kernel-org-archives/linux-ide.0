Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C381A08DC;
	Mon, 11 Nov 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342324; cv=none; b=Te1D+qMINo/zplRN9gHFjb6b4lI4raJ3l/+XCHHw37ESPfnKmyMJP2yFEVIkE4hNEoyv5boYX9ZMXz0hLZnKI1IPkn59cP2ZmnqcFHp+2qLDcIoY8nhiRbCcozK/CuTZnm9TorMRY7K/xttLNiCJuvcYsaHximfRkUZxH5RsoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342324; c=relaxed/simple;
	bh=Wwua9rM/eFjlcLBoqht7hKp/jTU0DE2ZmMf2om0pkZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amxTQ9f6tw6e7e2MEUpnOjV8cNGMB2R+eEMw0Yh2YKkg+nvjYsyc+RWakWpnb/LAtz5ooOxlNKhBDuUuIcFgt07lb1ItpwhUbmAm+U4uyLdPVfJPdzaNEw9+rR+/yQlT44Oo57QbwYVOWAWEsG69/3TVm7rHbH4yEe5lstBmWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwCAwIah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwCAwIah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D543C4CEDC;
	Mon, 11 Nov 2024 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731342324;
	bh=Wwua9rM/eFjlcLBoqht7hKp/jTU0DE2ZmMf2om0pkZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gwCAwIah0XWESGZkINHTyQONcGjWsr17M3Nkdxmicdt5J0LWNYRckE/6O9H1FoEQQ
	 6yEjFE0lI0CRyrZN6gcYpB7/6TZCEXy8gmbfETDhAain94qkDgrg5GvujYgSpdakdw
	 gVjfuqa9eFpHral/HyN9sRLo1PEKohks5W9ZcE9GLV99C/9d0QgF2RsrCChevk+swp
	 r8hxWHMx7giIvSb67NI1D5es0KsJA6LZI+z9MuYnxtjRKu2wrwkq9RMMYulnf3DHsz
	 iVnz8cmakjHxfSSxQT6poq1sPhUMdXrF8+sZpbneXN+zXlfAPWuw8dwpohlz7iC3MG
	 7iPO2Z7cHuDuw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea053b5929so35473087b3.0;
        Mon, 11 Nov 2024 08:25:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7q8ZuTisw2zCjDnGjHbHx/hYww+QxHWWNtFl0HLvruihXyd1361x+QCgcWskq0iNL12Z53aEPRPim@vger.kernel.org, AJvYcCVOVmt0CvP1kpbd7edOeQIGmSkots/ZTSW4QvJCJoNJJJbMzo9uYuzK6QC0oSgcDliaKpqdetdQ0bqT@vger.kernel.org, AJvYcCVahpICIS2alNt4aCpcP38MHjkEP0kOcYoaKQW+hBFDONg/tHcVWIYxxUqUFIfWdJGIob7hQcKPRHgD+zJy@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKGcIBMZB0bxSVrfrTE50Hus6y6Qf/xhLAxCd/nTc/6Lqo9od
	/llMpOGBe7vu5hCbZ/tnhMA60MFlYO5PA9YeqleKposfJn2qjVAP/WUdvKJ6QhTu1LtdGly2h35
	NwwmLH/e3xILYP1m9M7xUxzYcUg==
X-Google-Smtp-Source: AGHT+IF4kcrYPr6qGNlb61JHlqDrziPuuMKkOuCDy9aGGNeK0oSpWCmd5c+AxY1XqkIut1o43W6AINGN8ePvB0xLAJI=
X-Received: by 2002:a05:690c:690f:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6eadddbced8mr119662107b3.23.1731342323163; Mon, 11 Nov 2024
 08:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109094623.37518-1-linux@fw-web.de> <20241109094623.37518-2-linux@fw-web.de>
 <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch> <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
In-Reply-To: <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Nov 2024 10:25:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>
Message-ID: <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
To: frank-w@public-files.de
Cc: Andrew Lunn <andrew@lunn.ch>, Frank Wunderlich <linux@fw-web.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 3:25=E2=80=AFAM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Am 9. November 2024 18:29:44 MEZ schrieb Andrew Lunn <andrew@lunn.ch>:
> >On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>
> >> after converting the ahci-platform binding to yaml the following files
> >> reporting "'anyOf' conditional failed" on
> >>
> >> sata@540000: sata-port@0
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm=
64/boot/dts/marvell/armada-7040-db.dts
> >> index 1e0ab35cc686..2b5e45d2c5a6 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> >> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> >> @@ -214,6 +214,7 @@ &cp0_sata0 {
> >>
> >>      sata-port@1 {
> >>              phys =3D <&cp0_comphy3 1>;
> >> +            status =3D "okay";
> >>      };
> >>  };
> >
> >>
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/ar=
ch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> >> index 7af949092b91..6bdc4f1e6939 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> >> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> >> @@ -433,11 +433,13 @@ &cp0_sata0 {
> >>      /* 7 + 12 SATA connector (J24) */
> >>      sata-port@0 {
> >>              phys =3D <&cp0_comphy2 0>;
> >> +            status =3D "okay";
> >>      };
> >>
> >>      /* M.2-2250 B-key (J39) */
> >>      sata-port@1 {
> >>              phys =3D <&cp0_comphy3 1>;
> >> +            status =3D "okay";
> >>      };
> >>  };
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm6=
4/boot/dts/marvell/armada-cp11x.dtsi
> >> index 7e595ac80043..161beec0b6b0 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> >> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> >> @@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540000 {
> >>
> >>                      sata-port@0 {
> >>                              reg =3D <0>;
> >> +                            status =3D "disabled";
> >>                      };
> >
> >I don't know the yaml too well, but it is not obvious how adding a few
> >status =3D "disabled"; status =3D "okay"; fixes a "'anyOf' conditional f=
ailed".
> >
> >Maybe you can expand the explanation a bit?
> >
> >       Andrew
>
> Hi angelo,
>
> I guess the dtbs_check only checks required properties from yaml if the n=
ode is enabled.

Yes, that is exactly how it works.

Rob
