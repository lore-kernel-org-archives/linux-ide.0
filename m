Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80691A2C0B;
	Thu, 15 Oct 2026 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042669; cv=none; b=acqyWRD+8RamYmRdb1KkLgBtNUAVhLJsSCmoI/BKC9Jua9PfG21q2aHb2yS87zYhQrxmNcT1Sm+3UrxHoq4sSSSu9Z0TymT5krkSJmoDzX7F6w6cRDxDpCmVbocHghG+fS/ceGGsQyLfAtEfcToyWNm87An+/55ULO9inySM3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042669; c=relaxed/simple;
	bh=eRPofMYnBCfCl542RM3WrRFosCu/RBhbPhw4M22mzUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qweq7lxCwdX6iyTzIunEKPcXtnffD1BRezw+b/y3nM4AOKApuc03OS8QpqfkmpGmxioiY4C56CNzfeOyRhUShAPIb/6W22mrbiDsKuzjUEoCunKnqaQ+dN65DbZUIdZdtQaYGT1N7B1C5dvWUCNlHxgc+aT0q57pei/133qRej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiRcjtXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiRcjtXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF5A1F000C4;
	Thu, 15 Oct 2026 05:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792042668;
	bh=zYg5CWGxSdeKDaRo/A92SDbKDroOZH6PvO8iZ+HbgnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QiRcjtXIJJ5isGPGSe4B+BDrnpUv4N5ymd1+fa/t3BDzibiUB2MR9tcsG+VEDcIFC
	 MOC+z80peHijYscreZj2JsazByj17f8+XTq8thETxT20inFsHjdvD60RQjVejyyTio
	 ENyr2fNhspoIlnCeVSk4DDuDE5Epuu1oK7UY4tuBmWpWNCzvde6uBiB/h2N/oyL4gA
	 n81iACpYmocayG4zGkp1Ujd54qd8MsMhR1Y/Nxy4yKAG3AhU4hLKBoJPLKS6bmJcys
	 0jAoSU+Y2oe8QUueeFmIgxFkrQ/H0i44RHsR8u86FrUc6MiIN5v1LxnUKSbW1SJwQT
	 epTSizKeF34Jg==
Message-ID: <eb21b333-3047-4f8c-a1d7-9d390d935abb@kernel.org>
Date: Thu, 15 Oct 2026 07:37:45 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libahci: re-enable FBS after error handling on a
 port multiplier
To: Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org, linux-kernel@vger.kernel.org
References: <20261012103917.389-1-illofspeed@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261012103917.389-1-illofspeed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/12 12:39, Kyrylo Biryuk wrote:
> ahci_do_softreset() disables FBS before resetting a device behind a port
> multiplier, as required by AHCI 1.2 section 9.3.9, and re-enables it only
> when that softreset succeeds. If it fails, for example because a
> hot-plugged drive is still spinning up ("softreset failed (device not
> ready)"), EH escalates to a hardreset of the PMP link, and nothing turns
> FBS back on: only ahci_pmp_attach() does, which runs at the next boot.
> The port keeps working with command-based switching until then.
> 
> Seen on a Marvell 88SE9235 (1b4b:9235) with Marvell 88SM9705 port
> multipliers (1b4b:9705, in a Synology DX1222 expansion unit): after
> hot-plugging a drive, the kernel logged "FBS is disabled" followed by
> "softreset failed (device not ready)" and a PMP hardreset, and never
> "FBS is enabled" again (twice, on two different ports).
> 
> At the end of ahci_error_handler(), re-enable FBS if a PMP is still
> attached and FBS is supported but disabled.
> 
> Fixes: 89dafa20f3da ("ahci: disabled FBS prior to issuing software reset")
> Assisted-by: LLM
> Signed-off-by: Kyrylo Biryuk <illofspeed@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
