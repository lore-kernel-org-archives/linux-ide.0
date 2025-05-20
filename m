Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58101267F59
	for <linux-ide@vger.kernel.org>; Tue, 20 May 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733825; cv=none; b=QCNa8cRw0o9xCCwjPwcRciFJsXmA3iMSEtciqJmw5wr5JMUvaAc9x4YncoRLXK0Gu38f04sPMyPz2jgoDWSkRYXLsKfTl/dQwJyfhSvxSpMzCg36c14kR7wCVBABX2UdYiMcI2KHMId8jLX2Lh6RzPvJVwHkMZD9VEflwySzyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733825; c=relaxed/simple;
	bh=JpgEmSVr6oDA6PFAURqktOxAajfSXFc/uWQJs8OgpKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfdvkC9EN0KkzohDkDb5ceay0y4YhnX1yRqIW52bAMNzn6B01RiEHNEIGn8vZ2S6/Ae48GvvslzWSUxaJHsQfTXisDqpbLewNndiO2MBYtBWgw83RNx8ndVjSAeahXT/6XcjuzbfvrTRNWo8fPmb917UCcVLhsP9BBqgLK2QRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvC1B07t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvC1B07t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9C6C4CEE9;
	Tue, 20 May 2025 09:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733824;
	bh=JpgEmSVr6oDA6PFAURqktOxAajfSXFc/uWQJs8OgpKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FvC1B07t1Scw1bogmirFkzn1o/OrpV1H+zZSxnOPErMkUafcj2FIocPWnoJzeQeVC
	 423hTgv8NOjbEyi7X9QUYzXCRs5pz33imlQzDGaQnlUKQgA8qNTOabFHqhp+JaZDH+
	 3OI0S1ZRnESQUnwLxC3HIOcfw3e/5allpBYXJoYkcxOvEVjymy9vP/xZJ/ZrKvhf0B
	 TCURBXsRWKJCzZ7oiNhkKbBOg0dkUFkDlbt2n2+kdUqdkhIj75MM3D2pujFNidFd3J
	 02aVx7bnSN6izdCTMgNoKy8/T5IfFSwJjtVVNJeKi0SmSfx3ik8noWIfpobqC1GsAv
	 vxWzMqdpo9jFA==
Message-ID: <564db25f-fcd3-4521-a320-48a9a23c84dd@kernel.org>
Date: Tue, 20 May 2025 11:37:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] ata_eh_set_lpm() cleanups
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
References: <20250515135622.720623-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/05/15 15:56, Niklas Cassel wrote:
> Hello all,
> 
> I was trying to understand ata_eh_set_lpm(), and decided that
> it needed some cleanups to make the code more understandable.
> 
> Please have a look.
> 
> 
> Changes since v1:
> -Squashed patches 3 and 4 as requested by Damien.
> -Squashed patches 6 and 7 as requested by Damien.
> -Changed WARN_ON to WARN_ON_ONCE.
> -Changed patch 1 to remove parts of a comment that is no longer true.
> 
> 
> Niklas Cassel (5):
>   ata: libata-eh: Update DIPM comments to reflect reality
>   ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
>   ata: libata-eh: Rename hipm and dipm variables
>   ata: libata-eh: Rename no_dipm variable to be more clear
>   ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM
>     states
> 
>  drivers/ata/libata-eh.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)

Applied to for-6.16. Thanks !


-- 
Damien Le Moal
Western Digital Research
