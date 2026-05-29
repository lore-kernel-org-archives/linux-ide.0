Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36994372EF3;
	Fri, 29 May 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036183; cv=none; b=FrCwSBnpgKuDtHEigOEahAjuJXLKG30VNyouSp9bONhzdTUbmhId6YsFlD0KY4GmR/StTa5+GKwRpIF8jkmHxgZJ/eoXMBTk99Axk0WlkEY2sLtW/V35HIOhBP8qcVFNoVE5TY4ZA2s2/BIv4CLdvf65eE4w61QKJITH8guTnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036183; c=relaxed/simple;
	bh=euI/kVh7/IWSbhtth1fRctL0z4xH1XBzdenY4fefq/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgEYM5TiW6mJmWeEWaF1WKenze/9RQlCCcC8NaaYHbUxUWLRAblNtoGAgdgyBehp4z+mUMc7Wlf6FPmPknU3I2BlBTQU9VOv4buMAaI0Y7UZ/3xZGr+9MvL1F1RGgQ6+GfFEHT0Kf1C/lhrC1XYtqfDmvymvC9mQ418u/Rn3op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNOX2+gw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNOX2+gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F171F00893;
	Fri, 29 May 2026 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780036181;
	bh=JYuneFbbRoRmXfW8r79DZBZ4fh9v/4Lc3AyYeTXRpSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hNOX2+gwhO/2UKDmjwXYo1jCzQkk9WNibJiKxbDmK4UrLLtAB/f9TJN5X6+msu1zg
	 dSpm0Zlc8EBRlHcVJ6hAsrK1BvMr9V0r2Xya3L4vwOI4ckf8Fjdr+tqXKkciV8Fmzu
	 MMZskFZrwar2fnckiGTZpR+hhQqezvMp5v3EpJLAJdvZVy9Bj0Rpjd6Iqbx7Br1TFn
	 QeSBuZ/2vVJu4Idk+dh7G54J2LiDjbh77LohXPpSvvHjoyF/h2S0eiEQ84DwhKbKCP
	 kSLFzkpSTBm/GtldFK46jEZpFIuIN7GW1K/aqyHhLGRzPJtKN36dglBUt5CM0wPDgC
	 2XS/Fhs96C/zA==
Message-ID: <d00202f9-e0e1-4ba9-8620-eacf168e4556@kernel.org>
Date: Fri, 29 May 2026 15:29:39 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: use hweight_long() to count port_map bits
To: kensanya@163.com, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 TanZheng <tanzheng@kylinos.cn>
References: <20260528060050.743599-1-kensanya@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260528060050.743599-1-kensanya@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/28 15:00, kensanya@163.com wrote:
> From: TanZheng <tanzheng@kylinos.cn>
> 
> Replace the open loop used to calculate the number of set bits
> in the port mapping with the `hweight_long()` function, which
> simplifies the code without altering its functionality.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: TanZheng <tanzheng@kylinos.cn>

Title: I suggested:

ata: libahci: ...

You did not fix that.


-- 
Damien Le Moal
Western Digital Research
