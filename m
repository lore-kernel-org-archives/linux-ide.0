Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C513146A66;
	Thu, 21 Aug 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762926; cv=none; b=umlr7gDOPY4V3jVrpeU2/lFim9YjrwZzJXtHLGu69PGCmxsjF8Ov6SmoEzsXJmZPRsX4OOikVysiT6TweeDJSNzM4qNaPvCyA/rGQUfA/OLPwSWlNS79EeegiSMjNhuFSq8/8ps+bubme4A4TkAx3JVZELIRqQj6kzltF8XxXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762926; c=relaxed/simple;
	bh=pMS9gP/Ze9Ud12GLJb+Dmughd0PMFtQsq8Kbf0UAy34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM8C51V4wlNvL++NwmiumY7JYrLCuCkDJiOO0LpaEkabJUIJG2iOxc4RW4gh5jlv++iv6TFaUhFkHRKCG4udoJznTmF4sMOmCD4pQXiKBVyCkbLan39LRUIODxTp3FbYXLfHmBmCWmLgQMh0S5Z26qf0cL4Voeyeo9QCyLmuB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0p16hky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0p16hky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4016CC4CEF4;
	Thu, 21 Aug 2025 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762925;
	bh=pMS9gP/Ze9Ud12GLJb+Dmughd0PMFtQsq8Kbf0UAy34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0p16hkyE+Eg6qGPHp5MPJ/nwO/uk5BcFw6OGLAEsEcv/Bv4EWX9MRb9P7N6fNBMR
	 DglM0SXOJhJxSTDkEhIl3IGd965bdK2+Kk1trtPtTxoSlyDTGU5sXFkHR9yMt2zc31
	 FzJ/VgWm/ZQdyupUbFl9zjXhNc5PQFUleXde9bpLBl8BL04Q5UyAogrJzrWbpc1BjG
	 IzIVVxR1KRsNyWFuLHwjgV9q3tgNWpmos8K7Ulqh2maHXtr9pu+Iq+GXh0H7+YVjh5
	 TngHLh/clLjA0x17o6wj5MSBM2wwUbrMIVAsaR+X1fVXeAGBCyju8TbLSBjyHFRnQG
	 2U7Vwep2GWMqA==
Date: Thu, 21 Aug 2025 09:55:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, linux-phy@lists.infradead.org, ningyu@eswincomputing.com, 
	zhengyu@eswincomputing.com, linmin@eswincomputing.com, huangyifeng@eswincomputing.com, 
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: eswin: Document for EIC7700 SoC
 SATA PHY
Message-ID: <20250821-precise-delightful-lyrebird-6b4275@kuoka>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
 <20250820092758.803-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820092758.803-1-luyulin@eswincomputing.com>

On Wed, Aug 20, 2025 at 05:27:58PM +0800, Yulin Lu wrote:
> Add document for the SATA phy on the EIC7700 SoC platform,
> describing its usage.
> 
> Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>

You already sent this patch separately (!!!) and received review.

Best regards,
Krzysztof

