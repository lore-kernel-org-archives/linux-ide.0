Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF393B9D96;
	Fri, 28 Aug 2026 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896090; cv=none; b=Xk7jiR1pB2KBSiq98FKMpQdW0MMniku8aWGS7K5odME7qgU/Lh3aKAheAk9hYPr8NG88TkSt9pQ8RRg5xTM721ypuOfC37FMWZUZIN2gaPnLF3MlSI1dx8A7RQBI/5sTe/PJAQqOiEz0wT5sm5ChBz8Jr8WnpnfZhCxkwH7prXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896090; c=relaxed/simple;
	bh=jiAlL1EoWIyF9Gh+mnbjM5aU9afZjO3SJrsxN4pbX8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePKcXMkKUwz7ZQoAPDyQjUCaZJUfc2rSNzcQKPmOdL+4h10jG2fO4srn+q6jJf69Hca54vVegkTtH+UNmmS9ybl5DL0rKsXvoiBnm71aGtiWBVHKNrsrnsAhg1X3CDJBheMvCDsuL+FxmjT95fIXPb7JMUHvrZQCKdjiw8md2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR/+KS2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR/+KS2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E481F000E9;
	Fri, 28 Aug 2026 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787896088;
	bh=A2gaWPGue+X3TjOmTWzE4NEqkFoOT6ZEpW0BB9H+IAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mR/+KS2kPtUojyW/nlL2SP+10acq7CZI/JeS4bZBt7Az+tFVQdMGDC00QIomuWoLt
	 PF+ITc8zLF+vkss9bcshChpyrq9M3xVDuUxTwIeR/9lnmIHraAvcffLoSJDlgxN8xm
	 SyEA2asBUIvPO+UuEbOEQRg/yFWqq+p9DErf+QkyC51Q9ZaS6/wwia1Gf9Ae5Cp2SH
	 5fkwenGg/hfClqUjrAF3D6hlC9lnzPqWv8dsALvBKp9Z2szwIW/2AkvAk4p4NzEMh7
	 ElTOEuvG1UqZXEycNKYfS3BvSeI/7OEMCY86XAG2rNkPsmxgQwXC/MiPzklDvr6B/T
	 0RLU12h3krpnQ==
Message-ID: <8418baf3-4a3c-4011-ba5d-a9c2e4ea893b@kernel.org>
Date: Fri, 28 Aug 2026 14:48:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_pdc2027x: fix division by zero in
 pdc_adjust_pll
To: Yang Zi <2959243019@qq.com>, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <tencent_FA2F5F31DC5009EFE7B38D19D754AA6C4507@qq.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <tencent_FA2F5F31DC5009EFE7B38D19D754AA6C4507@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 17:32, Yang Zi wrote:
> pdc_adjust_pll() divides pout_required by pll_clock_khz before checking
> that pll_clock_khz is within the valid range. If the PLL input clock is
> less than 1000 Hz, pll_clock_khz is 0 and the division triggers a
> divide-by-zero error.
> 
> Move the sanity check ahead of the division so the invalid input is
> rejected before the ratio is computed.
> 
> Signed-off-by: Yang Zi <2959243019@qq.com>

This is needs a fixes tag I think.

Other than that, looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
