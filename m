Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848418;
	b=i+lCwVc2aUZSUkSscPRuhbbpThBE/zLLuhddYbWSa34vapbN9zN7xWKhhx78FvJNz2PX
	 vE83pWTy0Ykn5ZAVwXA7f9cqgNjyCaKPXH6UMnsAB9zKY1pALQ4J5CktGceazQ1GiG+n3
	 588QTY3VbuRcn3SHeql1J/POw+lT68SHWc72JpXz0S9kdN8iy4+cedhxSlPrLoBjOqGsZ
	 r4YcCfwjOChtUsqdcZPltve+V2a1nFLEe+gFhP76D9qqEsBRRVMhHRsku74fdlmnFAgBI
	 9S1A6eo5MdrOmt4BZIgyVxwe+qPWjpJ6T9IybtuL1Zoysy8lse7KSIal7UaJaeyTvAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848418;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=doSrNQ+z0DNvupZg6/mbHWnfHaFfZ+Y5T7z4yZ83SAQ=;
	b=C2swpbtQ5Ho+lfWTGTnxC+xhFIx24rH+7gpCVHsgy2/TkaibOVm2o19FqHHKbzR7klbf
	 Rne4KLFUauUS+3PSRnVFTH6Kska/egGrCmIhBioMJ6KSXxTW9eZQIhlYFlc7FM244nOnU
	 2CPlcTdBPm6bFdPYvZSsgC0Ip+Al3wxepwhrwd9+E6/maj7ijLg1QB7FOTPw74THDqsCU
	 A9d/C5QL1vmh1L+cSiaLSo0LRTplu3s0/Z+Z06qvtqu7PHmGCP1VpITAo/Wa2knyqI0HX
	 Ns6oXi5uV3Qk9qYuXrD+YpWTSkvHuiiHvSjsB9bKY63eTQP/TDknvktjfGODZG5UbAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9WhvyTw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F60606A32E;
	Thu,  5 Nov 2026 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9WhvyTw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D05A1F00A1B;
	Thu,  5 Nov 2026 03:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848418;
	bh=doSrNQ+z0DNvupZg6/mbHWnfHaFfZ+Y5T7z4yZ83SAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i9WhvyTwxgAast8r1E0y49N8GvDrC1rJ74IHdank/fP0RXJsu7OhnO+iOAXH0YurQ
	 zvdvTqQNe5kApU5hA3o4RdrcfJv5uAALKnPDT0hkbWO81n/Ivdnx2+ftkW/A9GAGHb
	 HCATheUzymcdu+5oPtoJLlz74LuURS8iYoxr19l71Tz+e3H2a0bUNs54p4emaPH9Wb
	 YW/r+X/hP4xhIh+DjFxi10q8Ctld5r2iSWuVRdeFKbMjYscd+eFWDUXYt/04J31Mhr
	 uiWtZabipTyp7i2rI2Jy3B24OG7KUk20rmxcpkBiO5IJmt7s76I2kbU3xchDs5qLjs
	 h7ztxgGx0MWQA==
Message-ID: <908bb7e3-b36b-43f9-9f3b-b407e08185e4@kernel.org>
Date: Thu, 5 Nov 2026 12:13:35 +0900
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
Subject: Re: [PATCH 3/3] ata: libata-zpodd: use a single exit in
 zpodd_get_mech_type()
To: shao.mingyin@zte.com.cn, cassel@kernel.org, hansg@kernel.org,
 linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20261104211440455JCTCACMo5nXzgNNMAxIiJ@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104211440455JCTCACMo5nXzgNNMAxIiJ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 22:14, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> zpodd_get_mech_type() repeats "kfree(buf); return ..." at five
> points.  Use one cleanup label and return the result from there.
> 
> No functional change.
> 
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
