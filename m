Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F21DED52;
	Thu, 24 Apr 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476766; cv=none; b=tyyxPVUOawBNlTtZjyUMu+UAHsOQwIIXxRbq4pzPhCdVQ3Axae3+70OUAObxC8jNnzHkRRiwcoz6c5JYkNLx4EdQjccZDNLtkYw1qpGMj/rsQQm9lFTRHuMRpwmdcVIBePS7AaYPOeVRuF0x5ld/2Zr5HsmB940tU9jLs14Uzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476766; c=relaxed/simple;
	bh=yOgpkbNJBxAQTm4lcyrwml7zvTkMLPvlfHe/6CiBhgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U345Gh/GZYeVJbhyg+zPYFV/Wk4qM7ZJrF0zIhCqDepnG8486vETLsYPbIKc+btP+9R94FcUaS86pAmeWafUBftyuasJefs9veQMzD7HSNEmZgyj4WAX+iCY4c8xrNC0UJxBq69k7XO+sx5z+GkDwn5Gz5ae1wnFrmMy3Ag8MrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlYgY2/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlYgY2/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C06DC4CEE3;
	Thu, 24 Apr 2025 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745476766;
	bh=yOgpkbNJBxAQTm4lcyrwml7zvTkMLPvlfHe/6CiBhgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AlYgY2/PuXz78OI64WUBLLRObKHNskmhlU7gYoLEnsSXK4ITVl9OmcNt/K5MXkvTb
	 Ud2zXpco20I92f0O2wFLcgUZne6IZZh92u6WPPAzxkuesY1hYozvn8qKV5QrbWACJJ
	 Gyu/xuDQ1UODWqntQzgAO6IR9sNhMHdH1SUfMwUN6JYV5mr3wI4mtDQs6lOcvkdtlT
	 Xx504WgfB3ZzX4IC0SJrKuGJjHpZaShf4NyB623992N38CTjZD19R8HSmB5mtCMmBm
	 6gm6iAQJ7rWoblG47oi9Lr22wt72yR3dxpVF90IWrl1o5RKJ+WUrghaaJiIp8ncq+8
	 qCcvS22xigidQ==
Message-ID: <e9e00808-263b-45d4-a3a8-ed9ef1db2cca@kernel.org>
Date: Thu, 24 Apr 2025 15:39:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ata: sata_sx4: Fix spelling mistake "parttern" ->
 "pattern"
To: Colin Ian King <colin.i.king@gmail.com>, Niklas Cassel
 <cassel@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422090940.25612-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422090940.25612-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 18:09, Colin Ian King wrote:
> There are spelling mistakes in arrays test_parttern1 and test_parttern2.
> Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
