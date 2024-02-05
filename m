Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440E85951;
	Mon,  5 Feb 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162823; cv=none; b=SqboGGJjRxMw7YAzF2KDQQHC1GqsV7yz7bUbdf7EiR1pgxu1OC6djNEM37uogb/a1boKWJNhXU/8yofXgovU1cH04gtw+gOpRCPssgqBppengCLouKCWwLKdSOOtBWpuOdWQ0NSW6d00SoE+X9xE2o5B9oOWEaKuR8VDwdce3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162823; c=relaxed/simple;
	bh=ZdS7A06ZAYPJAg5tr2pB7UMvTfB9G021Vu1QVwqFmxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsYy8JFvggCHj4LYROR21fYrG2P4XwSD8007B0Ee7ps2cXm5e9oajgyyoQiQU/3E93UTwpMJ/YG+rM+xn0t4Z70zbnaQHMT+mTMQSozFl6i0gHgbBD5ikOOcO1LBzbAH/NunP8n92muIwvk5ppp3MoFr7LCrwLynHvmQb5kmudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MboMtAGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MboMtAGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A86C433C7;
	Mon,  5 Feb 2024 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707162823;
	bh=ZdS7A06ZAYPJAg5tr2pB7UMvTfB9G021Vu1QVwqFmxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MboMtAGW1BYihuNuJ7xz1HCFVA8bzrMgU1Zl9u4H/FX9imwkoY+7yRW7ygTDTtKYb
	 9IgdN0EhX1IlhnR2qoHBXrZ96ao3ij7AGFt5KyCr7hF/px5nV3g5BnWp7FkM/Xo1Gj
	 nXVhewEN7R/MiLWaRGiQB1D2CFkL/jgmkRSKKlwSCXGzhxKM7C9Xn5/3wVsfIRJszz
	 aMzXxmD1eX0DigfnCu98+PIyQrvxsvXLIDgvDFEjCuzAcEGMr86PCxoolFkoI84wr0
	 8keLahIDtVrLAQFOYaHLrH4UyuGi4fddkCDCQR6kor8XZKZQdGtlTZh8uz9fmIgsk7
	 SotrXb4WO4KpQ==
Date: Mon, 5 Feb 2024 19:53:40 +0000
From: Rob Herring <robh@kernel.org>
To: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
Cc: nicolas.ferre@microchip.com, robh+dt@kernel.org, dlemoal@kernel.org,
	alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev, linux-ide@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, cassel@kernel.org
Subject: Re: [PATCH] dt-bindings: ata: atmel: remove at91 compact flash
 documentation
Message-ID: <170716281814.270322.2449852122042883860.robh@kernel.org>
References: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>


On Mon, 05 Feb 2024 16:22:01 +0530, Hari Prasath Gujulan Elango wrote:
> The compatible "at91rm9200-cf" is not used by any driver,hence remove the
> corresponding documentation.
> 
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> ---
>  .../devicetree/bindings/ata/atmel-at91_cf.txt | 19 -------------------
>  1 file changed, 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> 

Acked-by: Rob Herring <robh@kernel.org>

