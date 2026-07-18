Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455D1FC8;
	Sat, 18 Jul 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343697; cv=none; b=JTd2Bl7m1XDXvu51dH5g8QkXksN3ZqNxpKS9O8B76dJsaKCRtmlKGr6XUbglAJzGVzCgGeZe+Le6heFVtUWMqaeXqfFz+E82twS8J/W8Ev0aR7HT5A2GihG9q0ECBhi6nIOUV79/EbUe+KTDfXmHf7kOiA0qeovva9Fyhe6bpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343697; c=relaxed/simple;
	bh=npGyyjUs6phvJjHySvn4ARhv2watBpNwzKseO42pXrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYdLtQJH30ym1asCletM1jbSF4eyg1uRrs2qhscdlW20Pp4l7Rseb/pdrj9MeXF02AqUPNzGTpGJn1uQyBKwz2X+KI2svbumqzMqx2+PZ/9Mdwr6gPIF5We5WMT0tzptIgkybRYbDuWefxAugc9F91z4C8oD2R7RYuCmDEmvYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZqvCh3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZqvCh3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72EB1F000E9;
	Sat, 18 Jul 2026 03:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343696;
	bh=lY79fQSkUPi5tEHif+7eIRcjEQvvkhMOAt8LtxHkwwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gZqvCh3GBJm33hGx/KoHZt5GXR/DNLcOxBdBQVq3SS39sdJT+aoiGaEcR/K4tOU0G
	 NUtNAzZQ/zXoGQnEs2G2kVlGA1Zwt9S4rkPURELb6nzKCA2BIZ4DAdn9C/coJqmQN9
	 CL5t115OAIEPRV9FlAAgpwervTYcVOaplbPcfZdIPHN2DrgbhsbeLCjiKvaDOVKdKo
	 6T7MXis+WkL2jj+f+oW3vdHwNklEiJ8zMOYJvuoy0hCssmBnC95qq8OXYS3yBZfVgd
	 hpd8Cqa0KV44dFUu8bxO1V7wiOn7nCBlDgpRwKzCMEHv52pC2BwOAhMQPD2mwx7pXa
	 nfkk1uPKR4PJA==
Message-ID: <f19dc95b-31e6-446b-b856-50bd32b69875@kernel.org>
Date: Sat, 18 Jul 2026 12:01:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] ata: sata_mv: use devm clock helpers
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260712223733.1084077-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260712223733.1084077-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 07:37, Rosen Penev wrote:
> Replace clk_get/clk_prepare_enable/clk_put with
> devm_clk_get_optional_enabled for both the main clock and
> per-port clocks. This eliminates the need for manual clock
> cleanup in probe error and remove paths.
> 
> The err label is retained for phy_power_off cleanup, since
> devm_phy_optional_get does not manage phy power state.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
