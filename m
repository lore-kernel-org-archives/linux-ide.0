Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0325E816
	for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633941; cv=none; b=sPTM3mIo9FjjNGqpsmJZCSjfX/c7h/MSgVsAgB8VR+aSELSu5dZGkBHnVp7zFhm1XrGSe9BOKUIXNknxg9yYC6DAm8XrLIKg9djCAzsIKQ170oDxcTZEFQJ3dSzXjhHUGqDv7Ox5ghxG2uCPDcgWlhivahTXPp11LjMOfXkqQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633941; c=relaxed/simple;
	bh=IIUxs/4EfSIMvPv7qI9Q0O05XnAUY3SOAG85KY6aemw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syUp9fgrt1swdQvJ0Uw1yFqIafLkoDAMgPB2yD5QVb5pp6/7fWUNthdvsIoSwpVB1KYUb+UVDpvSceiqsXKUlniyfhln+OhOqBNli+FmGwVUp1inT10UAYdC1KOqBcrHOuGJqvW1ZS2lWcnc9XD/YctcCnAiq5+Ks45CCcLXdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIiNMnaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIiNMnaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E995FC4CEEE;
	Wed, 11 Jun 2025 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749633941;
	bh=IIUxs/4EfSIMvPv7qI9Q0O05XnAUY3SOAG85KY6aemw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nIiNMnaH2Dccy+JhnGyIMqRcrb4L78GL4/Y1ej64jz9VE6tovCJs7KuRBZCeJs6of
	 sDq7NUTNJG1NTYHgO+n0fH7fFa5E1jcxeie0N48W/SrFx1rZLMlaD7oIZJpFymGinX
	 bXfzG7fib4TcYwkbVOcnupQTg6quVRvNkuFNbbVP974+9dGyw6aXmhwdFrtHiDA/Hh
	 kGo55HLCWif8apDWFjDqdvpTFza4qZyoW4V5zkSLPIm3kyWi8flYn6XNp0sYPgIv8D
	 0HdHx/v0yFKb7RyChYVtI2k3JEFnowcDsSt++de4b/zAfzs4Jt2ZCf1Uk87t+9IQJy
	 uRxAdeY2MmLYg==
Message-ID: <9ef068a9-677a-4277-85cd-d25ebd045392@kernel.org>
Date: Wed, 11 Jun 2025 18:23:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ata: ahci: Use correct BIOS build date for
 ThinkPad W541 quirk
To: Niklas Cassel <cassel@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>,
 Andy Yang <andyybtc79@gmail.com>, Mikko Juhani Korhonen
 <mjkorhon@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250610110757.1318959-5-cassel@kernel.org>
 <20250610110757.1318959-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250610110757.1318959-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 8:07 PM, Niklas Cassel wrote:
> Fix the TODO in ahci_broken_lpm() by using the proper BIOS build date.
> 
> The proper BIOS build date was provided by Hans, see Link.
> 
> Link: https://lore.kernel.org/linux-ide/6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
