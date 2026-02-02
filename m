Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCE239E9D
	for <linux-ide@vger.kernel.org>; Mon,  2 Feb 2026 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770008267; cv=none; b=e1gq+qnOnoUr77/zf9ldxm2c4YbBwKgaI78qVYpeI9N2eJZqg0ZZd015FonFczCJbyak9rE2zYzXIjSKCykp3zCDJapR4/s39D/n+ptTL8HEDpu1G6W+tbaFY5gAD+TMHyQSqAeTmdP3NBVzdHrdcNQlkcdiFw8gjbFZEVzb3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770008267; c=relaxed/simple;
	bh=gcjdZf4yO1RssHgHhP5ciOVDyPG9yUAPD3r1CycRs/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOtaCh8fXQ262W+fwbMjppdfNnKHWzB0lvPYL1mBNagrEDHLEdBkQKgrpowwBHz4Ev7MwyPOZW0p184WW1Q8AujM1pYrjvUzZKYPi0LnkkxJ12McWmET4779V61fp3AmjWjeUGf+Z/QzmqyOoTFWdj7f4rDHUO+CndzA6tEomj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+6qVkPk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+6qVkPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3F3C19421;
	Mon,  2 Feb 2026 04:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770008266;
	bh=gcjdZf4yO1RssHgHhP5ciOVDyPG9yUAPD3r1CycRs/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+6qVkPkYnaFNoP63yFDbXovEU9Uts99Mg6y2Wns6wewILodyEBfbjtEKTkz8rwGK
	 yHbm5OPplzcEskZr0kpvqXgVaWhKjUfH+z3CJOh6qvJBIWPlbqpaLCxxsipWa92ItQ
	 ebzT3/t3/ZKoK9ShxuebfX/7nfbNUHimcA3ogt5kBbE7kiyGTKhhSC9DsQirzyRE9h
	 UMkLzTxjYzkxfryAgjNm+l/TsOmnQJNZq+zDk9vaYmUxZa7iXrWMWTguyuhXx/KIyu
	 sAGPO3clRSrZikQd8/fv7+AL+GweFFJIvUk35lBTm3r2tekxooek9w67qk9O+hxVx8
	 ylMFK4Gvy0hew==
Message-ID: <65f91808-67d1-4893-9fb0-d8a8bb03841e@kernel.org>
Date: Mon, 2 Feb 2026 13:57:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_cypress: fix typo in error message
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20260131032812.12451-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260131032812.12451-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 12:28, Ethan Nelson-Moore wrote:
> An error message in the pata_cypress driver has a typo "mome" for
> "mode". Fix it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied to for-6.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
