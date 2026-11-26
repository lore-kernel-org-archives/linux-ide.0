Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678031;
	b=0junVeob2JBPMQE1DHynCHK23WdDO5svOddeYx2gDYlIBZgAp+QNSxoqAuVzYOwknSXY
	 U4oXPjaYOzmGm5JjexIVhlcdufxbkDZbeQ3Z+EPsuZFNwtIMfmYBaURp6Lfx2q45Ceu1n
	 B9ESQ/YUGchFNPHZSK3MIpX6D5irntZvvY+te7/hqhbSJhIHVl8pOTP8uval/gNrvoM2O
	 Ry3Y4df+EPpLl08spCXbtgjzYrPa6TC9u/NqQeaLnF/I5jr7YVG3oLerjGkE8qDkw8mB7
	 iBoab/VrYd3rU7enrVMp7cDVxRbjmKRi4o19CM8rty1iDFjgEJEKAgjuCEscUntkddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678031;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cmPY4QDPtdM0XMXGNU9L58kAlZVRjTPCw2c3Xpio24U=;
	b=Pf9hqkWsTtkuWyJ86GLTxL/DmYvT11OnT4fn6IhOpY1iPz1HwMCqq6AqOdNiBFAf6BEv
	 pjBy6m2FlS0BWD2DRlLU18h5h19CVEr34Bs3k4yW+7DFsxX/DC1WMECiNV2le8rhn7e5m
	 XYEGhTw8kdqCCETPpl2MJt3amY4vZVz0ls2dhVsv8AlPQYvLH0aJ4l+myI+oTCfnxI4hb
	 f5DW8FlESdxAbsgwTkuy0MODaiLXMYK6xkAL0jqgoemtTIGtFkSBEjquN/9MySJKLzdYd
	 dfFHrie5O2Ca48aHsL0z6+ldtONri2a/pEmd6CjHLGyqXdyVcOqwnCts/x+6siF4Okw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaR5vkDc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BE606A31C;
	Thu, 26 Nov 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaR5vkDc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ADC1F000C4;
	Thu, 26 Nov 2026 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678030;
	bh=cmPY4QDPtdM0XMXGNU9L58kAlZVRjTPCw2c3Xpio24U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CaR5vkDcK8DX1g6CofEhchUe0WZg3fhjOQl12aDqve8WcnlWI29SoI6FetotC/jdj
	 EJp61WAbV/Rvc35vMn/GTH1TnNaaHcBu1mgJZH54yP+TqF+jLXaUq5QttxPtxRltyR
	 qeHk69joJaMulJYyjbEqtcOCEwSPm45SZOY0Vzl9h2hmi6ttq/QssXKoZbcEm11EqO
	 gaEnt5NjxNtyaMdQAWOdMVKAv+aWyLsO82DuXPxpFkwri6Em7F4bY5dY+yoijSrBOE
	 sgFSg4Td/L5pHsL0bglzW2sLRUEcj9sReau81OQAcAUyJgVETrbiJIcYWxyGxgJWqx
	 BJLnZMw8gAmXg==
Message-ID: <9804a400-073e-423a-a501-86a3a20a485e@kernel.org>
Date: Thu, 26 Nov 2026 16:27:07 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ata: pata_arasan_cf: add missing newline to warning
To: Artem Novak <artem122novak@gmail.com>, vireshk@kernel.org,
 cassel@kernel.org, linusw@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126051523.14431-1-artem122novak@gmail.com>
 <20261126051523.14431-2-artem122novak@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126051523.14431-2-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 14:15, Artem Novak wrote:
> Terminate the clock-rate failure warning with a newline so that
> subsequent kernel messages are properly separated.
> 
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
