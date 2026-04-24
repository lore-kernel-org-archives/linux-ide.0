Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5639283C;
	Fri, 24 Apr 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029515; cv=none; b=m7KcZiVc8cuK7PTRF+utrpDiM2jLsJIn2hybQzBqLhJep4ErHDF5YY3IzzlJtRWmn85dZ6nGQZ0JxBbxneDauXeDejJn7G+dAssYNUlKtoj7uNR57F7sG9VrTIquDoEVopQ/O8pu03d0IglvWVMvN+26728BGyVdezTKL2eBxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029515; c=relaxed/simple;
	bh=ehukMGIJo+X8R1y4/oB/v2gPHP/oOer+ZAKLEWbafxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjTn50bmYsahojBOy9XTt7nDEqL/6q8GGfJYPocxTSpTF8lUQkvdi1pM6pdjkuKVV3ycAuPytDGFcEuHakiGdk21BXM3+W26ohqPi22I0yZMN/Q6WuYG3E3Q6BgdN7qqWB9jPKoWygBfDr1M9gluASyRFRseg/PzZqj/EJ75XQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY/8svIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY/8svIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE7DC19425;
	Fri, 24 Apr 2026 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777029514;
	bh=ehukMGIJo+X8R1y4/oB/v2gPHP/oOer+ZAKLEWbafxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mY/8svIxRYnYgLjppPgVSedCEV/9L3GztasrI0D1skQBqIZQVrv657b8v72zSK8Ka
	 zgQagdOMIKpi3ISS0xC4fol6H+9/osCll+A8APHURiy+97js20Kk1Xq9JBKMRYAIw/
	 LgVQAk7YmPq14X6vJOAz2zYh5dR6OnQ3QiFexeNGV1GnSd1BkMDRXC0r/W06p+tVlQ
	 r46M66HyL4tDIeIY631Pt1vS2+QwYE/y8ScG1hV5Ud/08OpWqAUufh98hVRsmVrg0q
	 eyHBUXiHkiPkYW5miIrDwxadCrHLT6vxv2VTaG9cblJxRK8Z4X11AZb1vyVQBnomtG
	 neEhaYTaiylvQ==
Message-ID: <c5a202d0-3938-4bd0-8f95-b4628265840b@kernel.org>
Date: Fri, 24 Apr 2026 20:18:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_parport: switch to dynamic root device
To: Johan Hovold <johan@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260424103830.2616828-1-johan@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260424103830.2616828-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 19:38, Johan Hovold wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
> 
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
> 
> Note that this also fixes a reference leak in the unlikely event that
> device_register() ever fails.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

I suspect that this should go in for 7.1, right ?

-- 
Damien Le Moal
Western Digital Research
