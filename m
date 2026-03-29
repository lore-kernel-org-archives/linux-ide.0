Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14131C3F31;
	Sun, 29 Mar 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819376; cv=none; b=tPTbq+epWxOw+h5+w1Crb+8V5B/k0rtpL/WypUB9xFNmu5kcaQh9BPZh6eCB0IcnWqobLhRn+srJTk8bmaCqJKWteWKzJUQUqxzJzeJVrQaAJIfom8kHkiYRKVq62x7EXdVQlZS80HUh0S2LJXEbEulIGTWMKG/vyplV4OzJvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819376; c=relaxed/simple;
	bh=+XaAq9X+xd94IuMhwVaxum1Q7UZk/vCX7W+vq/sTNbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdYiTQS2dgsrFC6L8IHBShC42OniOk9uYCUhIbmHRnztuO/pJVPB5rthfmYbJQMNi0zHpyaxmZys+p5VH1hyCeEiCvhyXAyqq6d4VihJHzxI/X2QE1ZxAjFmdGWYhwdlUdH8uXCE2X2Dp8IQYMgChOwo1fVfcjqR6WFgKeXGc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1SiD0MV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1SiD0MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A7AC116C6;
	Sun, 29 Mar 2026 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819376;
	bh=+XaAq9X+xd94IuMhwVaxum1Q7UZk/vCX7W+vq/sTNbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L1SiD0MVHlL7Co4jaFikpI83cP/OUFxHGz3nifPikRC27yWIpVCy2qfqt84pUHY9L
	 NheZEFSj7APTNvo7DsbvRnxRUZl5G3eoRgawx98DRym5bB0cUxt8f50+B6gqJ4Yts8
	 /50WvSdPb1cL7lCCy+GvkjGl6QmYIK9FanGwK1vfFp1+IXB5iOW48XXnWpdVdQiAIB
	 pbVDxNQsPWxq/X0SSCPi3Rn6SSMYjvuqO393prpXVjPUo4QuliFTDRgEjDWp1FI/Nv
	 nkWFMLJJQvmFjFA25JkjLcLLyt2t8UqJL0iM4JTO2SJarM57LUSJUQ8pwdfSCzsAyb
	 aSDe8wVelJ1eA==
Message-ID: <36972c66-3803-44aa-bd65-f0cbe59da0cf@kernel.org>
Date: Mon, 30 Mar 2026 06:22:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] ata: libahci_platform: use flex array for platform PHYs
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260328191058.311509-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260328191058.311509-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/26 04:10, Rosen Penev wrote:
> Use a flexible array member with struct_size to combine the allocations.

This is a little light... What about something like:

Modify struct ahci_host_priv to use a flexible array member for an adapter port
PHYs and use struct_size to combine the allocation of this array together with
the adapter private data structure. __counted_by() annotation is added for the
phys field to support runtime analysis.

With that:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
