Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C58225D7;
	Sun,  1 Sep 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725232164; cv=none; b=UGko8tLXhwC8Axl+NeCp48XFa2NWJOVxUvKy0Ou/ContJqlzaE5mq5Zawx6w23jf+5E0L0Sa5T0RKnsXTu9mkbos54E29woOpUtuDEiu/ItYNxDNw2+ckprCsNe3IoGtRl2suA7cO00H/7ysM0eon/TGE3LZScbhyEzV9TXeQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725232164; c=relaxed/simple;
	bh=5Re48F3JclujPa/80a3B5NtTn1HN7Tu1GahftBXbAwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eu6g+wCSqKmo8in63EgaIuu/3KyX96xtDek4/7PeBCDPTbmTtaKmDDVNcu9y8eEMCHwcV34cOooY5LpJ3DrEYyGbCLXRe4CDDi7BdU0M53GAxl2js1yWQkfMCTGx3uZJmsumHXib67DWZzAosdXTRs2/fJbgQZAXNNa/py5l+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2tkx26L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2tkx26L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB66C4CEC3;
	Sun,  1 Sep 2024 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725232163;
	bh=5Re48F3JclujPa/80a3B5NtTn1HN7Tu1GahftBXbAwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o2tkx26L2cSU50aNuJBg01KApbuPWSZE0G7awz1Kgn7HLWBQ0O//agwOSh2bS6Ie5
	 KqpSt5DpIb7tDcF6SQk5jRi8poxlY8ZHZeqglg6j7JkGEiBmA49eElstDo7x4HsL2a
	 K7T5BlbperzqyWbAR7UV/jSFF0m5Jw0E3qoNksabAUfg6YvjxJegW3Ul4WDYsKGMq7
	 8VpwkYXO+2aMYJUxWPXFtTW+A3qz5TkrAktdRkMibMIk8zqiHyGI4PBfSBH+qitC4g
	 Uj8JPF95i+s/wcC0Dy/oTp8w5xnoUoFFMcXfNfhTfkcdn0FtgcKaVdFF5jGSH2ha0R
	 hqBuh93NwlAiQ==
Message-ID: <0a080e02-c21c-4a6b-9e6d-a5d0a913fd9c@kernel.org>
Date: Mon, 2 Sep 2024 08:09:21 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 0/3] ata: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: s.shtylyov@omp.ru, linus.walleij@linaro.org, cassel@kernel.org
References: <20240831072158.789419-1-liaochen4@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240831072158.789419-1-liaochen4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/24 16:21, Liao Chen wrote:
> Hi all,
> 
> This patchset aims to enable autoloading of some use modules. By 
> registering MDT, the kernel is allowed to automatically bind modules to
> devices that match the specified compatible strings.
> 
> Liao Chen (3):
>   ata: pata_ftide010: Enable module autoloading
>   ata: pata_ixp4xx: Enable module autoloading
>   ata: sata_gemini: Enable module autoloading
> 
>  drivers/ata/pata_ftide010.c  | 1 +
>  drivers/ata/pata_ixp4xx_cf.c | 1 +
>  drivers/ata/sata_gemini.c    | 1 +
>  3 files changed, 3 insertions(+)

Applied to for-6.12. Thanks !


-- 
Damien Le Moal
Western Digital Research

