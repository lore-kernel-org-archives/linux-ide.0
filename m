Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B772D8DA4;
	Wed, 20 Aug 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676729; cv=none; b=NbZLbcnDcUhvHa3wdVL8DgEQUqlhVysgsLjRNnJ4IU7IIgsAr6hV6xJMwrlJahNSdLLpKw/m0L7Tp6cXQT+iIPrAQJFG1pSbGVg1U/F9I+0E0Qkn4ENvvvZCFKXFW5/52hrjRAqicJwZd58eN+Pk1zdpiB1s9kYQ2xhzYUorK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676729; c=relaxed/simple;
	bh=WnrhhdMtI7/F9O/pOiU3j1XA4mpO8xgwkcvbcF5AwD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDv4yPqXG3U7kUJLUmmn5iRnREbp4ofWllq9ctkvNLechr1QNbRQj7DNHMKxQteqJCJi2L8vKdOyzwHKasmzwEEjIXqc5HktPETlX4ZTkVGa0YrRTbY9B24YUM9MvA5gLMp1O2rQvccEd4EkSJmOGKUZDT8++Tf7IEkIsjGrjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbVjVzRw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbVjVzRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E222C4CEEB;
	Wed, 20 Aug 2025 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755676728;
	bh=WnrhhdMtI7/F9O/pOiU3j1XA4mpO8xgwkcvbcF5AwD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbVjVzRwBd84zNM+RHvauv1MVTtgCXIDxi0vtBwcp12V6ujGfY8Ms+sAzJreFWoC5
	 aYsM5UmlBF8SDMjrvLgusnaVtYlTigwAFjwuLXEP/xnwzxfpiEZB77n5X58J9XfUSq
	 rbej6rLRCxKbcF81GkgASbMkAp2gOSvk/1QBUtF3O+GWxk358OE+asra++WfhigFCJ
	 vJ/9gHhPUr5aNjEoiUOexbLtkKoUJ6PkN/F26TDCgXXl+5lrobII6hd1vQM4UOZCv2
	 D2SXcf+Mam5uQD3gXRDoftIHsNRRgk13+HKs0GlGWCFF1SkgiIREX94RZ0sID0ITKg
	 Eejz9W54y5LpA==
Date: Wed, 20 Aug 2025 09:58:46 +0200
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
Message-ID: <20250820-cheerful-avocet-of-tempest-43244e@kuoka>
References: <20250819134722.220-1-luyulin@eswincomputig.com>
 <20250819135833.1227-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819135833.1227-1-luyulin@eswincomputing.com>

On Tue, Aug 19, 2025 at 09:58:33PM +0800, Yulin Lu wrote:
> From: luyulin <luyulin@eswincomputing.com>
> 
> Add document for the SATA phy on the EIC7700 SoC platform,
> describing its usage.
> 
> Signed-off-by: luyulin <luyulin@eswincomputing.com>

Don't use login as full name.

All other patches are missing, changelog missing, cover letter missing.

Best regards,
Krzysztof

