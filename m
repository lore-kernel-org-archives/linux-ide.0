Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B235893;
	Tue,  8 Jul 2025 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937440; cv=none; b=JVO8FrmcFWmsG6D0bYtCmK6KK52ISYUyI1HCTrMD3Hq06SePEmXPatcYsPsuXNiTTfFFFc5tA0vYEb9jB6QxGU/PsrIbUspbJerNuRl+IJK5XRklhUraekhy9iWlIvkkTw1hxGLEHGBMk2SjH2txRiYH8SSx8pEynhaEd67txXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937440; c=relaxed/simple;
	bh=VMFtp9/BDb8ku4Vfdqp/2VtgGeYWoFyB9wryiQOhhzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBsse+5XVDgNYscLgrfLy06BuTvgP/uqwnT1SU3FAX4sLmGr97jzvNdYvptxX5lhLsgC+ZjDxCRaN2mmWlRqWQRiAn1v9RI44WcQjZrKI+Nrq7cvorqtVkYpIjSPnWR2DMnduY+iFEJd588CFByw167oM6uHv8zsbO6UmoVlPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKbDD7zF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKbDD7zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4C8C4CEE3;
	Tue,  8 Jul 2025 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937438;
	bh=VMFtp9/BDb8ku4Vfdqp/2VtgGeYWoFyB9wryiQOhhzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKbDD7zF8w4qDk4pklbZdFDk4jq2GcxARdwOH8SqCwfnD6U6PdjdOhZcCEtW7mK8e
	 CoMbhFzgHWhysDNW0B7r51X8uCQZlPRbtywUqfiTAExfE+R+m+Af1aaMJtj6i1Vvq5
	 3u2UTBOIZJCBIcEH+QEibZfeAZzMSIV5RPmzXlWnPpXl1NTXd88dInve2lnRarU2eH
	 ZW/3Par/4Uv0h1ZseTzA/uEu13lrdSRpeU/QhXzHJHo3hh2GPtw1vnCilsHViFVFW8
	 uxuwg2xOMSAwp0OalCsa+0vTqqzeK5778hodRVXAXvQUsijZirO7CPa+m05sGi3j4A
	 huAwPsXMfevMg==
Message-ID: <5331758a-528b-42bc-b57a-5735a8b6e4f8@kernel.org>
Date: Tue, 8 Jul 2025 10:15:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-transport: replace scnprintf with sysfs_emit
 for simple attributes
To: Jonathan Velez <jonvelez12345@gmail.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
References: <20250707122004.224770-1-jonvelez12345@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250707122004.224770-1-jonvelez12345@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 9:20 PM, Jonathan Velez wrote:
> sprintf, snprintf, and scnprintf do not consider the PAGE_SIZE maximum
> of the temporary buffer used for outputting sysfs content and they may
> overrun the PAGE_SIZE buffer length.
> 
> To avoid output defects with the ATA transport class simple attributes,
> scnprintf() was converted to sysfs_emit(). This aligns with the sysfs
> guidance provided in Documentation/filesystems/sysfs.rst.

Nit: please use assertive style (no past tense/passive form)

To avoid output defects with the ATA transport class simple attributes,
use sysfs_emit instead of scnprintf().

> 
> Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>

Otherwise, looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
