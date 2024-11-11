Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F3189BA4;
	Mon, 11 Nov 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345330; cv=none; b=Jh6NowwNzlBEO/Ye/cWfjiMcUgHwXwzwcAF8cwr+1G9BV+gmN1D+ilPZ/9jNFf4uVgRsSwhO/IVSEXANBYll3DDE1XzNbRWTv4zIqPj9Ej/Kmh7UgeRbRR8ULJrNfmXMuBRrb/QscPU0vDmhYnBNMHN4jgXSDM1tC+0ouPvAc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345330; c=relaxed/simple;
	bh=957efawPGLRyECm/y7zGvsJmyIZht8h+zBAgeR28fg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBZ0oOGJBC2PwZ4Fn3CSkwSkE88Cn2VueTkDlxECWPPxiG9qdM076l9hX17EXW0DJqNnsHjPuQ/RiQspNvD27mBFcnCFCrA6iaJ9fIhOytEhVM24zlQ89CNnB+dOHcHJHbnDEK1Mf5LP3P9Mfc/iVdTR6yW0biRGoCPHKI0rI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fh6FlBFB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fh6FlBFB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=W8thwsB+ljS0lWZ4b7dnqxQ/N/kDhQQW1Jd7+/GQSOs=; b=fh
	6FlBFBQS/bFlsT6PMKK5U9LH02C+3Qm02iYV3yichYa6m0FTJQpA2gLUXF+/BtZxhn02GWnJJyU6P
	9KmOiQDg7WTWYu4AAjLHWd2nSFd+vtLRHcioSOTzvGFv38olkVrLzVA36NBm7nPqEWDyOM0yvyR9u
	Maz6pNxDnCtMFm4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAY0S-00Cunp-No; Mon, 11 Nov 2024 18:15:16 +0100
Date: Mon, 11 Nov 2024 18:15:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <e7a8e087-fb92-4911-b7fb-34521635e8da@lunn.ch>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
 <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
 <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>

On Mon, Nov 11, 2024 at 10:25:12AM -0600, Rob Herring wrote:
> On Sun, Nov 10, 2024 at 3:25 AM Frank Wunderlich
> <frank-w@public-files.de> wrote:
> >
> > Am 9. November 2024 18:29:44 MEZ schrieb Andrew Lunn <andrew@lunn.ch>:
> > >On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
> > >> From: Frank Wunderlich <frank-w@public-files.de>
> > >>
> > >> after converting the ahci-platform binding to yaml the following files
> > >> reporting "'anyOf' conditional failed" on
> > >>
> > >> sata@540000: sata-port@0
> > >> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> > >> index 1e0ab35cc686..2b5e45d2c5a6 100644
> > >> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> > >> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> > >> @@ -214,6 +214,7 @@ &cp0_sata0 {
> > >>
> > >>      sata-port@1 {
> > >>              phys = <&cp0_comphy3 1>;
> > >> +            status = "okay";
> > >>      };
> > >>  };
> > >
> > >>
> > >> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > >> index 7af949092b91..6bdc4f1e6939 100644
> > >> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > >> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > >> @@ -433,11 +433,13 @@ &cp0_sata0 {
> > >>      /* 7 + 12 SATA connector (J24) */
> > >>      sata-port@0 {
> > >>              phys = <&cp0_comphy2 0>;
> > >> +            status = "okay";
> > >>      };
> > >>
> > >>      /* M.2-2250 B-key (J39) */
> > >>      sata-port@1 {
> > >>              phys = <&cp0_comphy3 1>;
> > >> +            status = "okay";
> > >>      };
> > >>  };
> > >> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > >> index 7e595ac80043..161beec0b6b0 100644
> > >> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > >> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > >> @@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540000 {
> > >>
> > >>                      sata-port@0 {
> > >>                              reg = <0>;
> > >> +                            status = "disabled";
> > >>                      };
> > >
> > >I don't know the yaml too well, but it is not obvious how adding a few
> > >status = "disabled"; status = "okay"; fixes a "'anyOf' conditional failed".
> > >
> > >Maybe you can expand the explanation a bit?
> > >
> > >       Andrew
> >
> > Hi angelo,
> >
> > I guess the dtbs_check only checks required properties from yaml if the node is enabled.
> 
> Yes, that is exactly how it works.

So from this, can i imply that phys is a required property?

Looking at the above patch, it appears that for armada-*.dts,
sata-port@0 always uses phys = <&cp0_comphy2 0> and sata-port@1 uses
phys = <&cp0_comphy3 1>. Is this an actual SoC property? Could it be
moved up into the .dtsi file? Or is it really a board property?

	Andrew
