Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FA3ED10F;
	Thu, 23 Jul 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792490; cv=none; b=cb9pI8cK2jldgJgsQQAoxgPcyCXG/k13bTzndlhXB4xXXy3Yr7lPKFAJFi3FDPPNWaeN0n/s5XWAlVuEQmF49VkEwkKGnmmI5lFl+qm/CCDh3+nWjrvEC9QPNX/fzp++wL7TdYxmIfbMa20gYbn8bQB2JFZfki61ufch/zyv/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792490; c=relaxed/simple;
	bh=8qdvDlrAWOPhWr+WIhQLzyepfKtgE7dx9YrkIalLCWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN8xvhEShInwE+x5Kk4oGHpsxjhECEgrPJyPXv2Hfc+g/Z8PtgeOlM//2hfsGz81Qo3/6P3Ps5MPhp99yhYfYFBUWYPvYwhG30OhwC/UODUPrTDagKtCZKkIDR3VUU7ejSziggRRXfeF4HfpFAqo+wh592nPZ/7CQOr2dCIPQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK8S7z4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK8S7z4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA69D1F000E9;
	Thu, 23 Jul 2026 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784792488;
	bh=zGYEkJ1ocaMbFFtoWFtq9xxpY9EVxpPjWbXPuEGeubY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GK8S7z4iXZABG0qOxXK0cZq+/N+WkZWikuajpBHhT+aFNbIhfioOpeCjBssu9yP9N
	 qp5QpAJ36fpC3okr40F30IeO/9cFs7sauRy1CinfnmEdlTwrCocbrOIVVKDLMbuc73
	 Cpp49wBH8nrk2rzjAknXPCrwk4Y1bHY5NP9mfOKTXrrQgkzm33J+vneLepTloxvJCa
	 77YK49B6us53jxUC/cnbrNll1MLxj+3C4HNAJdyJEoFQrw4/Ln3SCqOWP0Gtdx2IM8
	 Da15X7H9oXNS6Y8MiJO4PjXuJxlSEKZd4jK1aCeEPnZG5Ow6IuAwiHzv62h+dSDOUT
	 4WnH2d+aIEpag==
Message-ID: <9bb67b07-b46b-4f1e-a4ac-f6e70f15b31e@kernel.org>
Date: Thu, 23 Jul 2026 16:41:26 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_ep93xx: fix incorrect return value in data_xfer
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260720020907.2004063-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260720020907.2004063-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 11:09, Rosen Penev wrote:
> The while (words--) loop post-decrements words, so it underflows from
> 0 to UINT_MAX on exit.  The function then returns "words << 1", which
> is either 0 (for odd-length transfers after words++) or 0xFFFFFFFE
> (for even-length transfers).  Callers like __atapi_pio_bytes() depend
> on the correct byte count to manage scatter-gather progress; a wrong
> value causes ATAPI PIO transfer errors.
> 
> Fix by returning ALIGN(buflen, 2) instead of the corrupted words
> counter, matching what ata_sff_data_xfer() effectively returns via
> its words counter.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This does not apply cleanly. Please rebase on libata/for-7.3.

-- 
Damien Le Moal
Western Digital Research
