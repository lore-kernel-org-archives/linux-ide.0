Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FB154445;
	Sat,  9 Nov 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173397; cv=none; b=XFZ0yv4x46M3OwqL02abV9o21FB4Rg1tMnoEHrL8tWZIipeSSwTUfTT3xRIABV4HSt8eM8UEGDa1jmWoRpa7/0HrmYpeQUvaoeu2cMmVKmZ6ADeRW0DClRNyHPuzd0Fvrz26S9h7ZpsKGIwivb0hstB6cl8L2M5yTc0jZUdbuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173397; c=relaxed/simple;
	bh=jM0BfYQvrIpnwjaupqLWXPhLW6EUZcGFwcJDSB6UcnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sadaZsnVSF9N89eFCn6dSOwPk8DsQyDTpKCvD43yZX4gnE3eTMhyallWhyRcErwArNAxu+KSFKxLhFlPr4URAAbzJ3TN4KsFPs9PGOy9akZQI3YaMcxxC1r3Wa8jGSS1IbewtpuFIpA3mdj3y3fVYeojqV2SgU0cQ2bQrgPf0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b3XI5w2Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b3XI5w2Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3b7aaELHBeDEdpJDJ7Z7QVtKGMNqkbqGXwu903GOf+I=; b=b3XI5w2YXoS7VgzzcGnMP6gp9f
	wvq0Voo5dd4mmjryDLdv+oMWirO0t49Vuvg8q+iAx0omdNZvfSAHXDogzWaXE/5ZOn5uRVFhjDth9
	tkP1IiJCaRb5UA4mAsNS/iXAjsj8ROYmSraU75DovtndXeV7RFL4JKBVFQCqfKfTBsEs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9pHM-00CinF-Q5; Sat, 09 Nov 2024 18:29:44 +0100
Date: Sat, 9 Nov 2024 18:29:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
Message-ID: <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109094623.37518-2-linux@fw-web.de>

On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> after converting the ahci-platform binding to yaml the following files
> reporting "'anyOf' conditional failed" on
> 
> sata@540000: sata-port@0
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 1e0ab35cc686..2b5e45d2c5a6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -214,6 +214,7 @@ &cp0_sata0 {
>  
>  	sata-port@1 {
>  		phys = <&cp0_comphy3 1>;
> +		status = "okay";
>  	};
>  };

>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> index 7af949092b91..6bdc4f1e6939 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> @@ -433,11 +433,13 @@ &cp0_sata0 {
>  	/* 7 + 12 SATA connector (J24) */
>  	sata-port@0 {
>  		phys = <&cp0_comphy2 0>;
> +		status = "okay";
>  	};
>  
>  	/* M.2-2250 B-key (J39) */
>  	sata-port@1 {
>  		phys = <&cp0_comphy3 1>;
> +		status = "okay";
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 7e595ac80043..161beec0b6b0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540000 {
>  
>  			sata-port@0 {
>  				reg = <0>;
> +				status = "disabled";
>  			};

I don't know the yaml too well, but it is not obvious how adding a few 
status = "disabled"; status = "okay"; fixes a "'anyOf' conditional failed".

Maybe you can expand the explanation a bit?

	Andrew
