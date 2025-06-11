Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB225EFB5
	for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634025; cv=none; b=iHKfMsWEoxHmPQPLGmMvvHX8Arar4PXtJHTcPQUWI2/WyrvvhLZ2iIZZyi719WmSCeYKX28RMrjNKCBoXzw+UNAa8ImFSFpSXou+nNYVn6GniDsHZUn3h3QzpLLnUl2m3vGRKUmrf0wjXDB0NiezebNPshsvqDNhu5Kj+sPLF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634025; c=relaxed/simple;
	bh=orkAUVga6lLS3y+a0zh8dW4MlAjcRVJJk8pNv/snsKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8DT3w+zlC9+biHqu65B1IoxatyLZiScupsRXz7tVgDk7VTopovrKYckdTFbEEsmyHzYk3FLRo68CqhBn+CizVSntS109uP1Zl168MbAzug9tjkoGI5d7NryrhSP11HrGuiI6DDJHOKSxS5rIxTnG9dq+ejtXnyMklRaKYsEsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMb0w79/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMb0w79/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC99BC4CEF1;
	Wed, 11 Jun 2025 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749634025;
	bh=orkAUVga6lLS3y+a0zh8dW4MlAjcRVJJk8pNv/snsKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iMb0w79/YuDYvFcEvkusok+e8HBhig9K0vSpelyxU/Qufm4up7RNXhYt0bK8CeHnA
	 fel0ZCSTQxL1e+Lyn7AEOQcw+9JlPXnsv0v6n10Hpi8Wyq8z1Tn6wzdJDsFVQrjVHc
	 3o2aTFzrj7o+AeSKQtjiqIRYTDpVEtU2deZos4y1t4KGHdd5AczRMXELfSUdfWieDu
	 dIrkNY9Q7KcvjgQ7M60iDqZ0NlABMw0CkoPfHCISiten7aViWDX2DvgBjYbq7bnnXE
	 51a9fA+bIfPKZyPcQ/PLxyRWLJflV60QvJLDqg9HiEtQmocRwlImFQBNH2gieGZINA
	 groYFOAeeQrQw==
Message-ID: <2f253dc7-35f3-4207-a662-eefb85e7c313@kernel.org>
Date: Wed, 11 Jun 2025 18:25:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ata: ahci: Refactor ahci_broken_lpm()
To: Niklas Cassel <cassel@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>,
 Andy Yang <andyybtc79@gmail.com>, Mikko Juhani Korhonen
 <mjkorhon@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250610110757.1318959-5-cassel@kernel.org>
 <20250610110757.1318959-7-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250610110757.1318959-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 8:08 PM, Niklas Cassel wrote:
> Currently, the match table in ahci_broken_lpm() contains DMI BIOS dates
> of BIOSes that are known to be working.
> 
> Having a list of known to be working versions is usually the wrong way to
> do things (as this list could theoretically be infinite).
> 
> Refactor this match table to contain DMI BIOS dates of BIOSes that are
> known to not be working, such that this list can be extended with BIOS
> versions (for other boards) that are known to not be working, where there
> is no good BIOS version (because all existing versions are broken).
> 
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
