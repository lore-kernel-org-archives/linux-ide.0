Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B18468;
	Mon, 11 Nov 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357067; cv=none; b=iE3mRe5g+PctQirNi+3/L0bV6O6l9Jb0bO4N/baZ6TXpdH0aJ3JQ4yN1bQLDtWSwb9Tl5oLgp5XPSks3NDWE58P+tf6/ccCBq5SXv8QuRxwC17AsVY84Qjvpa/u8bxrUcjmjYKgJ4WR1jLbDptHZCmhSmknNnSDFzKjPZwncgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357067; c=relaxed/simple;
	bh=4I34QEy3zPSWv8GHju8qDWe1DpbrSW7bMCIC8u+UuPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5hrQWYFXczRtlxBSo4EkJYhgcW7NI0ODOYGdyO3MC7EovhwpT7oi09K9X/gkYxva+tlVuK2FyyTepv4+IOuvDxkVAllpuPoyKx5/tqH19EcpFA43dpiaoiff2zFXbYIVDTHhpqRDf4HBBM16cgUE8cOBVsAVVJ+YeUCShg8xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDi5WtVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDi5WtVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D830FC4CED4;
	Mon, 11 Nov 2024 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357067;
	bh=4I34QEy3zPSWv8GHju8qDWe1DpbrSW7bMCIC8u+UuPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDi5WtVu4/m62hLrLsWTmk+k2LQyfuFh2Di+SeiUbIBR4tcvNGp1PTDZECpd5/M7B
	 kcwCf7mOYQ+IB3u+JdsD07YtrdVR80HS25oNVRB8luHJ3BznoQZa/CNFvYmtOQOL3e
	 vE9w4qkbpH7V5641kh3S/jhvdduolCXX74m/JPaGKCOFo23ocjb4s58a5N9jktW64N
	 6rISV0mb/5V5H1q7FV4iKwxMr5B64iyYbaEOECgYuoHi9/RcIAdogZIx8E7yrfKDPG
	 xY92J3IvGrDIQ617rHDbwCnffqHuzDNbLQfOV2O/DzSKd57MYqjIJkLVSNxpGTAJ2B
	 +hFLCiyJtTRdA==
Date: Mon, 11 Nov 2024 14:31:04 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
Message-ID: <20241111203104.GA1887580-robh@kernel.org>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
 <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
 <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>
 <e7a8e087-fb92-4911-b7fb-34521635e8da@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7a8e087-fb92-4911-b7fb-34521635e8da@lunn.ch>

On Mon, Nov 11, 2024 at 06:15:16PM +0100, Andrew Lunn wrote:
> On Mon, Nov 11, 2024 at 10:25:12AM -0600, Rob Herring wrote:
> > On Sun, Nov 10, 2024 at 3:25 AM Frank Wunderlich
> > <frank-w@public-files.de> wrote:
> > >
> > > Am 9. November 2024 18:29:44 MEZ schrieb Andrew Lunn <andrew@lunn.ch>:
> > > >On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
> > > >> From: Frank Wunderlich <frank-w@public-files.de>
> > > >>
> > > >> after converting the ahci-platform binding to yaml the following files
> > > >> reporting "'anyOf' conditional failed" on
> > > >>
> > > >> sata@540000: sata-port@0
> > > >> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> > > >> index 1e0ab35cc686..2b5e45d2c5a6 100644
> > > >> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> > > >> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> > > >> @@ -214,6 +214,7 @@ &cp0_sata0 {
> > > >>
> > > >>      sata-port@1 {
> > > >>              phys = <&cp0_comphy3 1>;
> > > >> +            status = "okay";
> > > >>      };
> > > >>  };
> > > >
> > > >>
> > > >> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > > >> index 7af949092b91..6bdc4f1e6939 100644
> > > >> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > > >> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > > >> @@ -433,11 +433,13 @@ &cp0_sata0 {
> > > >>      /* 7 + 12 SATA connector (J24) */
> > > >>      sata-port@0 {
> > > >>              phys = <&cp0_comphy2 0>;
> > > >> +            status = "okay";
> > > >>      };
> > > >>
> > > >>      /* M.2-2250 B-key (J39) */
> > > >>      sata-port@1 {
> > > >>              phys = <&cp0_comphy3 1>;
> > > >> +            status = "okay";
> > > >>      };
> > > >>  };
> > > >> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > > >> index 7e595ac80043..161beec0b6b0 100644
> > > >> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > > >> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > > >> @@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540000 {
> > > >>
> > > >>                      sata-port@0 {
> > > >>                              reg = <0>;
> > > >> +                            status = "disabled";
> > > >>                      };
> > > >
> > > >I don't know the yaml too well, but it is not obvious how adding a few
> > > >status = "disabled"; status = "okay"; fixes a "'anyOf' conditional failed".
> > > >
> > > >Maybe you can expand the explanation a bit?
> > > >
> > > >       Andrew
> > >
> > > Hi angelo,
> > >
> > > I guess the dtbs_check only checks required properties from yaml if the node is enabled.
> > 
> > Yes, that is exactly how it works.
> 
> So from this, can i imply that phys is a required property?
> 
> Looking at the above patch, it appears that for armada-*.dts,
> sata-port@0 always uses phys = <&cp0_comphy2 0> and sata-port@1 uses
> phys = <&cp0_comphy3 1>. Is this an actual SoC property? Could it be
> moved up into the .dtsi file? Or is it really a board property?

Depends if the phy connection/assignment is really fixed or all boards 
so far just happen to use the same one. If it is fixed and it's just a 
matter of only one user can be active at a time, then yes, moving to the 
SoC dtsi makes sense. The connection in the h/w is there, enabled or 
not. Also, then the board is only dealing with "status" like many of the 
blocks.

Rob
