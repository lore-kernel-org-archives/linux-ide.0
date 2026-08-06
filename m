Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604047F2FE
	for <linux-ide@vger.kernel.org>; Thu,  6 Aug 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031827; cv=none; b=h33u1D8e0WuotXLd35kZ6AvT4Vhu7fNQy4sNofCuYCnIeTYTl3ENvZlMwpRjdBevFdyiL4tFfhe2uL2ZCjIsKocixTeK17rmzI1XKVKVWR2ED0PVAjVqUXHXMoeEYaftU9wqIV6KNMmZWG7u7bNh/Ig3L4n8K2JEVRTa99pVcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031827; c=relaxed/simple;
	bh=mkuxmS/E8bTzjBoW0PzBnM15rNLoq1eEulFD6FgdHMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+xRWp/eR/eCgCz0rTcSiqdAcq/6/tiYM8Vu8VtXLy5GH0lOC+0EEF/slARXBDwnbgn1Dl+7FGpKnHO7J4+lgAEsR3YNi40SZpsjiIX3L7lc02N3wzI8Oo9+wV42c5oahNNyV0c8GnSKT146oqiC7O3+6vl+grPyuYKGlIdS3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=japknXB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="japknXB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93561F000E9;
	Thu,  6 Aug 2026 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031823;
	bh=kn56IHSbgAZbQGKaoL59Rp4SKIztyexJGlCvWfqqYLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=japknXB/0vHOH6ZN95ZKbgezt5fPSK7RuzOeK1oyTLQdx4W3ohMrhw5PGjK35Skz1
	 5fdfUzgL5TKFBroNgnzOIVhnUK/PQC90OgIxJRZIAOgPro5eG5PdoOke3NNV+Smv7P
	 CsD58wvJ1GPo3cQjNJtZ3kKlAMZwDQVwoQbiW+5qCxz3bvBeSRh2V/mFcHNla/zrO+
	 TKl+XrxogMcEqGyTgXLykXK5siIjMEgFEs5C6ISOCbgJPik7XKZbUw0cODDqRBHfuf
	 fcdf+Iav4Dsy5hnEtygSfQ4KEneB6ytWJmTGaNVhQtWv5a8MBEA9eK7gAMg5MNzdoe
	 yDAFBlt3Kn+Ow==
Message-ID: <40d46bbe-bbb0-45d9-9a9c-e9e06fdb5ae7@kernel.org>
Date: Thu, 6 Aug 2026 08:56:59 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_sl82c105: fix bridge revision use-after-free
To: Hongyan Xu <getshell@seu.edu.cn>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260806060628.1658-1-getshell@seu.edu.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260806060628.1658-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/05 23:06, Hongyan Xu wrote:
> pci_get_slot() returns a referenced PCI device. Commit 44c10138fd4b
> ("PCI: Change all drivers to use pci_device->revision") replaced a
> configuration-space read with direct access to the cached revision field,
> but left that access after pci_dev_put(). The bridge may therefore be freed
> before its revision is read.
> 
> Read the revision before dropping the reference.
> 
> Fixes: 44c10138fd4b ("PCI: Change all drivers to use pci_device->revision")
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
