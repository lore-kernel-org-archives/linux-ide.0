Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387133;
	b=EEFYl0RJpAxBdBDe/1ZkxwwVnxksIuJ2kzTqn/XGttwHU//oqo0RAnOtd17qKvIOCL6P
	 8T0fOiAp2rARPrtxM96TfADKXKziZyuEPuzGDNTjd4dfAF9Sq/Ew+iZo40vV88RP28MDw
	 M+WA2NMSUxqwgDd+8g7J0IZ+qKDxkVt5MuyB+KoQzkbHzg8UMUpHV6QP/k40wYj4on+wL
	 3gvezLv2JmUexsgAhfTeaZTH0QylQmwd5OkuJn3vxqpF3LGpdL6wks1MPiHkLaHJz/QVE
	 6U3Wg55pcfcBDmSCsteupLdkJ7M0BPFlMdeJLVmZOyo8I2i8GKz3FgTQewUotin7KIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387133;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IsZlJEznupX65MpAD2DtsJopcnEgKKo3eP9+5upIq+E=;
	b=fw+MJBjlEi50nLxvQCP4NfizaJ8cagcGTvDwf6TP9ZeIBTgEetfURbxNPt3JWgZFBaot
	 6Tuec7LH1VV/1nYGfyjbZG3m4/0kpHSeLfZwgvzGrHSENUPVB96f9DgoOr+KYlHDyDF3W
	 MmsKohX5v0razRkE0mYSsWmgi2JcjNsy6Z0FNUNZ2TmWHeC1wsmmA7OlrkXMAzEQ8eo6c
	 K3M1QBF7Doc7p/qlrGF9zLiloVokOI5VqOPxY3gFtjrNw91ad1Kv9soo74+cbzibH417t
	 iPxSrqqrbmXY9BWLwHiQMEIpjNq4A0d0zzXOviDzpENGAePoblGu4NzsUx7HNw9NrIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUTHK0BN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E9606A321
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUTHK0BN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE5B1F00A05;
	Wed, 11 Nov 2026 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794387133;
	bh=IsZlJEznupX65MpAD2DtsJopcnEgKKo3eP9+5upIq+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LUTHK0BNjTOUro7c+S35NcHEc+WkYnup/QRoxNQUzq2ZrYVl1pd8idjzaeSaLBy1j
	 TaSuvJKOXku8CXaKgzoEqg7T5yLiad7EvOEaAUkfWQKM8I3EYWQUlRgDC6S0WmoAdF
	 QFNe4xGg72gD0Q9WZsliWlZkOmjOUOPHNJTvNvOpJBtQWAG+7aPu5KDbSyFXs/s5bS
	 b1wT7b/og8usb6u6YFI73oRR6Na9Xjle/sr6HIKtJU6XFAxnM39MclxYk5/K1YBK7h
	 AibD/bIu9xZHH4U34Kj/hciF7Q+iDRVZsOlqBUTtjCn8N0XWScjNYlea7R+OG6CAUU
	 ErEktBpOn0gfQ==
Message-ID: <425aaec6-89bf-4150-ab87-360cc30dc72a@kernel.org>
Date: Wed, 11 Nov 2026 17:52:11 +0900
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
Subject: Re: [PATCH] ata: libata-scsi: reject non-PIO protocols for READ/WRITE
 MULTIPLE
To: Niklas Cassel <cassel@kernel.org>, Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: linux-ide@vger.kernel.org
References: <20261028140432.20489-1-zhaogongyi@bytedance.com>
 <avLYvtmnedp5FXSX@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <avLYvtmnedp5FXSX@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/10 17:41, Niklas Cassel wrote:
> There is nothing in SAT specs that requires us to validate the protocol field.
> When using normal (non-passthrough commands), the protocol field is initialized
> by the regular SCSI to ATA translation done by libata.
> 
> For passthrough commands, it comes from the user.
> 
> Not only does it come from the user, it requires CAP_SYS_RAWIO:
> 
> scsi_cmd_allowed() {
>         if (capable(CAP_SYS_RAWIO))
>                 return true;
>     ...
> 
> 
> (ATA_12 / ATA_16 / ATA_32 will all return false, so not allowed for a regular
> user.)
> 
> And... even if the user sends a command with a protocol that is not as per
> ACS spec, the command should time out and EH should reset the device.
> 
> 
> So... If the user sends a passthrough command with the wrong protocol...
> Well, that is on the user, no?
> (It also requires CAP_SYS_RAWIO)
> 
> 
> If we were to add protocol checks all passthrough commands, then we should
> not only check READ/WRITE MULTIPLE, we should check other commands like
> WRITE SECTORS (30h) and IDENTIFY DEVICE (ECh) too.
> 
> But, I don't think we want that. Damien, thoughts?

Unless we are talking about a command that libata-scsi emulates, passthrough
commands should not be parsed. We do not want that. So unless the bad SG_IO
command can crash the kernel, we should do nothing if the user sends a bad
command and it fails. We can let the drive fail it, even if that leads to drive
resets etc. As Niklas pointed out, SG_IO is priviledged, so it is not like any
user can create a DOS with bad SG_IO commands.

Also, the use case for this is a little silly in my opinion... Who wants to send
a PIO multi-sector IO using a modern command like ATA 32? libata supports that
if that is all that the drive can do. If the drive can do DMA and/or NCQ, then
better commands will be used without relaying on a PIO passthrough command.


-- 
Damien Le Moal
Western Digital Research
