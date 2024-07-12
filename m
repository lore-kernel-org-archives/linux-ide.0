Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06007241E7;
	Fri, 12 Jul 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817930; cv=none; b=qkBjm9iI1SsqezvtbgwKUr+bUyMcHZxDCeox2K+VF7jd+rmZXIBbtFazZh2g0BOyGXv7UP4N7vJDhLid+CXOHcLidcPagA3KgZp9mMNxYOYPgHlO2lHgnXuzNXumt7V2veSmFT2tgfOeOua5YJCwFsUGGmDAKeauKZHGh2vp128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817930; c=relaxed/simple;
	bh=/Q7Fd/xXOpQ1mKISZMwTVDbIjGOOKIIpgxkXDfpf0+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UGor5Rdvz7NTorqvYryD30Yj8EgENWCl760OqtqlyyNh+0tuyWvS5lLKAti1iBvUeUUiM0GLyIMWnohkJYPsioq7fvayRh+QO233ilJSW8gesrEyNDd0fZgZxC3MCrpBzl+MFeLbr4fBW3sUJvkG6iHHKGMOoG/7cr+HSPpGH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt1n0HMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt1n0HMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A508AC32782;
	Fri, 12 Jul 2024 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720817929;
	bh=/Q7Fd/xXOpQ1mKISZMwTVDbIjGOOKIIpgxkXDfpf0+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tt1n0HMUQUQjICfM2n5VNqp07IX9DnFQDo+w9ZxJP7NTXu784JLKzyQFo+1WrnqqR
	 sdwoW8MWj6OR2jVUrGCWQ7cfbjmb6Vo+AN4LmVB9Cp7BCQ+pljgL8EVCrxa72MWc09
	 MlWqhpS5h8faaOeW6YjDRdK77jaqH+lhRSc2Do3+KplG1ouJl4vmtl8QvGYfoMQKZR
	 5Ufo0vL1Udc3pmOlv3RDryZ48XWhPKxafaKuXjabDlEDXl8kFq/7cDw7NSJo0jJFJE
	 gNm6tBpLdWbO/TPWDr7touLLjHvo04QG8kG6WJDcdVfz8dCaSgbxOpAL1rYle2jt7i
	 6l8t/pU5+0yIQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240712185740.3819170-1-Frank.Li@nxp.com>
References: <20240712185740.3819170-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-Id: <172081792736.129743.17961813868575869255.b4-ty@kernel.org>
Date: Fri, 12 Jul 2024 22:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 12 Jul 2024 14:57:40 -0400, Frank Li wrote:
> Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> 'fsl,ls1043a-ahci'.
> 
> Fix below CHECK_DTB warnings
> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible:0: 'fsl,ls1012a-ahci' is not one of ['fsl,ls1021a-ahci', 'fsl,ls1043a-ahci', 'fsl,ls1028a-ahci', 'fsl,ls1088a-ahci', 'fsl,ls2080a-ahci', 'fsl,lx2160a-ahci']
> arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long
> 
> [...]

Applied to libata/linux.git (for-6.11), thanks!

[1/1] dt-bindings: ata: ahci-fsl-qoriq: add fsl,ls1046a-ahci and fsl,ls1012a-ahci
      https://git.kernel.org/libata/linux/c/6739fad4

Kind regards,
Niklas

