Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EA1B251C;
	Mon,  9 Sep 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875258; cv=none; b=Fqo8sMMJYP8/+V/0wVmqvIYiyqwN27arJrD6zB0BOXbxOdbD+u86IOVE0OEZDHfZhWCoSTqvI+81n12vwpwyGnzSeIjmDL8tXt1+xjY+jhZ8OBZQxzfy4cxePYi56ODH4nEgldC1ZexYxMxsS3BmVq7MXA+4JR6qNIPlRAjI97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875258; c=relaxed/simple;
	bh=e/kAlDWa1B1k46xp0WTBhJchLMBaRYr6uKP/spCptIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0E+NtzmqgS4fLfhIA/BJkyStulSOY+KW5pVuvQZo6nsvgA6L8ewWmMj4hhOl6qw5B1vEBI31f0N7OrDZH3+XO/Nd8PFfGldweFjM8MTrjDElYPBjV3YeVCiuHwSB4/zpsunU7DOVazuhFm01WzTksM5aovobTCYJpoInDwMmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN9RCjHY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN9RCjHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A8C4CEC5;
	Mon,  9 Sep 2024 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875257;
	bh=e/kAlDWa1B1k46xp0WTBhJchLMBaRYr6uKP/spCptIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN9RCjHY59ny01ykQYc7BNnVvhoJEqc07AgZgtmg9xUTecDSGBcdCEC8QR6DWkDIv
	 xpC+dWpFrnBmJmdFInBeJlKRAB/3d4P/spU746nnn82LwCBvxmaRDe/SO/TJ6FBkC5
	 LHpAnzztg4AAEzeSBczY0jS4Uw6ASE6f0MZo6VKt/0/kgydBAL/PPFRKb+3YBPz7+U
	 EC1QA/nUQ5VB2nVLu3TawqnGnAW21lM3BMHfSi81WLUjzu6iTvXQYy5t6IvAS0Ds/H
	 njItifi6YZmoHV2ljYEoZ13rYrixfJ+rAlm//SfZ7oQl7hmEwiEn8DU2pAkRCujGVD
	 NZF2NeGTT2tJg==
Date: Mon, 9 Sep 2024 11:47:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-ide@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v12 20/38] dt-bindings: ata: Add Cirrus EP93xx
Message-ID: <Zt7ENCkvBfoX3OVn@ryzen.lan>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-20-e86ab2423d4b@maquefel.me>
 <172587510301.3289247.9336315361343642952.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172587510301.3289247.9336315361343642952.robh@kernel.org>

On Mon, Sep 09, 2024 at 04:45:13AM -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 09 Sep 2024 11:10:45 +0300, Nikita Shubin wrote:
> > Add YAML bindings for ep93xx SoC PATA.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > Acked-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/ata/cirrus,ep9312-pata.yaml           | 42 ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-20-e86ab2423d4b@maquefel.me
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Hello Rob,

The list of warnings/errors is empty,
so I believe that you have a bug in your bot/scripts.


Kind regards,
Niklas
