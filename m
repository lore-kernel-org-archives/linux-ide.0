Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F6354AFF;
	Sun, 19 Oct 2025 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760845475; cv=none; b=ItbqOhuziULzISf2MNF90ky0f9hoVDGg2L5ol4IyQVyoWfwZAmZ6cRwsmepPQWyOU/v9AMCt31VHie3U8MXPpC8pwkbMnbLlaC0jWGo0Ig0I1PSUvlLe+8qjXvwZ6lNI07XnnpMVEjwdFUy346NQKVSrSE3jEmq8qTQpzNkH6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760845475; c=relaxed/simple;
	bh=USUFDGGqIwzjtisEmi5el5bWKI/V7ivepGgn/YYe28s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFeAEf+FTvsoX55rNbFff2EB+okhDmqI6b6GJz+OnVIpUmHL/ov3H4bCyD0i3pgFfZG/PJweZOxO7RIq/hxKSCXEFfOvJESeQZQqTMMdXCLB+6xWruzmHuGO5hf1/zF7lO2rE+MeCZHlEUEYY5l75Tsjo3NI+lEztI2bFYkyQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idb0yPdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idb0yPdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFFCC4CEE7;
	Sun, 19 Oct 2025 03:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760845474;
	bh=USUFDGGqIwzjtisEmi5el5bWKI/V7ivepGgn/YYe28s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Idb0yPdnYY/JA/jhcSUmHVoTgj6qDo8ALWCRDQvk8qJ4uaK9wtmLLbVoEVklaWsqd
	 wxnsuRIIBmczfmIjWDqcVqO+3fLSgfvNzg+NmQPfOWI1FjyMCUmplJOLnWdtCgssQU
	 c/w3//NiZnpRwbQd+Fe004WQjNnGMxDvaxpZhSfprZa/Gi/+E7Yoe1daatQkRejcrP
	 MbSIus1r+C/OVrrIuZS64JZnqcKH5c4kxF/Lzc8tjceeBxI9m3CCXhSRXvCTF8M/DJ
	 wl67Qyhel7oi5ENHoo81AqP96sMn6rQqjwf+uAQQTXMk5xZ1p71TYgE0ygmP4xopLO
	 18P4PQ6tI/Z5A==
Message-ID: <f6fa3655-c0e3-4c49-a970-22b3c68a0555@kernel.org>
Date: Sun, 19 Oct 2025 12:44:32 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Replace deprecated strcpy with strscpy in
 it821x_display_disk
To: Thorsten Blum <thorsten.blum@linux.dev>, Niklas Cassel <cassel@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251018105146.29808-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251018105146.29808-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/25 19:51, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Replace the hard-coded buffer size 8 with sizeof(mbuf) when using
> snprintf() while we're at it.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Note: the patch title should be:

ata: pata_it821x: Replace deprecated strcpy with strscpy in it821x_display_disk

Niklas can fix that when applying I think.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
