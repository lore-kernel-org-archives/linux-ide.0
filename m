Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1C2AE89;
	Fri, 21 Feb 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137376; cv=none; b=B/xb65/tis6q8qD0A61PnGfeCbCT3vv+kaoU6bWN/VKSS0EnTE3f2JZAR3GKLBEKLqCeWOxgdIWFC+BoqgHLEK7oL/2URL3vqCHpyPxC4pNS1P108t1OsllPYmp1+depNCHZeP+0dYJGKnQilCs32ZU2Jg/U/c/+4n9IMpColME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137376; c=relaxed/simple;
	bh=jbk4DEG9UrzRtPvZJWw/GF822FOiEs/xz207ZNkvg8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UKVgw2A63rCQQaGEJI5UHLkJ+AMEW0OJ6Pl0UBGMnAzjNQr0Q4Akw9Ml0TnHlVCxCahoYZ0drhmsunayJG6CiaypjQwZAGcpXcM3G1IWDHKh7UvG2SAAJXQHtV4D19yX5Jxxx2qh0wZ/uexhjqibmdvVG4c/r3GL60Yyza6ebfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbJkkHvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbJkkHvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E48BC4CED6;
	Fri, 21 Feb 2025 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740137376;
	bh=jbk4DEG9UrzRtPvZJWw/GF822FOiEs/xz207ZNkvg8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZbJkkHvc7BWb9Yk62hRMTP+HIhJm8gfW26xn2zOq9MD2Z5oC6SsXvtQqXz7KYl+WU
	 JUEbbb5BIv9Wkinc3cxxW+CVyjOdhZXiMpu4NgWNLKKasqc+biqnvCeRJ2PM3ph7Fn
	 78bbNjzbQBAR9vAJ25jmKWWlvomzdpVi+ERRFpK5WwYsenyfNCTXsEKEHFk9KbbQoh
	 FiRYglRTtzWLcJEBqGtcpyAjroXTn/1aO/RL9+QoZWYsYESIeNGNkf43VYlA/MoXw8
	 46EdZ1zqybfYMDZ71wdF7JI7Yi42KmkxSBudCAaljRxWe/ko4nMCAH0UrccN5+4jMs
	 dy+Wc5yvnLrZw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250220-ppcyaml-ata-v3-1-5e727ab86247@posteo.net>
References: <20250220-ppcyaml-ata-v3-1-5e727ab86247@posteo.net>
Subject: Re: [PATCH v3] dt-bindings: ata: Convert fsl,pq-sata to YAML
Message-Id: <174013737433.11062.6647133485954758533.b4-ty@kernel.org>
Date: Fri, 21 Feb 2025 12:29:34 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 12:49:53 +0100, J. Neuschäfer wrote:
> Convert the Freescale PowerQUICC SATA controller binding from text form
> to YAML. The list of compatible strings reflects current usage.
> 
> To clarify the description, I changed it to mention "each SATA
> controller" instead of each port.
> 
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] dt-bindings: ata: Convert fsl,pq-sata to YAML
      https://git.kernel.org/libata/linux/c/08a04e20

Kind regards,
Niklas

