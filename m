Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405C3A8C8;
	Mon, 22 Jan 2024 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913371; cv=none; b=cc682AcJ7u3jqeQzehS5g7ZQKrTxBGmOL/3UUB7DQggEenJK57P6fFfogxV42wK36fgD0rkBA/YiJLHtyzs8y3h+k3qYAky+SFT6EBUSCyJ4JCewPOvYy6YueIJexhjISaWfI+38BQyudJixV3oSQbJzTEAw9xYtZkDHfgHKNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913371; c=relaxed/simple;
	bh=Ob0XXQMHVC2cl42Z2WI1R1taCBz3EEQ2JZoG9tlBUuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2Y0KmfICZwv9s8YihsAw8CKT6a5fuiymphVoP5rSBd/ufrvQam9y2R4k9PDUHE6d2A64qv13INsI9bipLUgp3xD3tZpe6tS/H2geMk1g4Jm2dEpTSDUnlUuLfMEh4dwYaMfGgFucCn3nwnFfhU8ASx8zNG6CbzJ6xDtPVDDNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXsHA+Pa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXsHA+Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12464C433F1;
	Mon, 22 Jan 2024 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705913370;
	bh=Ob0XXQMHVC2cl42Z2WI1R1taCBz3EEQ2JZoG9tlBUuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZXsHA+Pa0r05GmKftICZNf9TxyzGomljODQMe8l+uU2jXkE0ebBXjQwLj81s/3OaP
	 bqeD0vY+f3+fVszN3eEoDjSV3PStSBl3sjIZxuLVjKwO3moCldn/xEythXd7F1vu3r
	 P/MoinU/zef12vpamA9jynzYNZxO3N9nzXsSFqQVIiJiUZbxGHVEVZb+fxVTjXxp8S
	 pkNOUCuGlcObvb9nR5cLuZUesCqacPseUfdn7bG2zwbRdjPTLc/2uMB6uInKxxVIKx
	 uM+MexEptfrVFXMlNttn821xT3bg7zJSRq4JxsDXStdeoI0xUJnpFOYgLHKYNIqGmf
	 5Kbc4La8DK8VQ==
Message-ID: <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
Date: Mon, 22 Jan 2024 17:49:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Power management fixes
Content-Language: en-US
To: =?UTF-8?B?546LIOW/l+ixqg==?= <wangzhihao9@hotmail.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
 linux-regressions <regressions@lists.linux.dev>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/11/24 21:09, 王 志豪 wrote:
> thanks a lot！I will take a try and reply you soon

Did you try the patches ?

-- 
Damien Le Moal
Western Digital Research

