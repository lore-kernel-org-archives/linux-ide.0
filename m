Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E53B6C05;
	Fri, 18 Sep 2026 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698246; cv=none; b=r3qObEvMwL34rOFMCrqo/rAIIKrWFqoB0TsoRN1kkDB+DtdLtpReSaExOrdv268heb1q2xSrPqndvqrkwY8oiC6ymR1eG4uBFHl17UEOlpGpNvjS8R6jsGfjtsK4p8qzvStIFTPF+pN7AZhMS+79Lymc9SCwjmMXldKmTzS9/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698246; c=relaxed/simple;
	bh=Y/jjGv/lN/JLwFjEAeAQa0o0UqyK9AVs57LxUccj5VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcLb4x6+Z+m5hUg1kkcfjPxGH1IHqgqgQu78U3z9qrFx2v2FjjbjbVSpMp568Zhe0Bax93VUApX6JdRBtdi+JPNI4PTDYm0fdbhFVr7syIss/y3QyiquPL7wO6pjfiZDQ/PGCKSE0dMCE/9OsaOhLj0LJIPOWpAA3zNs8lRVqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaM5uDr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaM5uDr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FE81F000FF;
	Fri, 18 Sep 2026 02:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789698233;
	bh=ufhh0IRoPGbjH+WNiWiGZNlEAovukATyulBkyAR59HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EaM5uDr28q5Jh4vJslw/tNZjQfTNh97KvtR0ocPVw7u3nlgNXdbhCyj3E5usKZAMa
	 hr9KcSheNF9dtIu8re5Cai4FK9Ou1Ix2bb6j6RGx0O8kLs6qXkdwTJCO6qL1NeDsu3
	 fOpMRds2Y4BiZFGRUMil2ezpaaCFyT7YTx5G5LvO449BNlZJX2TIcqJYmJxt3XGola
	 ASxDxdhU5KjlZSGQgtYMsc6srXft2dHbotSwmoRKaeT1k0vVohbbNxfJcj5FonhcxF
	 WVRYJA1R1R1cVj3ZyQijF8YUZp50JSj9yMNhKwH7jMuN3Br7DsCvScbinLo7/1cEmU
	 agncfdQNcHptw==
Message-ID: <e94a6a47-42a7-41f6-8cc6-4b2cf4e13f22@kernel.org>
Date: Fri, 18 Sep 2026 09:23:47 +0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ata: pata_arasan_cf: use standard DMA engine API
To: Frank.Li@oss.nxp.com, Viresh Kumar <vireshk@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER"
 <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20260917190315.1188379-1-Frank.Li@oss.nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260917190315.1188379-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/18 2:03, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> DMA engine consumers must not call the channel's callback function pointers
> directly. Use the standard dmaengine wrapper APIs instead.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
