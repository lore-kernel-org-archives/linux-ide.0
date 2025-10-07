Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE92D5C97;
	Tue,  7 Oct 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838810; cv=none; b=XDXBg7//e3tRkZXaDtmL43eM7k7sxAnSbdG46hHVCeADeobTqrp6ZZfS76LYH5NNsHNYe/D2TtJl7VAWLJBBpNT21jtra/ovxdFM6sIBDKv8hPOv2u/Fjqe3xjyCLlMAwQSu3CWKD3BLy+mSUiDq/y1OYdSpF318+lQURJcjSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838810; c=relaxed/simple;
	bh=HK8+YNzdJqtVk+JdmSNsEKCE8a3KoVYY3eqqBNJgtTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpFeTUgu0w1WH3RrUy0U/zXJ2Jf80iyhad7zTr+ueR8W9RHpDVD+EBMYEt9xdLHN5VdwfkPCeyTi65CV2FHUmRJ1C3hdVm5cpzv9oR3kn7ipFKXBUwKAs1slZxFm76HirOfa9V8UnWi9OM36xSQnCVLwNCz78D7xTZ3n3wdYiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9HnFugs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9HnFugs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F3DC4CEF1;
	Tue,  7 Oct 2025 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759838810;
	bh=HK8+YNzdJqtVk+JdmSNsEKCE8a3KoVYY3eqqBNJgtTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9HnFugsgsjSf3qUmvnoQj2IC9dFLMdTNCyuLC/hdH0xpOMu58PGWx4xwGWlkafFD
	 et07c9zU6eADVC8Cm0zTzOVhnljLuj3BUKBQ+9knTULdrEdRgKvwT5RFMpSjzuL7HE
	 PZ8F9oBjuRAsQZgk1FwlJOEJ1PM2cEhYr2THdDsZwW0HLwfDWb1I+MckT1xFwDfkPo
	 zanwSU8mnynqbvZcfsprdkiuEhF0HHIZePnHCbgt9cmaWv+Lzako025zNankT3Vd2n
	 pY8csCg0sQ2wt+QOFwAUU0yHL0qexRPtlKo7CWExFnxLc8j03cm4vxrqDiay2cx3aO
	 SMsLFZwvlMr6A==
Date: Tue, 7 Oct 2025 14:06:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: [PATCH v5 1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC
 ahci
Message-ID: <aOUCU28Jjfnk2bYm@ryzen>
References: <20250930083754.15-1-luyulin@eswincomputing.com>
 <20250930084348.100-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930084348.100-1-luyulin@eswincomputing.com>

On Tue, Sep 30, 2025 at 04:43:48PM +0800, Yulin Lu wrote:
> Document the SATA AHCI controller on the EIC7700 SoC platform,
> including descriptions of its hardware configurations.
> 
> Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>

I will queue up patch 1/3 once v6.18-rc1 is out.

I expect patch 2/3 and patch 3/3 to go via the phy tree.


Kind regards,
Niklas
