Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848338;
	b=XO6oXmjFuudKy0QxR6hxY2xTza57X18Vq/XeHry0Qdyi0lrc1Qh9jS5U7mSw+yp+CuPJ
	 Ppr9CEfL0U/L9lql/5nRO5Kq7Aq/xhAMH7+oeb34UFTRxNEUrpMAJjZdjLYm6xdKVKEXa
	 u+1vgWQjegrOf9xWzwwuFA86mNqrJNAtJiJIHIYxkYvksbWi/v4TOrC4axjWJMbtdrUHY
	 njYR451x2RasfNwyIEFRi78xAWNfmGk+apDHP/iTs1KjHImaYBU3DZS4JKrQ1iPAEe1Oq
	 LsMUngxm1AfDntih76JW9dBJ5n1MyX1nDq6sfOiXxXeD0t5TF02u0L0lLXEssrllDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848338;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1vTevLB2CeNoCRTwyUeG/ztOLXy0nV3APfp3h1bILGs=;
	b=VgLYYRv9ACbPvJZD8lITKcIpf9B8WnvVBQtlJLrAGdBdK7pcJV9UnCdhZCLu2/2GP3Up
	 ixF5UVA9WrPlUax8lvcmFYuEO4Qy9p2dQGSv/MNji5lqbsd39S7vpj7suxu6eOR3a/Nmw
	 hylTSlyIa3L29Is8a9K80fYy5vkqOW0dXee7Q3sn37LfnbDEJ7Z6rmqRT8eIz++AHUozC
	 uWO4t/sknmbtcnCrLtg2DV3HTULOh280KfZ6b9TFj+Y00am8yHSlZgOm3TqOWg1Cef2KE
	 8vaAnKcyyVAAf4L689fMZaAVdJLhvokbJLqSDXwHFtKOLjsyXnKBZaF+AoENO1sXjlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoG+4f3k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641F606A31B;
	Thu,  5 Nov 2026 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoG+4f3k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51021F000C1;
	Thu,  5 Nov 2026 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848337;
	bh=1vTevLB2CeNoCRTwyUeG/ztOLXy0nV3APfp3h1bILGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hoG+4f3k+9z9HlqsBuET2vPX0/5gqtTNQi/M/9KdBM7tQE0xcDCSNgzfXjnZGfZE1
	 tbqYso1/i7EbEgNEzCjH5AyAXbav4i9LcZyk5bwa+3uoWHzmWoAkpsOHdnrQLYhuyA
	 KeIQ8JHhrQc+gyfknuqM6F4aRofHcNI4BwhW4mqXiIfqdTihZl/fSYEwN+kodWjGYw
	 4UOmsPZtwDuOPbV1YE2vK2qDsw1Pxf2Snr2B2LKj0bWQC9VcsvyYjbt1dQPcUqRVmk
	 OQn1W34qOsP5Gz8dCGzVePPfcBLEtUG/fHizbELxlByOCyEWmtLXzKoldXtE3O3/md
	 yLk/IurF3nu5A==
Message-ID: <63b1f8c3-49b4-4702-abb1-04fd39511095@kernel.org>
Date: Thu, 5 Nov 2026 12:12:15 +0900
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
Subject: Re: [PATCH 1/3] ata: libata-transport: drop the dead GSCR newline
 check
To: shao.mingyin@zte.com.cn, cassel@kernel.org, hansg@kernel.org,
 linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20261104211438037bcIKTaLPaIlyGxIkLtstZ@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104211438037bcIKTaLPaIlyGxIkLtstZ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 22:14, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> SATA_PMP_GSCR_DWORDS is 128, so "SATA_PMP_GSCR_DWORDS & 3" is always
> zero and the branch is dead.  The loop already terminates every fourth
> dword with a newline.
> 
> No functional change.
> 
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
