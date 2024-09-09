Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3A1B5313;
	Mon,  9 Sep 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875114; cv=none; b=btmrR72PyBJ3EWUHpwmdSWqWb2Ypi33OBzQvqrui8IaWn2ZjYZ3vyo7zLUzHvSkL+7IsAaQHg1pXrlx/gYDUHYZgX2DkcNP8oHL5sPS+scZZyZ0QHtKyBjSATuHZZH8qkbhQdSYG3u3ORVTA63WR5+3lov2cxi/gAMirO63NmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875114; c=relaxed/simple;
	bh=bt5mKiB24t0j0a1fHkKudGsM/fBWfeJBRKzl9gUDXAQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TtQI137qNoH2FoTZE8nRrz8fCxC+2JRcYMN/3/2yYMVMQUucwsRH/mg40Za6QvCti6oVMMDkJIS0x39DCZ7uqPUxnkMC5si37VxjOSD2WpQB4dDivIY9pLWEb1HW9QzGf/YZ8olXVz2bj2v4DyxNmEa8wWq5am6poBiN4BApZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFUQW+LN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFUQW+LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B22C4CECD;
	Mon,  9 Sep 2024 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875114;
	bh=bt5mKiB24t0j0a1fHkKudGsM/fBWfeJBRKzl9gUDXAQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lFUQW+LNIMOwbDWSscwINvfWMqIGXwZS6+xyeBq/HvfluKoHlWuNcbagt9os7zj7q
	 g1m08dzrigEVy3Ijq2hHAF7yG14n2nRK0xLrXvJ0OTUXJmq0zCINoJShSOnZGIu92C
	 6uYEwOQnN/+RVUVNKS4TMC5cXr/a0jktrhtIdGVLCLGHczs7daeVx1vr7v7BuxsvXv
	 fCBaDRtqOoOPAKiuRP4cdwMFOH8oadsN2zZHVYVFjUYNKJjy/A0/0llRYZ3D/0pwbg
	 HwMiZQD4FxFIRuolx9ZUtcnP6dGVNJ2PHyiukY9cDeT5EwtJ8zh0KM0n7TOPWweIRT
	 DwiN0FlDe4dkw==
Date: Mon, 09 Sep 2024 04:45:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240909-ep93xx-v12-20-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-20-e86ab2423d4b@maquefel.me>
Message-Id: <172587510301.3289247.9336315361343642952.robh@kernel.org>
Subject: Re: [PATCH v12 20/38] dt-bindings: ata: Add Cirrus EP93xx


On Mon, 09 Sep 2024 11:10:45 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC PATA.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/ata/cirrus,ep9312-pata.yaml           | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-20-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

