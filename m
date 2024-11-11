Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC8191;
	Mon, 11 Nov 2024 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731283552; cv=none; b=O5W4gDTEX1rWVfYDZNWHhcRXsG/ADlbeFnpdtNRaRXQzsoXtACF5mhSNiFI5IBHFKcJxWj7oxIGyt92Vu+kLVNMDQyJJznbDJYC1w93RSoRPkFQMHRQun7V06LxJBbDUnIi7Ctt0FXIKEn/buZalfPNjck6ST7S7yy3aqHBTilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731283552; c=relaxed/simple;
	bh=LEbk0UwzMReWGMLM1N0ZN67ounf8WzkA5leISWNctcg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uh/RKIsWoS3TDufbg1+eusnmTJ3Iad4Be1PUfH+QHDbcPAmCgmvjffbGV9VJ1m9aHKcnXibGo/fkRRIJUQVjs+GJdn4mfLfmOkOAAOCKPs0lmAhbEiGdtLh49liaOG4KEiPSHVmCx4mNHypZ2Lt1XuNkaWoCRHi72JTAwojLF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgls9w2R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgls9w2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F58C4CECD;
	Mon, 11 Nov 2024 00:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731283552;
	bh=LEbk0UwzMReWGMLM1N0ZN67ounf8WzkA5leISWNctcg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Rgls9w2RaznQ+91jdI4cssdxWso5jSndTFs3MQMRGCKOkHWtccDPVuLuHTwnQ2Pks
	 JqsIyuk86QeOE11KmSrxX1aL4mDG76MH53uKpS/PZEf1wcuimcXG199AXJFnuwyAmH
	 A1gnW0fWpI4xsemcmd1qCW6lVUHh65W7Hdu9epTCTq2Ex/7BeLN+THiwlEUxVRR5oP
	 lUdHVjGmItx2L0W73fc3JOlqbQu6G9mMcS/snX1L/ype6AQdFNBBO9+AXtERM7ol8d
	 cH9y+tu2NyAtO5Nm4Gq59+bK/HGnv3H9rEbO0KSkxGOuV65CawlGZsQgi9S7oHjcBo
	 TXIdRvJZ307+g==
Message-ID: <c6dade2e-fd8a-4a7b-89a1-b1276d8e9106@kernel.org>
Date: Mon, 11 Nov 2024 09:05:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v1 2/3] arm64: dts: marvell: drop additional phy-names for
 sata
To: Frank Wunderlich <linux@fw-web.de>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-3-linux@fw-web.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241109094623.37518-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/24 18:46, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Commit facbe7092f8a ("arm64: dts: marvell: Drop undocumented SATA phy names")

Isn't a Fixes tag for the above commit desired here ?

> drops some phy-names from devicetrees but misses some. Drop them too.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 2 --
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index fe5d6cb9d692..9d45e881a97d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -307,11 +307,9 @@ &cp1_sata0 {
>  
>  	sata-port@0 {
>  		phys = <&cp1_comphy1 0>;
> -		phy-names = "cp1-sata0-0-phy";
>  	};
>  	sata-port@1 {
>  		phys = <&cp1_comphy3 1>;
> -		phy-names = "cp1-sata0-1-phy";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> index 5043cf2eb33e..0d4a5fd9503f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -345,13 +345,11 @@ &cp1_sata0 {
>  	/* CPS Lane 1 - U32 */
>  	sata-port@0 {
>  		phys = <&cp1_comphy1 0>;
> -		phy-names = "cp1-sata0-0-phy";
>  	};
>  
>  	/* CPS Lane 3 - U31 */
>  	sata-port@1 {
>  		phys = <&cp1_comphy3 1>;
> -		phy-names = "cp1-sata0-1-phy";
>  	};
>  };
>  


-- 
Damien Le Moal
Western Digital Research
