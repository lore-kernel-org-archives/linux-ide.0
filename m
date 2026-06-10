Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30346390CAB;
	Wed, 10 Jun 2026 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082589; cv=none; b=Zr5DX/2akR9g9L23JqVLcXjTHNCkXX/IZ7ScLY4xK9OGlxsXWVkYtBFRBBU1maPEYkPhnCYD/DKTBix/jNC0C4nRH/QdMf3neUAc0ygocjKuGGzgAh7ANaapou0lRS1+AoeBJvDjJ8bw8eOhlWE4UFVTU7M28i1jFcmNQlVtbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082589; c=relaxed/simple;
	bh=39fZIPaUvPVUALkmFJPLR/kvAeDikc31/ZzrL4xItuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GidNFSDqiiKiZ1BnT9gKybxHwh0xWs3/sG5JxcmKnBUZQazwTp1MxKqSOw4fXWO9odP4ezzBmMao9QH28ys3SG47n/3J5h803XwM9HqgqQwllYeKOuJsbfEmgxysZNFi0DPxb21+TgdF8JsGB8EU1k1gWIBo4QVZWGHV4F5ukpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWRh5gNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWRh5gNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9EA1F00899;
	Wed, 10 Jun 2026 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082587;
	bh=6g0iqJ8R+NcHv24vqljuiDeie4kCaSU9N3qQOrHFh54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QWRh5gNpzwGu9OiDnq0YrjfvVIRYS+XMeNGld/tgRIZDTM3r/o0Z2s9XoIGHOIXZd
	 qha0vc1FwJ+ByOw3yVzSu07wp+9Netgo50vIEuMBxSLK8XdsSQCj4zU9wTb+oQbmxp
	 a2kWgzbgf3Mh8E1Zhx3+jbkEqubYLMecu/1TkfcuPeQK+pCb6W/+1scLP/wqnKxp7J
	 MhC663Q2WfzSAUeSsag7FYxoqlc3+Cpmk2V2gI4flcdMnFmt0I17JeFgCzkQt4r8Pr
	 SGNNlUu0xtDUwvRdCmcNobz8W6yhgjYjrYFwv1B0Maqi/RuI0/+WSRaX1pfDg2xFqu
	 0RD38vUJcAIAw==
Message-ID: <6a5f24b3-4777-4ed6-bcaa-a65740046ae6@kernel.org>
Date: Wed, 10 Jun 2026 17:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-pmp: add JMicron JMS562 quirk
To: raoxu <raoxu@uniontech.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <71B4D0BBEC4F886F+20260610052835.1111181-1-raoxu@uniontech.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <71B4D0BBEC4F886F+20260610052835.1111181-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/10 13:28, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> JMicron JMS562, as used in QNAP QDA-A2AR RAID1 adapters, may
> keep the exported ATA device not ready while the array is rebuilding.
> 
> In this state, libata may repeatedly try to softreset and classify
> the fan-out link.  On the affected adapter, this can time out, make
> PMP/SCR access fail, and eventually disable the fan-out link before
> the RAID volume is exported.
> 
> A failing boot shows the fan-out link failing SRST, PMP access
> timing out, SCR read failing, and the link being disabled:
> 
>   ata4.00: softreset failed (device not ready)
>   ata4.15: qc timeout after 3000 msecs (cmd 0xe4)
>   ata4.00: failed to read SCR 0 (Emask=0x4)
>   ata4.00: failed to recover link after 3 tries, disabling
> 
> After that, the root filesystem on the exported RAID volume cannot
> be found.
> 
> Add JMS562 to the existing JMicron PMP quirk that disables LPM,
> avoids softreset on fan-out links, and assumes an ATA device.  This
> prevents libata from dropping the exported RAID volume during rebuild
> recovery.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

It is really unfortunate that JMicron keeps having these issues. But I do not
see any way around this, so:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
