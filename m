Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848370;
	b=mWg1s3FO6wd+VkeoqxvVuT3ztTVBfgTxbLKDlDa2ROYn9TAGWx4Rk8QzTqbPkxrABF8i
	 zrJfTbX6IZX6j/NJRTDiYCYt8mQzSO4PF6Kgj5dcQsDf41RWzTa4VMfQHC3zAU8if1ZxX
	 hPcGE6Ym2AV/qFG9zkWIZ4DMdv8QZQ8JZILgetTZNQQwgZ8mHgHsKP2wfTAAvhWlg5HPB
	 +rRo7gF64kTdpELh9EA1+g+efUSIWtaIks0l1MkH208cV49FCET76jcdvYftGtSH/63eD
	 RfJxjg3ZRS1FI6wgrvW36Y+C9gZw4oqitHah8qWD1+MHoiS40OWD4HAvJLIRhOdGQWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848370;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wPzM3VrUAzCgIt/UzQFUdCzg5jFcKAARwB9R1iGT9Aw=;
	b=P2W4jHk24qNrIYOt0MRhfF8pDgOOp295oSVTGmRV5nZ9UYmau/VeAecweTO94+hWHC2D
	 z7LUMpIjNEjWpJNRltOJh24ebJZi4a7oZYVvKQBkOGNLzaq/Se+PYd22EeAf1POXRyJab
	 N/YB2diEPQKF/ihrkpSACvOGx2IeIcj4j/8XoL4hTVpMkg24OEHJoQjXd1vd3efkcLUA4
	 P+JFGHVGkPLYTuNX/lJSd9YGt5Oi6pYTH1Wkooallyjh3m/SQFCfXUZ4UO883q1eHeDIL
	 31WczgaD8tJMBhm5x1R9Og4vriE6PF7a2R137cR+l3KdnyCoAxTyiHWiuIaScIlwpAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZ7Um1PJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B065606A31B;
	Thu,  5 Nov 2026 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZ7Um1PJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36781F000C1;
	Thu,  5 Nov 2026 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848369;
	bh=wPzM3VrUAzCgIt/UzQFUdCzg5jFcKAARwB9R1iGT9Aw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GZ7Um1PJQDc2AEkv9HFk1hOP89d1efUSCT8EJ/+0tSwNDw3CvxQ+gx9Ad8GesQ95T
	 K9PbchOQPxcogKq3vT8CY8tT4mgGqgo+Y4jRG+rHPhfgliA9xHcXBcucaQbqFjBZI5
	 ln6cxMJlVts7Auvk5te0/yxXxoHimRom6PndGXEVZ8nxco0eXz4DFG+ltqwQ8uapCE
	 fEFg4F5fwCcw81G6KWFcoSCI9rCCZqqKxlRuCkjJc3E62499aAOQ3a2hDCe4El0Q2r
	 mn0snelLWdH9SIMIDG6OiVcNpM91PXujSOHvl4bHexPiSndp+Q3gYmVjB+42Kdsm9R
	 P3yDHKKqoGm6A==
Message-ID: <3183b7c5-a461-4816-8f5a-0783c29e274a@kernel.org>
Date: Thu, 5 Nov 2026 12:12:47 +0900
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
Subject: Re: [PATCH 2/3] ata: libahci_platform: drop the dead error check
To: shao.mingyin@zte.com.cn, cassel@kernel.org, hansg@kernel.org,
 linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20261104211439250EftPg5v8hldkC4dnKtOxA@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104211439250EftPg5v8hldkC4dnKtOxA@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 22:14, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> IS_ERR(hpriv->ahci_regulator) is true here, so PTR_ERR() is negative
> and "rc != 0" is always true.  Jump to the error path directly.
> 
> No functional change.
> 
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
